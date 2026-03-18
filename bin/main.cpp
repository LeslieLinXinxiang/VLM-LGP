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
#include <array>
#include <set>
#include <unordered_map>
#include <iomanip>
#include <sstream>
#include <chrono>
#include <cmath>
#include <Kin/F_qFeatures.h>

namespace fs = std::filesystem;

struct ActiveCollisionSummary {
    std::string lgp_file;
    std::string action_summary;
    double radius_m = 0.05;
    std::vector<std::pair<std::string, std::string>> pairs;
    double full_motion_solver_ms = -1.0;
};

static std::array<double, 3> toXYZ(const arr& p) {
    std::array<double, 3> out{0.0, 0.0, 0.0};
    if(p.N >= 3) {
        out[0] = p(0);
        out[1] = p(1);
        out[2] = p(2);
    }
    return out;
}

static double dist3(const std::array<double, 3>& a, const std::array<double, 3>& b) {
    const double dx = a[0] - b[0];
    const double dy = a[1] - b[1];
    const double dz = a[2] - b[2];
    return std::sqrt(dx * dx + dy * dy + dz * dz);
}

static std::string getActionSummary(const StringAA& plan) {
    if(!plan.N) return "<empty>";
    std::ostringstream oss;
    for(uint i = 0; i < plan.N; ++i) {
        if(i) oss << " | ";
        for(uint j = 0; j < plan(i).N; ++j) {
            if(j) oss << ' ';
            oss << plan(i)(j).p;
        }
    }
    return oss.str();
}

static std::vector<std::pair<std::string, std::string>> extractActivePairsFromWaypoints(
    const std::shared_ptr<KOMO>& ways,
    double radius_m
) {
    std::vector<std::pair<std::string, std::string>> out;
    if(!ways || ways->T <= 0) return out;

    std::vector<std::unordered_map<std::string, std::array<double, 3>>> snapshots;
    snapshots.reserve(ways->T);

    for(uint t = 0; t < ways->T; ++t) {
        rai::Configuration Ct;
        ways->getConfiguration_full(Ct, t, 0);

        std::unordered_map<std::string, std::array<double, 3>> pos;
        for(rai::Frame* fr : Ct.frames) {
            if(!fr || !fr->shape || fr->shape->type() == rai::ST_marker) continue;
            const std::string name = fr->name.p;
            pos[name] = toXYZ(fr->getPosition());
        }
        snapshots.emplace_back(std::move(pos));
    }

    std::set<std::string> movingCenters;
    for(size_t t = 1; t < snapshots.size(); ++t) {
        for(const auto& kv : snapshots[t]) {
            const auto prevIt = snapshots[t - 1].find(kv.first);
            if(prevIt == snapshots[t - 1].end()) continue;
            if(dist3(kv.second, prevIt->second) > 1e-6) movingCenters.insert(kv.first);
        }
    }

    std::set<std::pair<std::string, std::string>> uniqPairs;
    for(size_t t = 0; t < snapshots.size(); ++t) {
        rai::Configuration Ct;
        ways->getConfiguration_full(Ct, uint(t), 0);

        std::unordered_map<std::string, std::array<double, 3>> current;
        for(rai::Frame* fr : Ct.frames) {
            if(!fr || !fr->shape || fr->shape->type() == rai::ST_marker) continue;
            const std::string name = fr->name.p;
            current[name] = toXYZ(fr->getPosition());
        }

        for(const std::string& center : movingCenters) {
            const auto cIt = current.find(center);
            if(cIt == current.end()) continue;

            for(const auto& kv : current) {
                const std::string& obs = kv.first;
                if(obs == center) continue;
                if(dist3(cIt->second, kv.second) > radius_m) continue;

                std::pair<std::string, std::string> pair =
                    (center < obs) ? std::make_pair(center, obs) : std::make_pair(obs, center);
                uniqPairs.insert(pair);
            }
        }
    }

    out.assign(uniqPairs.begin(), uniqPairs.end());
    return out;
}

static StringA toStringAFlatPairs(const std::vector<std::pair<std::string, std::string>>& pairs) {
    StringA out;
    for(const auto& p : pairs) {
        out.append(p.first.c_str());
        out.append(p.second.c_str());
    }
    return out;
}

static std::vector<std::pair<std::string, std::string>> keepPairsPresentInConfig(
    const std::vector<std::pair<std::string, std::string>>& pairs,
    const rai::Configuration& C
) {
    std::set<std::string> names;
    for(rai::Frame* f : C.frames) {
        if(!f) continue;
        names.insert(f->name.p);
    }

    std::vector<std::pair<std::string, std::string>> out;
    out.reserve(pairs.size());
    for(const auto& p : pairs) {
        if(!names.count(p.first) || !names.count(p.second)) continue;
        out.push_back(p);
    }
    return out;
}

static std::string escapeJson(const std::string& s) {
    std::string out;
    out.reserve(s.size() + 8);
    for(char c : s) {
        if(c == '\\' || c == '"') out.push_back('\\');
        out.push_back(c);
    }
    return out;
}

static void writeActiveCollisionReport(
    const std::string& reportPath,
    const std::string& taskDir,
    double radius_m,
    const std::vector<ActiveCollisionSummary>& summaries
) {
    std::ofstream os(reportPath);
    if(!os.is_open()) {
        std::cerr << "[WARN] Failed to write report: " << reportPath << std::endl;
        return;
    }

    os << "{\n";
    os << "  \"task_dir\": \"" << escapeJson(taskDir) << "\",\n";
    os << "  \"radius_m\": " << radius_m << ",\n";
    os << "  \"subtasks\": [\n";
    for(size_t i = 0; i < summaries.size(); ++i) {
        const auto& s = summaries[i];
        os << "    {\n";
        os << "      \"lgp_file\": \"" << escapeJson(s.lgp_file) << "\",\n";
        os << "      \"action_summary\": \"" << escapeJson(s.action_summary) << "\",\n";
        os << "      \"pair_count\": " << s.pairs.size() << ",\n";
        os << "      \"full_motion_solver_ms\": " << s.full_motion_solver_ms << ",\n";
        os << "      \"pairs\": [\n";
        for(size_t j = 0; j < s.pairs.size(); ++j) {
            os << "        [\"" << escapeJson(s.pairs[j].first) << "\", \"" << escapeJson(s.pairs[j].second) << "\"]";
            os << (j + 1 < s.pairs.size() ? ",\n" : "\n");
        }
        os << "      ]\n";
        os << "    }" << (i + 1 < summaries.size() ? ",\n" : "\n");
    }
    os << "  ]\n";
    os << "}\n";
}

static void printActiveCollisionTable(const std::vector<ActiveCollisionSummary>& summaries) {
    std::cout << "\n================ ACTIVE COLLISION PAIRS (PER SUBTASK) ================\n";
    std::cout << std::left
              << std::setw(26) << "subtask"
              << std::setw(10) << "pairs"
              << std::setw(12) << "solver_ms"
              << "sample_pairs" << std::endl;
    std::cout << std::string(96, '-') << std::endl;

    for(const auto& s : summaries) {
        std::ostringstream sample;
        const size_t showN = std::min<size_t>(s.pairs.size(), 3);
        for(size_t i = 0; i < showN; ++i) {
            if(i) sample << "; ";
            sample << s.pairs[i].first << "<->" << s.pairs[i].second;
        }
        if(s.pairs.size() > showN) sample << "; ...";

        std::cout << std::left
                  << std::setw(26) << s.lgp_file
                  << std::setw(10) << s.pairs.size()
                  << std::setw(12) << std::fixed << std::setprecision(1) << s.full_motion_solver_ms
                  << sample.str() << std::endl;
    }
    std::cout << std::string(96, '=') << "\n";
}

// [HELPER] 轨迹重采样与打印
void resampleAndPrintTrajectory(KOMO* komo, double speed_scale, double freq) {
    if(!komo) return;
    arr q_path = komo->getPath_qOrg();
    arr times = komo->getPath_times();
    
    // 硬核设定：1000Hz 采样率
    freq = 1000.0; 

    rai::BSpline spline;
    spline.set(3, q_path, times); 

    double logical_duration = times.last(); 
    double real_duration = logical_duration * speed_scale;
    uint num_steps = (uint)(real_duration * freq); 

    std::cout << "\n>>> V-LGP TRAJECTORY START <<<" << std::endl;
    // 21维：7*Pos, 7*Vel, 7*Acc
    std::cout << "DIM: " << num_steps << " 21" << std::endl; 

    for(uint i=0; i<num_steps; i++){
        double t_real = (double)i / freq;
        double t_logical = t_real / speed_scale;
        
        if(t_logical > logical_duration) t_logical = logical_duration;
        if(t_logical < 0.) t_logical = 0.;

        // 解析求导：B-Spline 的 0阶、1阶、2阶导数
        arr q = spline.eval(t_logical);       
        arr v = spline.eval(t_logical, 1);    
        arr a = spline.eval(t_logical, 2);    

        std::cout << t_real;
        // Pos
        for(double x : q) std::cout << " " << x;
        // Vel: 物理速度 = 逻辑速度 / speed_scale
        for(double x : v) std::cout << " " << (x / speed_scale);
        // Acc: 物理加速度 = 逻辑加速度 / (speed_scale^2)
        for(double x : a) std::cout << " " << (x / (speed_scale * speed_scale));
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
    const double active_radius_m = 0.05;
    std::vector<ActiveCollisionSummary> active_summaries;
    const std::string report_file = (fs::path(task_directory) / "active_collision_report.json").string();

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

                auto ways = lgp.getSolvedKOMO();
                StringAA solved_plan = lgp.getSolvedPlan();
                std::vector<std::pair<std::string, std::string>> active_pairs =
                    extractActivePairsFromWaypoints(ways, active_radius_m);
                active_pairs = keepPairsPresentInConfig(active_pairs, C_initial_step);

                tamp->explicitCollisions = toStringAFlatPairs(active_pairs);
                tamp->useBroadCollisions = false;

                ActiveCollisionSummary summary;
                summary.lgp_file = lgp_path.filename().string();
                summary.action_summary = getActionSummary(solved_plan);
                summary.radius_m = active_radius_m;
                summary.pairs = active_pairs;

                std::cout << "\n[ACTIVE_COLL] subtask: " << summary.lgp_file
                          << " | radius=" << active_radius_m << "m"
                          << " | active_pairs=" << summary.pairs.size() << std::endl;

                active_pairs = keepPairsPresentInConfig(active_pairs, C_initial_step);
                tamp->explicitCollisions = toStringAFlatPairs(active_pairs);
                tamp->useBroadCollisions = false;

                auto t0 = std::chrono::steady_clock::now();
                PTR<KOMO> solved_komo = lgp.get_fullMotionProblem(true);
                if(solved_komo){
                    auto ret = rai::NLP_Solver(solved_komo->nlp(), 0).solve();
                    (void)ret;
                    auto t1 = std::chrono::steady_clock::now();
                    summary.full_motion_solver_ms =
                        std::chrono::duration_cast<std::chrono::milliseconds>(t1 - t0).count();
                }

                if(solved_komo){
                    summary.pairs = active_pairs;
                    active_summaries.push_back(summary);

                    // Incremental persistence: write partial report after each finished subtask.
                    writeActiveCollisionReport(report_file, task_directory, active_radius_m, active_summaries);
                    std::cout << "[ACTIVE_COLL] Partial report updated: " << report_file
                              << " | completed=" << active_summaries.size() << std::endl;

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

        printActiveCollisionTable(active_summaries);
        writeActiveCollisionReport(report_file, task_directory, active_radius_m, active_summaries);
        std::cout << "[ACTIVE_COLL] Report written to: " << report_file << std::endl;
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