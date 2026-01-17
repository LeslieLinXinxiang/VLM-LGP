#include <LGP/LGP_Tool.h>
#include <KOMO/komo.h>
#include <Kin/kin.h>
#include <Kin/frame.h>
#include <Kin/viewer.h>
#include <Optim/NLP_Solver.h>
#include <Core/graph.h>
#include <Algo/spline.h> // [NEW] 引入样条插值库
#include <filesystem>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <Kin/F_qFeatures.h>

namespace fs = std::filesystem;

// [NEW] 高级重采样打印函数
// 作用: 将稀疏轨迹重采样为符合 ROS 频率(100Hz) 的稠密慢速轨迹
void resampleAndPrintTrajectory(KOMO* komo, double speed_scale, double freq) {
    if(!komo) return;

    // 1. 获取原始稀疏数据
    arr q_path = komo->getPath_qOrg();
    arr times = komo->getPath_times();

    // 防御性编程: 如果时间为空，手动生成伪时间
    if(times.N != q_path.d0){
        times.clear();
        for(uint i=0; i<q_path.d0; i++) times.append((double)i * 0.1); 
    }

    // 2. 创建三次 B-Spline (C2 连续，保证加速度平滑)
    rai::BSpline spline;
    spline.set(3, q_path, times); 

    // 3. 计算重采样参数
    double logical_duration = times.last(); // 原始逻辑时长 (例如 2.0)
    
    // 目标: 动作放慢 speed_scale 倍 (例如 5.0倍)
    double real_duration = logical_duration * speed_scale;
    
    // 目标: 生成符合 100Hz 的点数
    // 例如 10秒 * 100Hz = 1000 个点
    uint num_steps = (uint)(real_duration * freq); 

    // 4. 打印头信息
    std::cout << "\n>>> V-LGP TRAJECTORY START <<<" << std::endl;
    std::cout << "DIM: " << num_steps << " " << q_path.d1 << std::endl;

    // 5. 重采样循环
    for(uint i=0; i<num_steps; i++){
        // 当前物理时间 (0.00, 0.01, 0.02 ...)
        double t_real = (double)i / freq;
        
        // 映射回逻辑时间用于插值
        double t_logical = t_real / speed_scale;
        
        // 边界钳制 (防止浮点误差导致越界)
        if(t_logical > logical_duration) t_logical = logical_duration;
        if(t_logical < 0.) t_logical = 0.;

        // [核心] 计算插值关节角
        arr q_smooth = spline.eval(t_logical);

        // 打印: time q0 q1 ... q6
        std::cout << t_real;
        for(uint j=0; j<q_smooth.N; j++){
            std::cout << " " << q_smooth(j);
        }
        std::cout << std::endl;
    }
    std::cout << ">>> V-LGP TRAJECTORY END <<<" << std::endl;
}

void writeCleanKinematicState(const rai::Configuration&, const rai::Configuration&, const char*);

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);

    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <task_dir> <input_g_file>" << std::endl;
        return 1;
    }
    
    std::string task_directory = argv[1];
    std::string input_g_file = argv[2];

    // [Step 0] Capture q_home
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

    std::shared_ptr<rai::ConfigurationViewer> shared_viewer = nullptr;
    std::string& current_state_file = temp_state_file;

    // --- CONFIGURATION ZONE ---
    double SPEED_SCALE = 1.0; // [关键] 慢放倍数 (1.0 -> 5.0)
    double ROS_FREQ = 500.0;  // [关键] 对齐 ROS update_rate (100Hz)

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
                
                if (!ret->feasible) { std::cout << ">>> WARNING: Non-feasible path in LGP step." << std::endl; }
                
                if (solved_komo) {
                    if (!shared_viewer) shared_viewer = solved_komo->get_viewer();
                    else solved_komo->set_viewer(shared_viewer);
                    // 视图播放不需要变慢，保持 1.0 方便调试
                    solved_komo->view_play(false, current_lgp_path.c_str(), 1.0);
                    
                    // [MODIFIED] 使用重采样打印函数
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

    // --- PHASE B: HOMING ROUTINE (ONE-SHOT) ---
    std::cout << ">>> INITIATING HOMING SEQUENCE..." << std::endl;
    try {
        rai::Configuration C_end;
        C_end.addFile(current_state_file.c_str());

        KOMO komo;
        komo.setConfig(C_end, true); 
        
        // 单阶段归位, 逻辑时长 2.0s
        komo.setTiming(1.0, 20, 1.0, 2); 
        
        komo.addControlObjective({}, 2, 1e-1);
        komo.addObjective({1.0}, FS_qItself, {}, OT_eq, {1e1}, q_home);
        komo.addObjective({1.0}, FS_qItself, {"l_panda_finger_joint1"}, OT_eq, {1e2}, {0.04});
        komo.addObjective({1.0}, FS_qItself, {"l_panda_finger_joint2"}, OT_eq, {1e2}, {0.04});
        
        komo.add_collision(true);

        auto ret = rai::NLP_Solver(komo.nlp(), 0).solve();
        
        if (ret->feasible) {
            std::cout << ">>> Homing Feasible. Executing..." << std::endl;
             if (!shared_viewer) shared_viewer = komo.get_viewer();
             else komo.set_viewer(shared_viewer);
             komo.view_play(false, "HOMING_ACTION", 1.0);
             
             // [MODIFIED] 归位动作不需要放慢 5 倍，1.0 倍速(即 2秒)即可，但也需要 100Hz 对齐
             resampleAndPrintTrajectory(&komo, 1.0, ROS_FREQ);

             rai::Configuration C_final_homed;
             komo.getConfiguration_full(C_final_homed, komo.T - 1, 0);
             writeCleanKinematicState(C_end, C_final_homed, current_state_file.c_str());
        } else {
            std::cout << ">>> WARNING: Homing path blocked! Robot staying put." << std::endl;
        }

    } catch (const std::exception& e) {
        std::cerr << "HOMING CRASHED: " << e.what() << std::endl;
    }

    fs::rename(current_state_file, fs::path(task_directory) / "output_state.g");
    std::cout << "Node Execution successful! Final state saved." << std::endl;
    
    return 0;
}

// writeCleanKinematicState implementation remains same...
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