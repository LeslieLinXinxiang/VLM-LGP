#include "LGP_TAMP_Abstraction.h"
#include "../KOMO/manipTools.h"

namespace rai {

//===========================================================================

std::shared_ptr<KOMO> LGP_TAMP_Abstraction::get_waypointsProblem(Configuration& C, StringAA& actionSequence){
  // 【探针插入 START】: 检查 Waypoints 阶段的碰撞配置
  std::cout << "\n>>> [Probe] Waypoints Collision Check:" << std::endl;
  std::cout << "    [Global] useBroadCollisions: " << (this->useBroadCollisions ? "ON (Enabled)" : "OFF (Disabled)") << std::endl;
  std::cout << "    [Explicit] Explicit Pairs: " << (this->explicitCollisions.N / 2) << " pairs" << std::endl;
  std::cout << "----------------------------------------------------------" << std::endl;
  // 【探针插入 END】

  std::shared_ptr<KOMO> ways = setup_sequence(C, actionSequence.N);

  for(uint t=0;t<actionSequence.N;t++){
    add_action_constraints(ways, double(t)+1., actionSequence(t));
  }

  for(uint i=0; i<explicitCollisions.N; i+=2) {
    ways->addObjective({}, FS_distance, {explicitCollisions.elem(i), explicitCollisions.elem(i+1)}, OT_ineq, {1e1});
  }

  return ways;
}

std::shared_ptr<KOMO> LGP_TAMP_Abstraction::get_fullMotionProblem(rai::Configuration& C, StringAA& actionSequence, shared_ptr<KOMO> initWithWaypoints){
  
  // 【探针插入 START】: 检查 Full Motion 阶段的碰撞配置 (这是最重要的)
  std::cout << "\n==========================================================" << std::endl;
  std::cout << ">>> [Probe] Full Motion Collision Check:" << std::endl;
  if (this->useBroadCollisions) {
      std::cout << "    [STATUS] 全局碰撞 (genericCollisions): \033[1;32m开启 (ON)\033[0m" << std::endl; // 绿色高亮
  } else {
      std::cout << "    [STATUS] 全局碰撞 (genericCollisions): \033[1;31m关闭 (OFF)\033[0m" << std::endl; // 红色高亮
  }
  
  if (this->explicitCollisions.N > 0) {
      std::cout << "    [DETAIL] 显式碰撞对 (Explicit): " << this->explicitCollisions.N / 2 << " 对" << std::endl;
  } else {
      std::cout << "    [DETAIL] 无显式碰撞对。" << std::endl;
  }
  std::cout << "==========================================================\n" << std::endl;
  // 【探针插入 END】

  std::shared_ptr<KOMO> path = setup_motion(C, actionSequence.N);

  for(uint t=0;t<actionSequence.N;t++){
    add_action_constraints(path, double(t)+1., actionSequence(t));
  }

  for(uint i=0; i<explicitCollisions.N; i+=2) {
    // 修复点：补全了这里的大括号和分号
    path->addObjective({}, FS_distance, {explicitCollisions.elem(i), explicitCollisions.elem(i+1)}, OT_ineq, {1e1});
  }

  if(initWithWaypoints){
    auto ways = initWithWaypoints;
    arr stable_q = ways->getConfiguration_qAll(-1);
    path->setConfiguration_qAll(-2, stable_q);
    arrA waypointsAll = ways->getPath_qAll();
    path->initWithWaypoints(waypointsAll, 1, true, 0.1);
  }

  for(uint t=0;t<actionSequence.N;t++){
    add_action_constraints_motion(path, double(t)+1., (t>0?actionSequence(t-1):StringA()), actionSequence(t), t);
  }

  return path;
}

} // namespace rai
