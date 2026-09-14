// Offscreen renderer for the reachability-ablation scenes.
// usage: render_scene.exe <scene.g> <out_dir/> [camX camY camZ  lookX lookY lookZ  heightAbs]
// Camera is placed explicitly and made upright, so the elevation of the shot is
// controlled rather than inherited from the viewer default (which sits nearly
// horizontal and flattens the spatial layout these figures need to show).
#include <Kin/kin.h>
#include <Kin/viewer.h>
#include <Gui/opengl.h>
#include <Core/util.h>

int main(int argc, char** argv) {
  if(argc < 3) { cout << "usage: render_scene.exe <scene.g> <out/> [cx cy cz lx ly lz h]" << endl; return 2; }
  const char* scene = argv[1];
  const char* out   = argv[2];

  rai::Vector camPos(0.0, -1.15, 1.85);
  rai::Vector lookAt(0.0,  0.15, 0.68);
  double heightAbs = 1.5;
  if(argc >= 10) {
    camPos.set(atof(argv[3]), atof(argv[4]), atof(argv[5]));
    lookAt.set(atof(argv[6]), atof(argv[7]), atof(argv[8]));
    heightAbs = atof(argv[9]);
  }

  rai::Configuration C;
  C.addFile(scene);

  auto V = C.get_viewer();
  V->setWindow("ablation", 1600, 1100);
  V->updateConfiguration(C);
  V->view(false);
  rai::wait(.3);

  rai::Camera& cam = V->displayCamera();
  cam.setZRange(.1, 50.);
  cam.setPosition(camPos);
  cam.focus(lookAt, true);
  cout << "[CAM] pos=" << cam.X.pos << " foc=" << cam.foc
       << " zNear=" << cam.zNear << " zFar=" << cam.zFar
       << " fl=" << cam.focalLength << " hAbs=" << cam.heightAbs << endl;

  V->view(false);
  rai::wait(.5);
  V->savePng(rai::String(out), 0);
  rai::wait(.3);
  cout << "[RENDER] " << scene << " -> " << out << endl;
  return 0;
}
