#include <Kin/frame.h> 
#include <LGP/LGP_Tool.h>
#include <LGP/LGP_TAMP_Abstraction.h>
#include <Kin/viewer.h>
#include <Optim/NLP_Solver.h>
#include <stdexcept>
#include <vector>
#include <fstream>

// ============================================================================

void run_staged_planning() {
    rai::String problem_name = "staged";
    rai::Configuration C;
    C.addFile(problem_name + ".g");
    C.view(true, "Initial State - Press Enter to start Staged Planner");

    std::vector<std::string> plan_stages = {
        "(on base_target base) (stableOn base_target base)",
        "(on base cyl1) (stableOn base cyl1)",
        "(on base cyl2) (stableOn base cyl2)",
        "(on base cyl3) (stableOn base cyl3)",
        "(on base cyl4) (stableOn base cyl4)"
    };
    
    std::vector<const char*> objects_to_lock = {"base", "cyl1", "cyl2", "cyl3", "cyl4"};
    std::vector<PTR<KOMO>> solutions;

    for (size_t i = 0; i < plan_stages.size(); ++i) {
        printf("\n\nINFO: SOLVING STAGE %zu: %s\n\n", i, plan_stages[i].c_str());

        std::string temp_lgp_filename = "temp_stage.lgp";
        std::ofstream temp_lgp_file(temp_lgp_filename);
        temp_lgp_file << "fol: <staged.fol>\n";
        temp_lgp_file << "terminal: \"" << plan_stages[i] << "\"\n";
        temp_lgp_file << "genericCollisions: true\n";
        temp_lgp_file.close();

        auto tamp = rai::default_LGP_TAMP_Abstraction(C, temp_lgp_filename.c_str());
        rai::LGP_Tool lgp(C, *tamp);

        try {
            lgp.solve();
            auto komo_solution = lgp.getSolvedKOMO();
            if (!komo_solution) {
                throw std::runtime_error("LGP failed to find a solution for this stage.");
            }
            
            solutions.push_back(komo_solution);

            arr final_q = komo_solution->getConfiguration_qOrg(komo_solution->T-1);
            C.setJointState(final_q);

            // 【【【【【【 核心修正：使用 T-1 作为最后一个时间步的索引 】】】】】】
            C.setFrameState(komo_solution->getConfiguration_X(komo_solution->T - 1));

            rai::Frame* frame_to_lock = C.getFrame(objects_to_lock[i]);
            if(frame_to_lock) {
                printf("INFO: Locking frame '%s' for subsequent stages.\n", objects_to_lock[i]);
                frame_to_lock->setJoint(rai::JT_rigid);
            }

        } catch (const std::runtime_error& e) {
            printf("\n\n *** LGP SOLVER CRASHED AT STAGE %zu! *** \n\n", i);
            printf("ERROR: %s\n\n", e.what());
            return;
        }
    }
    
    printf("\n\nINFO: All stages solved! Playing full path stage by stage...\n");
    if(!C.hasView()) C.view();
    for(size_t i=0; i<solutions.size(); ++i) {
        printf(" -- Playing stage %zu -- \n", i);
        solutions[i]->set_viewer(C.get_viewer());
        solutions[i]->view_play(true, STRING("Stage " << i << " - Press Enter to continue"), 0.1);
    }

    printf("\n\nINFO: Playback finished. Close the viewer to exit.\n");
    C.view(true);
}

// ============================================================================

int main(int argc, char** argv) {
    rai::initCmdLine(argc, argv);
    run_staged_planning();
    return 0;
}
