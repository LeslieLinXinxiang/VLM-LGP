// Renders the arm at the grasp configuration the pick solver produces for one object.
//
// The solve is the same single-waypoint pick KOMO that pick_waypoint_check.exe runs,
// so the rendered pose is exactly the configuration the reachability stage judges.
// Crucially the path is rendered even when the solve is INFEASIBLE: the optimizer
// still returns the configuration of least constraint violation, which for an
// out-of-reach target is the arm stretched to its limit and falling short -- the
// picture the ablation figure needs.
//
// usage: render_grasp.exe <scene.g> <object> <out_dir/> [cx cy cz lx ly lz]
#include <KOMO/manipTools.h>
#include <Kin/kin.h>
#include <Kin/frame.h>
#include <Kin/viewer.h>
#include <Optim/NLP_Solver.h>
#include <Gui/opengl.h>
#include <Core/util.h>
#include <iostream>
#include <string>

static std::string detectType(rai::Frame* f) {
  if(f && f->shape && f->shape->type() == rai::ST_cylinder) return "cylinder";
  return "box";
}

int main(int argc, char** argv) {
  if(argc < 4) { cout << "usage: render_grasp.exe <scene.g> <object> <out/> [cx cy cz lx ly lz]" << endl; return 2; }
  const char* scenePath = argv[1];
  const char* objName   = argv[2];
  const char* outDir    = argv[3];

  rai::Vector camPos(0.0, -0.30, 2.20);
  rai::Vector lookAt(-0.10, 0.02, 0.68);
  if(argc >= 10) {
    camPos.set(atof(argv[4]), atof(argv[5]), atof(argv[6]));
    lookAt.set(atof(argv[7]), atof(argv[8]), atof(argv[9]));
  }

  rai::Configuration C;
  C.addFile(scenePath);
  rai::Frame* obj = C.getFrame(objName, false);
  if(!obj) { cout << "[ERR] no frame " << objName << endl; return 3; }

  bool feasible = false;
  arr qLast;
  try {
    ManipulationHelper manip;
    manip.setup_sequence(C, 1, 1e-2, 1e-1, true, true, true);
    if(detectType(obj) == "cylinder") manip.action_pick_cylinder(1.0, "l_gripper", objName);
    else                              manip.action_pick("pick_touch", 1.0, "l_gripper", objName);

    auto ret = rai::NLP_Solver(manip.komo->nlp(), 0).solve();
    feasible = ret->feasible;

    arr qPath = manip.komo->getPath_qOrg();
    if(qPath.nd == 2 && qPath.d0 > 0) qLast = qPath[qPath.d0 - 1];
  } catch(const std::exception& e) {
    cout << "[WARN] solve threw: " << e.what() << endl;
  }

  if(qLast.N) {
    try { C.setJointState(qLast); }
    catch(const std::exception& e) { cout << "[WARN] setJointState: " << e.what() << endl; }
  }

  auto V = C.get_viewer();
  V->setWindow("grasp", 1600, 1100);
  V->updateConfiguration(C);
  V->view(false);
  rai::wait(.3);
  rai::Camera& cam = V->displayCamera();
  cam.setZRange(.1, 50.);
  cam.setPosition(camPos);
  cam.focus(lookAt, true);
  V->view(false);
  rai::wait(.5);
  V->savePng(rai::String(outDir), 0);
  rai::wait(.3);

  cout << "[GRASP] " << objName << " feasible=" << (feasible ? "true" : "false")
       << " qDim=" << qLast.N << " -> " << outDir << endl;
  return 0;
}
