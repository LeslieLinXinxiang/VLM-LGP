// ============================================================================
// main.cpp (v14.0 - Stable with Collision Passing)
// 解决了 coll: 关键字被忽略的问题，是集成 RRT 之前的稳定基线。
// ============================================================================

#include <LGP/LGP_Tool.h>
#include <KOMO/komo.h>
#include <Kin/kin.h>
#include <LGP/LGP_TAMP_Abstraction.h>
#include <Kin/frame.h>
#include <Kin/viewer.h>
#include <Optim/NLP_Solver.h>
#include <Core/graph.h> // 需要包含 Graph 以解析 .lgp

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <stdexcept>

void writeStateByMixtureReconstruction(const rai::Configuration& C_initial, 
                                     std::shared_ptr<KOMO> komo, 
                                     const char* output_g_file);
std::vector<std::string> parse_conjunctive_goal(const std::string& lgp_filename);

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);

    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <path_to_task.lgp>" << std::endl;
        return 1;
    }
    const char* lgp_file = argv[1];

    // 1. 初始化：在循环外，一次性解析 .lgp 以获取全局信息
    std::string initial_g_file = "trivial_case.g";
    std::string current_state_file = initial_g_file;
    
    std::shared_ptr<rai::ConfigurationViewer> shared_viewer = nullptr;
    std::vector<std::string> goals;
    StringA collision_pairs; // 用于储存 coll: 列表
    
    try {
        rai::Graph lgp_config(lgp_file);
        goals = parse_conjunctive_goal(lgp_file);
        collision_pairs = lgp_config.get<StringA>("coll", {}); // 读取 coll 关键字
        
        if (goals.empty()) throw std::runtime_error("No goals found in " + std::string(lgp_file));
        std::cout << ">>> 成功解析 " << goals.size() << " 个子任务。" << std::endl;
        if (collision_pairs.N) {
            std::cout << ">>> 成功加载 " << collision_pairs.N / 2 << " 对碰撞约束。" << std::endl;
        }
    } catch (const std::exception& e) {
        std::cerr << "解析LGP文件时出错: " << e.what() << std::endl;
        return 1;
    }

    std::cout << "\n\n>>> 按下回车键 (Enter) 以启动全自动序列... <<<" << std::endl;
    std::cin.get();

    // 2. 主循环 (全自动)
    for (size_t i = 0; i < goals.size(); ++i) {
        const std::string& goal_string = goals[i];
        
        std::cout << "\n\n>>> 正在执行步骤 " << i + 1 << "/" << goals.size() << ": " << goal_string << " <<<" << std::endl;
        std::cout << "    (使用初始状态文件: " << current_state_file << ")" << std::endl;

        StringAA plan; 
        PTR<KOMO> path;
        PTR<KOMO> solved_komo;
        try {
            rai::Configuration C;
            C.addFile(current_state_file.c_str());

            std::cout << ">>> 正在规划: " << goal_string << " <<<" << std::endl;
            std::string temp_lgp_filename = "temp_run.lgp";
            std::ofstream temp_lgp_file_stream(temp_lgp_filename);
            
            // 【【【 核心：将全局碰撞约束写入临时文件 】】】
            temp_lgp_file_stream << "fol: <trivial_case.fol>\n" << "genericCollisions: true\n";
            if (collision_pairs.N) {
                temp_lgp_file_stream << "coll: [";
                for(uint j=0; j<collision_pairs.N; ++j) {
                    temp_lgp_file_stream << collision_pairs(j) << (j == collision_pairs.N - 1 ? "" : " ");
                }
                temp_lgp_file_stream << "]\n";
            }
            
            temp_lgp_file_stream << "terminal: \"" << goal_string << "\"\n";
            temp_lgp_file_stream.close();

            // 将文件名 (const char*) 传递给 TAMP Abstraction
            auto tamp = rai::default_LGP_TAMP_Abstraction(C, temp_lgp_filename.c_str());
            rai::LGP_Tool lgp(C, *tamp);
            lgp.solve();
            plan = lgp.getSolvedPlan();
            std::cout << ">>> 符号规划已找到: " << plan << std::endl;

            
            path = lgp.get_fullMotionProblem(true);
            auto ret = rai::NLP_Solver(path->nlp(), 0).solve();
            if (!ret->feasible) std::cout << "路径平滑不可行, 但仍继续。" << std::endl;
            std::cout << ">>> 几何路径已找到。 <<<" << std::endl;
            
            solved_komo = path;

            if (path) {
                if (!shared_viewer) {
                    shared_viewer = path->get_viewer();
                    shared_viewer->updateConfiguration(C);
                    shared_viewer->view(false, "初始状态 - 序列即将开始...");
                    rai::wait(1.0);
                } else {
                    path->set_viewer(shared_viewer);
                }
                
                std::string step_text = "正在执行步骤 " + std::to_string(i + 1) + ": " + goal_string;
                path->view_play(false, step_text.c_str(), 2.0);
            }

            std::string next_state_file = "state_step_" + std::to_string(i + 1) + ".g";
            if(solved_komo){
                writeStateByMixtureReconstruction(C, solved_komo, next_state_file.c_str());
                current_state_file = next_state_file;
                std::cout << ">>> 状态已保存至: " << current_state_file << std::endl;
            } else {
                throw std::runtime_error("Solved KOMO 为空, 无法保存状态。");
            }

        } catch (const std::exception& e) {
            std::cerr << "\n\n *** LGP 求解器崩溃 *** \n" << "错误: " << e.what() << std::endl;
            if(shared_viewer) shared_viewer->view(true, "求解器崩溃! 按任意键退出。");
            return 1;
        }
    }

    std::cout << "\n\n=== 全部序列成功完成! ===" << std::endl;
    if(shared_viewer) {
        rai::Configuration C_final;
        C_final.addFile(current_state_file.c_str());
        shared_viewer->updateConfiguration(C_final);
        shared_viewer->view(true, "最终状态。按任意键退出。");
    }

    return 0;
}


// (状态保存函数和解析函数保持不变)
void writeStateByMixtureReconstruction(const rai::Configuration& C_initial, 
                                     std::shared_ptr<KOMO> komo, 
                                     const char* output_g_file) {
    arr trajectory_X = komo->getPath_X();
    arr final_poses = trajectory_X[trajectory_X.d0 - 1];
    rai::Configuration C_final;
    C_final.copy(C_initial);
    for (rai::Frame* f : C_final.frames) {
        if (f->ID < final_poses.d0) {
            arr pose_vector = final_poses.row(f->ID);
            f->setPose(rai::Transformation(pose_vector));
        }
    }
    std::ofstream final_state_file(output_g_file);
    C_final.write(final_state_file, true);
    final_state_file.close();
}

std::vector<std::string> parse_conjunctive_goal(const std::string& lgp_filename) {
    std::vector<std::string> goals;
    std::ifstream file(lgp_filename);
    if (!file.is_open()) {
        throw std::runtime_error("无法打开LGP文件: " + lgp_filename);
    }
    std::string line;
    while (std::getline(file, line)) {
        size_t terminal_pos = line.find("terminal:");
        if (terminal_pos != std::string::npos) {
            size_t start_quote = line.find('"', terminal_pos);
            size_t end_quote = line.rfind('"');
            if (start_quote != std::string::npos && end_quote != std::string::npos && start_quote != end_quote) {
                std::string content = line.substr(start_quote + 1, end_quote - start_quote - 1);
                int paren_depth = 0;
                size_t goal_start = 0;
                for (size_t i = 0; i < content.length(); ++i) {
                    if (content[i] == '(') {
                        if (paren_depth == 0) goal_start = i;
                        paren_depth++;
                    } else if (content[i] == ')') {
                        paren_depth--;
                        if (paren_depth == 0 && i > goal_start) {
                            goals.push_back(content.substr(goal_start, i - goal_start + 1));
                        }
                    }
                }
            }
            break; 
        }
    }
    return goals;
}
