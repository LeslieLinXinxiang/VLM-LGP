#include <Kin/kin.h>
#include <Kin/frame.h>
#include <iostream>
int main(int argc, char** argv) {
  rai::Configuration C;
  C.addFile(argv[1]);
  for (int i = 2; i < argc; i++) {
    rai::Frame* f = C.getFrame(argv[i], false);
    if (!f) { cout << argv[i] << ": NOT FOUND" << endl; continue; }
    f->ensure_X();
    cout << argv[i] << " world pos: " << f->getPosition() << endl;
    if (f->shape) cout << "  shape type=" << f->shape->type() << " size=" << f->shape->size << endl;
  }
  // 顺便列出所有含 coll0 的 frame 名字
  cout << "--- frames containing 'coll0' ---" << endl;
  for (rai::Frame* f : C.frames) {
    if (f->name.contains("coll0")) cout << "  " << f->name << endl;
  }
  return 0;
}
