#include <LGP/LGP_Tool.h>
#include <LGP/LGP_TAMP_Abstraction.h>
#include <Kin/viewer.h>
#include <stdexcept> // <-- 确保包含了异常处理的头文件

// ============================================================================

void tool_use_test() {
    // 1. 定义问题名称
    rai::String problem_name = "bimanual_hook_task"; // <-- 确保与你的配置文件名一致

    // 2. 加载 .g 文件
    rai::Configuration C;
    C.addFile(problem_name + ".g");
    C.view(true, "Initial State - Press Enter to start LGP Solver");

    // 3. 创建 TAMP Abstraction 对象
    auto tamp = rai::default_LGP_TAMP_Abstraction(C, problem_name + ".lgp");

    // 4. 创建 LGP_Tool 实例
    rai::LGP_Tool lgp(tamp->getConfig(), *tamp);
    
    // 5. 运行求解器 (使用我们已被验证的 try-catch 范式)
    printf("INFO: Running LGP solver for '%s'...\n", problem_name.p);
    try {
        lgp.solve();
        
        // 如果 solve() 没有抛出异常，我们就认为它成功了
        printf("INFO: LGP solved successfully!\n");
        cout << "** solution (" << lgp.step_count << " steps): " << lgp.getSolvedPlan() << endl;
        lgp.view_solved(true);

    } catch (const std::runtime_error& e) {
        // 如果 solve() 抛出了异常，我们在这里捕获并报告
        printf("\n\n *** LGP FAILED OR CRASHED! *** \n\n");
        printf("ERROR: %s\n\n", e.what());
    }
}

// ============================================================================

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);
    tool_use_test();
    return 0;
}
