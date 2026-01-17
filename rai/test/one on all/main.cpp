// ============================================================================
// main.cpp (v21.2 - Single-Shot Solver with Controlled Playback)
// 基于 v14.0 稳定基线修改，回归单次求解模式。
// ============================================================================

#include <LGP/LGP_Tool.h>
#include <KOMO/komo.h>
#include <Kin/kin.h>
#include <LGP/LGP_TAMP_Abstraction.h>
#include <Kin/frame.h>
#include <Kin/viewer.h>
#include <Optim/NLP_Solver.h>
#include <Core/graph.h>

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <stdexcept>

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);

    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <path_to_task.lgp>" << std::endl;
        return 1;
    }
    const char* lgp_file = argv[1];

    try {
        // 1. 设置初始构型
        rai::Configuration C;
        C.addFile("house.g");

        // 2. 创建 LGP_Tool 实例
        auto tamp = rai::default_LGP_TAMP_Abstraction(C, lgp_file);
        rai::LGP_Tool lgp(C, *tamp);
        
        // 3. 植入探针并执行求解
        std::cout << "\n[PROBE 1] MAIN: Executing lgp.solve()..." << std::endl;
        lgp.solve();
        std::cout << "[PROBE 2] MAIN: lgp.solve() has returned successfully." << std::endl;

        // 4. 获取符号规划结果
        StringAA plan = lgp.getSolvedPlan();
        std::cout << ">>> 符号规划已找到: " << plan << std::endl;

        // 5. 获取并平滑完整的几何路径
        PTR<KOMO> path = lgp.get_fullMotionProblem(false);
        auto ret = rai::NLP_Solver(path->nlp(), 0).solve();
        if (!ret->feasible) {
            std::cout << "路径平滑不可行, 但仍继续。" << std::endl;
        }
        std::cout << ">>> 几何路径已找到。 <<<" << std::endl;

        // 6. 【【【 核心修改：照抄 v14.0 的播放逻辑 】】】
        if (path) {
            // -- A. 显示初始状态 --
            // 我们需要一个 viewer 对象来控制显示
            auto viewer = path->get_viewer();
            viewer->updateConfiguration(C);
            viewer->view(false, "初始状态 - 规划完成"); // false 表示不阻塞

            // -- B. 等待用户输入 --
            std::cout << "\n\n>>> 规划完成。按下回车键 (Enter) 以慢速播放完整动画... <<<" << std::endl;
            std::cin.get();
            
            // -- C. 调用 view_play 并传入速度参数 --
            // 第一个参数 'false' -> 播放结束后不阻塞
            // 第二个参数 "..." -> 窗口标题
            // 第三个参数 0.1 -> 播放延迟（秒），值越大越慢
            double playback_speed_delay = 0.1; 
            path->view_play(false, "完整任务序列", playback_speed_delay);

            // -- D. 播放结束后，保持窗口打开等待用户 --
            viewer->view(true, "播放完成。按任意键退出。");

        } else {
            throw std::runtime_error("未能生成几何路径 (path is null)。");
        }

    } catch (const std::exception& e) {
        std::cerr << "\n\n *** LGP 求解器崩溃 *** \n" << "错误: " << e.what() << std::endl;
        rai::Configuration C_error;
        C_error.addFile("house.g");

        return 1;
    }

    std::cout << "\n\n=== 任务成功完成! ===" << std::endl;

    return 0;
}
