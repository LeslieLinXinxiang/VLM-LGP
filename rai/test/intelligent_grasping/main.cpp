// ============================================================================
// main_single_task_probe_v2.cpp
//
// Argument-Free, streamlined version for rapid, iterative testing.
// ASSUMPTION: 'test.g' and 'test.lgp' files exist in the same directory
// from which this executable is run.
//
// Usage:
// 1. Place this source file, 'test.g', and 'test.lgp' in the same folder.
// 2. Compile the source.
// 3. Execute directly with './<executable_name>'
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

    // --- Hardcoded file paths for a simplified testing loop ---
    const char* g_file_path = "test.g";
    const char* lgp_file_path = "test.lgp";
    
    // Check if files exist before proceeding
    {
        std::ifstream f_g(g_file_path);
        if (!f_g.good()) {
            std::cerr << "CRITICAL ERROR: Cannot find required file '" << g_file_path << "'. Make sure it's in the current directory." << std::endl;
            return 1;
        }
        std::ifstream f_lgp(lgp_file_path);
        if (!f_lgp.good()) {
            std::cerr << "CRITICAL ERROR: Cannot find required file '" << lgp_file_path << "'. Make sure it's in the current directory." << std::endl;
            return 1;
        }
    }

    std::cout << "\n==========================================================" << std::endl;
    std::cout << ">>> Executing Single Task Probe (Argument-Free) <<<" << std::endl;
    std::cout << "    Configuration File: " << g_file_path << std::endl;
    std::cout << "    LGP Task File:      " << lgp_file_path << std::endl;
    std::cout << "==========================================================" << std::endl;

    try {
        // 1. Load the initial world configuration
        rai::Configuration C;
        C.addFile(g_file_path);

        // 2. Instantiate the LGP Tool
        auto tamp = rai::default_LGP_TAMP_Abstraction(C, lgp_file_path);
        rai::LGP_Tool lgp(C, *tamp);
        
        // 3. Solve for the symbolic plan
        lgp.solve();
        StringAA plan = lgp.getSolvedPlan();
        std::cout << ">>> Symbolic Plan Found: " << plan << std::endl;

        // 4. Get the full KOMO motion problem from the solved plan
        PTR<KOMO> solved_komo = lgp.get_fullMotionProblem(true);
        
        // 5. Solve the geometric path optimization problem
        auto ret = rai::NLP_Solver(solved_komo->nlp(), 0).solve();
        if (ret->feasible) {
             std::cout << ">>> Geometric Path Found (Feasible). <<<" << std::endl;
        } else {
             std::cout << ">>> WARNING: Geometric path solver reported infeasibility, but continuing. <<<" << std::endl;
        }
        
        // 6. Visualize the result
        if (solved_komo) {
            std::string viewer_title = "Result of: ";
            viewer_title += lgp_file_path;
            solved_komo->view_play(true, viewer_title.c_str(), 2.0);
        } else {
            throw std::runtime_error("Solved KOMO is null or invalid.");
        }

    } catch (const std::exception& e) {
        std::cerr << "\n\n *** LGP Solver Crashed During Single Task Probe *** \n" 
                  << "Error: " << e.what() << std::endl;
        // Keep the viewer open on crash to inspect the last valid configuration
        rai::wait(); 
        return 1;
    }

    std::cout << "\n\n=== Single Task Probe Completed Successfully! ===" << std::endl;
    return 0;
}
