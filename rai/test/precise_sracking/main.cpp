#include <LGP/LGP_Tool.h>
#include <LGP/LGP_TAMP_Abstraction.h>
#include <Kin/viewer.h>
#include <stdexcept>

// ============================================================================

void run_lgp_stacking_test() {
    // 1. 定义问题名称
    rai::String problem_name = "01_test_basic";

    // 2. 加载 .g 文件
    rai::Configuration C;
    C.addFile(problem_name + ".g");
    C.view(true, "Initial State - Press Enter to start LGP Solver");

    // 3. 创建 TAMP Abstraction 对象
    auto tamp = rai::default_LGP_TAMP_Abstraction(C, problem_name + ".lgp");

    // 4. 创建 LGP_Tool 实例
    rai::LGP_Tool lgp(tamp->getConfig(), *tamp);
    
    // 5. 运行求解器
    printf("INFO: Running LGP solver...\n");
    try {
        lgp.solve();
        
        printf("INFO: LGP solved successfully!\n");
        cout << "** solution (" <<lgp.step_count <<" steps): " <<lgp.getSolvedPlan() <<endl;

        // 可视化找到的解决方案 (使用正确的、只接受一个参数的 C++ API)
        lgp.view_solved(true); // <-- 最终修正

    } catch (const std::runtime_error& e) {
        printf("\n\n *** LGP SOLVER CRASHED! *** \n\n");
        printf("ERROR: %s\n\n", e.what());
        // view_tree() 不存在，保持注释
        // lgp.view_tree(); 
    }
}

// ============================================================================

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);
    run_lgp_stacking_test();
    return 0;
}
