#include <LGP/LGP_Tool.h>
#include <KOMO/komo.h>
#include <Kin/kin.h>
#include <Kin/frame.h>
#include <Kin/viewer.h>
#include <Optim/NLP_Solver.h>
#include <Core/graph.h>
#include <filesystem>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>

namespace fs = std::filesystem;

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
                    solved_komo->view_play(false, current_lgp_path.c_str(), 1.0);
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

    // --- PHASE B: HOMING ROUTINE (CORRECTED API) ---
    std::cout << ">>> INITIATING HOMING SEQUENCE..." << std::endl;
    try {
        rai::Configuration C_end;
        C_end.addFile(current_state_file.c_str());

        KOMO komo;
        // [FIX 1] Use setConfig instead of setModel
        komo.setConfig(C_end, true); 
        
        komo.setTiming(1.0, 20, 4.0, 2); 
        
        // [FIX 2] Use addControlObjective instead of add_qControlObjective
        // Arguments: (times, order, scale). {} means all times.
        komo.addControlObjective({}, 2, 1e-1);
        
        // Objective 2: Reach q_home at the end
        komo.addObjective({1.0}, FS_qItself, {}, OT_eq, {1e1}, q_home);
        
        komo.add_collision(true);

        auto ret = rai::NLP_Solver(komo.nlp(), 0).solve();
        
        if (ret->feasible) {
            std::cout << ">>> Homing Feasible. Executing..." << std::endl;
             if (!shared_viewer) shared_viewer = komo.get_viewer();
             else komo.set_viewer(shared_viewer);
             komo.view_play(false, "HOMING_ACTION", 1.0);

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
