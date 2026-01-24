#include <LGP/LGP_Tool.h>
#include <KOMO/komo.h>
#include <Kin/kin.h>
#include <Kin/frame.h>
#include <Kin/viewer.h>
#include <Optim/NLP_Solver.h>
#include <Core/graph.h>
#include <Algo/spline.h> 
#include <filesystem>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <Kin/F_qFeatures.h>

namespace fs = std::filesystem;

// 重采样函数保持不变，因为它不依赖 GUI
void resampleAndPrintTrajectory(KOMO* komo, double speed_scale, double freq) {
    if(!komo) return;
    arr q_path = komo->getPath_qOrg();
    arr times = komo->getPath_times();
    if(times.N != q_path.d0){
        times.clear();
        for(uint i=0; i<q_path.d0; i++) times.append((double)i * 0.1); 
    }
    rai::BSpline spline;
    spline.set(3, q_path, times); 
    double logical_duration = times.last(); 
    double real_duration = logical_duration * speed_scale;
    uint num_steps = (uint)(real_duration * freq); 

    std::cout << "\n>>> V-LGP TRAJECTORY START <<<" << std::endl;
    std::cout << "DIM: " << num_steps << " " << q_path.d1 << std::endl;
    for(uint i=0; i<num_steps; i++){
        double t_real = (double)i / freq;
        double t_logical = t_real / speed_scale;
        if(t_logical > logical_duration) t_logical = logical_duration;
        if(t_logical < 0.) t_logical = 0.;
        arr q_smooth = spline.eval(t_logical);
        std::cout << t_real;
        for(uint j=0; j<q_smooth.N; j++) std::cout << " " << q_smooth(j);
        std::cout << std::endl;
    }
    std::cout << ">>> V-LGP TRAJECTORY END <<<" << std::endl;
}

void writeCleanKinematicState(const rai::Configuration&, const rai::Configuration&, const char*);

int main(int argc, char** argv) {
    // [MODIFIED] 绕过模板链接错误，改用 params 注册表设置
    rai::initCmdLine(argc, argv);
    
    // 这种写法在 rai 中是最稳健的，直接操作全局参数图
    rai::params()->add<bool>("noshow", true);
    rai::params()->add<int>("v", 0); // 顺便关闭冗余的 verbose 日志
    
    // 如果你还需要彻底关闭所有窗口初始化，可以加这一行
    rai::params()->add<rai::String>("gui", "0");

    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <task_dir> <input_g_file>" << std::endl;
        return 1;
    }
    
    std::string task_directory = argv[1];
    std::string input_g_file = argv[2];

    arr q_home;
    {
        rai::Configuration C_home;
        C_home.addFile(input_g_file.c_str());
        q_home = C_home.getJointState();
    }

    std::string temp_state_file = fs::path(task_directory) / "temp_state.g";
    try {
        fs::copy(input_g_file, temp_state_file, fs::copy_options::overwrite_existing);
    } catch(const fs::filesystem_error& e) {
        std::cerr << "Failed to create local state copy: " << e.what() << std::endl;
        return 1;
    }

    std::vector<fs::path> lgp_files;
    for (const auto& entry : fs::directory_iterator(task_directory)) {
        if (entry.path().extension() == ".lgp") lgp_files.push_back(entry.path());
    }
    std::sort(lgp_files.begin(), lgp_files.end());

    // [MODIFIED] 删除了 shared_viewer 的定义

    std::string& current_state_file = temp_state_file;
    double SPEED_SCALE = 1.0; 
    double ROS_FREQ = 500.0;  

    // --- PHASE A: EXECUTE LGP TASKS ---
    if (!lgp_files.empty()) {
        for (const auto& lgp_path : lgp_files) {
            std::string current_lgp_path = lgp_path.string();
            try {
                rai::Configuration C_initial_step;
                C_initial_step.addFile(current_state_file.c_str());

                auto tamp = rai::default_LGP_TAMP_Abstraction(C_initial_step, current_lgp_path.c_str());
                rai::LGP_Tool lgp(C_initial_step, *tamp);
                
                lgp.solve();
                PTR<KOMO> solved_komo = lgp.get_fullMotionProblem(true);
                auto ret = rai::NLP_Solver(solved_komo->nlp(), 0).solve();
                
                if (solved_komo) {
                    // [MODIFIED] 删除了所有与 viewer 相关的代码
                    // 不再调用 get_viewer(), set_viewer(), view_play()
                    
                    // 计算照常，直接输出轨迹到终端
                    resampleAndPrintTrajectory(solved_komo.get(), SPEED_SCALE, ROS_FREQ);
                }

                if(solved_komo && solved_komo->timeSlices.N > 0){
                    rai::Configuration C_final_polluted;
                    solved_komo->getConfiguration_full(C_final_polluted, solved_komo->T - 1, 0);
                    writeCleanKinematicState(C_initial_step, C_final_polluted, current_state_file.c_str());
                } else { throw std::runtime_error("KOMO invalid."); }

            } catch (const std::exception& e) {
                std::cerr << "LGP CRASHED: " << e.what() << std::endl;
                return 1;
            }
        }
    }

    // --- PHASE B: HOMING ROUTINE ---
    try {
        rai::Configuration C_end;
        C_end.addFile(current_state_file.c_str());
        KOMO komo;
        komo.setConfig(C_end, true); 
        komo.setTiming(1.0, 20, 1.0, 2); 
        komo.addControlObjective({}, 2, 1e-1);
        komo.addObjective({1.0}, FS_qItself, {}, OT_eq, {1e1}, q_home);
        komo.addObjective({1.0}, FS_qItself, {"l_panda_finger_joint1"}, OT_eq, {1e2}, {0.04});
        komo.addObjective({1.0}, FS_qItself, {"l_panda_finger_joint2"}, OT_eq, {1e2}, {0.04});
        komo.add_collision(true);

        auto ret = rai::NLP_Solver(komo.nlp(), 0).solve();
        
        if (ret->feasible) {
             // [MODIFIED] 删除了所有与 viewer 相关的代码
             resampleAndPrintTrajectory(&komo, 1.0, ROS_FREQ);

             rai::Configuration C_final_homed;
             komo.getConfiguration_full(C_final_homed, komo.T - 1, 0);
             writeCleanKinematicState(C_end, C_final_homed, current_state_file.c_str());
        }
    } catch (const std::exception& e) {
        std::cerr << "HOMING CRASHED: " << e.what() << std::endl;
    }

    fs::rename(current_state_file, fs::path(task_directory) / "output_state.g");
    return 0;
}

// writeCleanKinematicState 保持不变
void writeCleanKinematicState(const rai::Configuration& C_initial_structure,
                              const rai::Configuration& C_final_polluted,
                              const char* output_g_file) {
    rai::Configuration C_final_clean;
    C_final_clean.copy(C_initial_structure, false);
    for (rai::Frame* clean_f : C_final_clean.frames) {
        rai::Frame* polluted_f = C_final_polluted.getFrame(clean_f->name, false);
        if (polluted_f) {
            clean_f->setPose(polluted_f->getPose());
            rai::Frame* polluted_parent = polluted_f->parent;
            if (polluted_parent) {
                rai::Frame* clean_parent = C_final_clean.getFrame(polluted_parent->name, false);
                if (clean_parent && clean_f->parent != clean_parent) {
                    clean_f->setParent(clean_parent, true);
                }
            }
        }
    }
    std::ofstream final_state_file(output_g_file);
    C_final_clean.write(final_state_file, true);
    final_state_file.close();
}
