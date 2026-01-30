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

// [HELPER] 轨迹重采样与打印
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
    std::cout << std::flush; 
}

void writeCleanKinematicState(const rai::Configuration&, const rai::Configuration&, const char*);

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);
    // 我们期望：exe <task_dir> <input_g> [master_home_g]
    if (argc < 3) {
        std::cerr << "Usage: " << argv[0] << " <task_dir> <input_g_file> [master_home_g]" << std::endl;
        return 1;
    }
    
    std::string task_directory = argv[1];
    std::string input_g_file = argv[2];
    
    // [Marc's Fix: Q6] 确定真正的全局 Home
    arr q_home_global;
    {
        rai::Configuration C_home;
        // 如果提供了 master_home_g (比如 raw_assets 里的那个)，就用它；
        // 否则回退到当前的 input_g_file (仅对 Node 1 有效)
        std::string home_source = (argc == 4) ? argv[3] : input_g_file;
        C_home.addFile(home_source.c_str());
        q_home_global = C_home.getJointState();
        std::cout << ">>> [System] Global Home captured from: " << home_source << std::endl;
    }

    // 复制文件以保持路径上下文
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
                if(solved_komo){
                    auto ret = rai::NLP_Solver(solved_komo->nlp(), 0).solve();
                    if (!shared_viewer) shared_viewer = solved_komo->get_viewer();
                    else solved_komo->set_viewer(shared_viewer);
                    solved_komo->view_play(false, current_lgp_path.c_str(), 1.0);
                    resampleAndPrintTrajectory(solved_komo.get(), 1.0, 100.0);
                    
                    if(solved_komo->timeSlices.N > 0){
                        rai::Configuration C_final_polluted;
                        solved_komo->getConfiguration_full(C_final_polluted, solved_komo->T - 1, 0);
                        writeCleanKinematicState(C_initial_step, C_final_polluted, current_state_file.c_str());
                    }
                }
            } catch (const std::exception& e) {
                std::cerr << "LGP CRASHED: " << e.what() << std::endl;
                return 1;
            }
        }
    }

// ==============================================================================
    // --- PHASE B: HOMING ROUTINE (Refined for Smooth Motion) ---
    // ==============================================================================
    std::cout << "\n>>> [MARC_LOG] INITIATING SMOOTH HOMING..." << std::endl;
    try {
        rai::Configuration C_end;
        C_end.addFile(current_state_file.c_str());

        arr q_current = C_end.getJointState();
        arr q_target = q_home_global; 

        // 1. 拓扑解绕 (保持不变，确保走近路)
        if(q_target.N == q_current.N) {
             double TWO_PI = 6.2831853071;
             for(uint i=0; i<6; i++) { // 只针对 JAKA 臂
                 rai::Dof *d = C_end.activeDofs(i);
                 double lo = (d->limits.N >= 2) ? d->limits.elem(0) : -1000.0;
                 double hi = (d->limits.N >= 2) ? d->limits.elem(1) : 1000.0;
                 double cand_plus = q_target(i) + TWO_PI;
                 double cand_minus = q_target(i) - TWO_PI;
                 double current_dist = fabs(q_current(i) - q_target(i));
                 if(cand_plus >= lo && cand_plus <= hi && fabs(q_current(i) - cand_plus) < current_dist) q_target(i) = cand_plus;
                 else if(cand_minus >= lo && cand_minus <= hi && fabs(q_current(i) - cand_minus) < current_dist) q_target(i) = cand_minus;
             }
        }

        KOMO komo;
        komo.setConfig(C_end, true); 
        
        // 设置 2.0 秒的逻辑时长，20 个步长，给路径足够的“展开”空间
        komo.setTiming(1.0, 20, 1.0, 2); 
        
        // [关键修改 1] 恢复到类似 Panda 的控制权重 (1e-1)
        // 这一项负责让轨迹“平滑”，权重太小会瞬移，太大动不了
        komo.addControlObjective({}, 2, 1e-1); 
        
        // [关键修改 2] 目标约束
        // 使用 OT_eq (硬约束) 确保最后必须到达，权重设为 1e1
        komo.addObjective({1.0}, FS_qItself, {}, OT_eq, {1e1}, q_target);

        // [关键修改 3] 引导拉力 (Optional but Helpful)
        // 给整个路径一个微弱的向目标靠近的力，防止它前 1.9 秒原地待命
        komo.addObjective({0.1, 0.9}, FS_qItself, {}, OT_sos, {1e-1}, q_target);

        komo.add_collision(true, 0.01);

        // [关键修改 4] 初始化种子
        // 不要让它从“原地不动”开始优化，而是给它一个从当前指向目标的线性插值初值
        komo.initWithWaypoints({q_target}, 1, false); 

        auto ret = rai::NLP_Solver(komo.nlp(), 0).solve();
        std::cout << ">>> Homing Solver Result: " << *ret << std::endl;

        // 残差检查
        arr q_final = komo.getConfiguration_qOrg(komo.T-1);
        double total_gap = 0;
        for(uint i=0; i<q_target.N; i++) total_gap += fabs(q_final(i) - q_target(i));
        std::cout << ">>> Total Residual Error: " << total_gap << std::endl;

        if (total_gap < 0.2) { // 只要足够接近就执行
             if (!shared_viewer) shared_viewer = komo.get_viewer();
             else komo.set_viewer(shared_viewer);
             
             // 0.5 倍速播放，方便肉眼确认是否平滑
             komo.view_play(false, "HOMING_ACTION", 0.5); 
             
             // 这里 speed_scale=1.0 表示 2.0s 逻辑时间 = 2.0s 现实时间
             resampleAndPrintTrajectory(&komo, 1.0, 100.0);
             
             rai::Configuration C_final_homed;
             komo.getConfiguration_full(C_final_homed, komo.T - 1, 0);
             writeCleanKinematicState(C_end, C_final_homed, current_state_file.c_str());
        } else {
            std::cout << ">>> WARNING: Homing failed to converge smoothly." << std::endl;
        }

    } catch (const std::exception& e) {
        std::cerr << "HOMING CRASHED: " << e.what() << std::endl;
    }

    fs::rename(current_state_file, fs::path(task_directory) / "output_state.g");
    std::cout << "Node Execution successful! Final state saved." << std::endl;
    return 0;
}

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