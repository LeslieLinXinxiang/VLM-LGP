// ============================================================================
// main.cpp (v0.5 - Synergistic Commands Version)
// 目标：精确抓取 base_handle，并解决约束冲突
// ============================================================================

#include <KOMO/manipTools.h>
#include <Kin/viewer.h>
#include <string>
#include <iostream>

// ... 辅助函数 solve_and_play 保持不变 ...
void solve_and_play(rai::Configuration& C, ManipulationHelper& planner, bool verbose=true) {
    auto ret = planner.solve(verbose ? 1 : -1);
    
    if(verbose) std::cout << "Planner '" << planner.info << "' solution: " << *ret << std::endl;
    
    if(!ret->feasible) {
        std::cerr << "Planning failed for: " << planner.info << std::endl;
        planner.k().view(true, "Planning failed! Press key to exit.");
        exit(1);
    }
    
    std::cout << "Planning successful for: " << planner.info << ". Press key to play animation..." << std::endl;
    planner.k().view(true, "Press key to play animation");
    planner.play(C, 2.);
}


int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);

    // --- 1. 准备物理世界 ---
    rai::Configuration C;
    C.addFile("house.g");

    const char* gripper = "l_gripper";
    const char* palm = "l_palm";

    C.view(true, "Initial Scene - Press key to start planning the synergistic grasp");

    // --- 2. 任务序列：协同指令抓取 base ---
    {
        ManipulationHelper grasp_planner("Synergistic Grasp base at handle");
        
        grasp_planner.setup_sequence(C, 1);
        
        // ** 【【【【【【核心指令集 (修正版)】】】】】】 **

        // 1. 姿态与避碰指令：我们“借用” grasp_box 来设置姿态和避碰，但不使用它的位置约束
        // 这是一个更底层的技巧，我们手动添加 grasp_box 的部分约束
        
        // 1a. 姿态对齐：让 gripper 的 y 轴与 base 的 y 轴反向平行
        grasp_planner.k().addObjective({1.}, FS_vectorY, {gripper}, OT_sos, {1e1}, {0., -1., 0.});

        // 1b. 避碰：确保手掌不与 base 碰撞
        grasp_planner.k().addObjective({1.}, FS_negDistance, {palm, "base"}, OT_ineq, {1e1});

        // 2. 精确位置指令：用高权重的“位置对齐”作为我们唯一的位置目标
        grasp_planner.k().addObjective({1.}, FS_positionDiff, {gripper, "base_handle"}, OT_eq, {1e2});

        // 3. (可选但推荐) 增加一个 gripper Z 轴方向的对齐，确保姿态更稳定
        grasp_planner.k().addObjective({1.}, FS_vectorZ, {"base_handle"}, OT_sos, {1e1}, {0., 0., 1.});


        solve_and_play(C, grasp_planner);
        
        C.attach(gripper, "base");
    }

    std::cout << "\n\n=== Synergistic Grasp Task Completed Successfully! ===" << std::endl;
    C.view(true, "Final State (base attached at handle) - Press any key to exit");

    return 0;
}
