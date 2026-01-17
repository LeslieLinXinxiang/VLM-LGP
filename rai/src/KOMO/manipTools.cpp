/*  ------------------------------------------------------------------
    Copyright (c) 2011-2024 Marc Toussaint
    email: toussaint@tu-berlin.de

    This code is distributed under the MIT License.
    Please see <root-path>/LICENSE for details.
    --------------------------------------------------------------  */

#include "manipTools.h"
#include "skeletonSymbol.h"

#include "../Kin/frame.h"
#include "../Kin/feature.h"
#include "../Kin/F_pose.h"
#include "../Kin/F_geometrics.h"

#include "../Optim/NLP_Solver.h"
#include "../Optim/NLP_Sampler.h"

ManipulationHelper::ManipulationHelper(const str& _info)
    : komo(make_shared<KOMO>()), info(_info) {
}

ManipulationHelper::ManipulationHelper(const std::shared_ptr<KOMO>& _komo, const str& _info)
  : komo(_komo), info(_info) {
}

void ManipulationHelper::setup_inverse_kinematics(rai::Configuration& C, double homing_scale, bool accumulated_collisions, bool joint_limits, bool quaternion_norms) {
  /* setup a 1 phase single step problem */
  k().setTiming(1., 1, 1., 0);
  k().setConfig(C, accumulated_collisions);
  k().addControlObjective({}, 0, homing_scale);
  if(accumulated_collisions) {
    k().addObjective({}, FS_accumulatedCollisions, {}, OT_eq, {1e0});
  }
  if(joint_limits) {
    k().addObjective({}, FS_jointLimits, {}, OT_ineq, {1e0});
  }
  if(quaternion_norms) {
    k().addQuaternionNorms();
  }
  Cviewer = &C;
}

void ManipulationHelper::setup_sequence(rai::Configuration& C, uint K, double homing_scale, double velocity_scale, bool accumulated_collisions, bool joint_limits, bool quaternion_norms){
  k().setTiming(double(K), 1, 1., 1);
  k().setConfig(C, accumulated_collisions);
  if(homing_scale>0.)        k().addControlObjective({}, 0, homing_scale);
  if(velocity_scale>0.)      k().addControlObjective({}, 1, velocity_scale);
  if(accumulated_collisions) k().addObjective({}, FS_accumulatedCollisions, {}, OT_eq, {1e0});
  if(joint_limits)           k().addObjective({}, FS_jointLimits, {}, OT_ineq, {1e0});
  if(quaternion_norms)       k().addQuaternionNorms();
  Cviewer = &C;
}

void ManipulationHelper::setup_motion(rai::Configuration& C, uint K, uint steps_per_phase, double homing_scale, double acceleration_scale, bool accumulated_collisions, bool joint_limits, bool quaternion_norms){
  k().setTiming(double(K), steps_per_phase, 1., 2);
  k().setConfig(C, accumulated_collisions);
  if(homing_scale>0.){
    k().addControlObjective({}, 0, homing_scale);
  }
  k().addControlObjective({}, 2, acceleration_scale);
  if(accumulated_collisions) {
    k().addObjective({}, FS_accumulatedCollisions, {}, OT_eq, {1e0});
  }
  if(joint_limits) {
    k().addObjective({}, FS_jointLimits, {}, OT_ineq, {1e0});
  }
  if(quaternion_norms) {
    k().addQuaternionNorms();
  }

  // zero vel at end
  k().addObjective({double(K)}, FS_qItself, {}, OT_eq, {1e0}, {}, 1);
  Cviewer = &C;
}

void ManipulationHelper::setup_pick_and_place_waypoints(rai::Configuration& C, const char* gripper, const char* obj, double homing_scale, double velocity_scale, bool accumulated_collisions, bool joint_limits, bool quaternion_norms) {
  /* setup a 2 phase pick-and-place problem, with a pick switch at time 1, and a place switch at time 2
     the place mode switch at the final time two might seem obselete, but this switch also implies the geometric constraints of placeOn */
  CHECK(!komo->T, "komo already previously setup");
  setup_sequence(C, 2, homing_scale, velocity_scale, accumulated_collisions, joint_limits, quaternion_norms);

  k().addModeSwitch({1., -1.}, rai::SY_stable, {gripper, obj}, true);
}

void ManipulationHelper::setup_point_to_point_motion(rai::Configuration& C, const arr& q1, uint steps_per_phase, double homing_scale, double acceleration_scale, bool accumulated_collisions, bool joint_limits, bool quaternion_norms) {
  /* setup a 1 phase fine-grained motion problem with 2nd order (acceleration) control costs */
  CHECK(!komo->T, "komo already previously setup");
  setup_motion(C, 1, steps_per_phase, homing_scale, acceleration_scale, accumulated_collisions, joint_limits, quaternion_norms);

  if(q1.N){
    qTarget = q1;
    k().initWithWaypoints({q1}, 1, true, (homing_scale>1e-2?.2:0.), 0);
    k().addObjective({1.}, FS_qItself, {}, OT_eq, {1e0}, q1);
  }
}

void ManipulationHelper::add_stable_frame(rai::JointType type, const char* parent, const char* name, const char* initName, rai::Frame* initFrame, double markerSize) {
  rai::Frame* f = k().addFrameDof(name, parent, type, true, initName, initFrame);
  if(markerSize>0.){
    f->setShape(rai::ST_marker, {.1});
    f->setColor({1., 0., 1.});
  }
  if(f->joint){
    f->joint->sampleSdv=1.;
    f->joint->setRandom(k().timeSlices.d1, 0);
  }
}

void ManipulationHelper::grasp_top_box(double time, const char* gripper, const char* obj, str grasp_direction) {
  /* grasp a box with a centered top grasp (axes fully aligned) */
  rai::Array<FeatureSymbol> align;
  if(grasp_direction == "xz") {
    align = {FS_scalarProductXY, FS_scalarProductXZ, FS_scalarProductYZ} ;
  } else if(grasp_direction == "yz") {
    align = {FS_scalarProductYY, FS_scalarProductXZ, FS_scalarProductYZ} ;
  } else if(grasp_direction == "xy") {
    align = {FS_scalarProductXY, FS_scalarProductXZ, FS_scalarProductZZ} ;
  } else if(grasp_direction == "zy") {
    align = {FS_scalarProductXX, FS_scalarProductXZ, FS_scalarProductZZ} ;
  } else if(grasp_direction == "yx") {
    align = {FS_scalarProductYY, FS_scalarProductYZ, FS_scalarProductZZ} ;
  } else if(grasp_direction == "zx") {
    align = {FS_scalarProductYX, FS_scalarProductYZ, FS_scalarProductZZ} ;
  } else {
    LOG(-2) <<"pickDirection not defined:" <<grasp_direction;
  }

  // position: centered
  k().addObjective({time}, FS_positionDiff, {gripper, obj}, OT_eq, {1e1});

  // orientation: grasp axis orthoginal to target plane X-specific
  k().addObjective({time-.2, time}, align(0), {obj, gripper}, OT_eq, {1e0});
  k().addObjective({time-.2, time}, align(1), {obj, gripper}, OT_eq, {1e0});
  k().addObjective({time-.2, time}, align(2), {obj, gripper}, OT_eq, {1e0});
}

void ManipulationHelper::grasp_box(double time, const char* gripper, const char* obj, const char* palm, str grasp_direction, double margin) {
  /* general grasp of a box, squeezing along provided grasp_axis (-> 3
     possible grasps of a box), where and angle of grasp is decided by
     inequalities on grasp plan and no-collision of box and palm */
  arr xLine, yzPlane;
  rai::Array<FeatureSymbol> align;
  if(grasp_direction == "x") {
    xLine = arr{1, 0, 0} ;
    yzPlane = arr{{2, 3}, {0, 1, 0, 0, 0, 1}} ;
    align = {FS_scalarProductXY, FS_scalarProductXZ} ;
  } else if(grasp_direction == "y") {
    xLine = arr{0, 1, 0} ;
    yzPlane = arr{{2, 3}, {1, 0, 0, 0, 0, 1}} ;
    align = {FS_scalarProductXX, FS_scalarProductXZ} ;
  } else if(grasp_direction == "z") {
    xLine = arr{0, 0, 1} ;
    yzPlane = arr{{2, 3}, {1, 0, 0, 0, 1, 0}} ;
    align = {FS_scalarProductXX, FS_scalarProductXY} ;
  } else {
    LOG(-2) <<"grasp_direction not defined:" <<grasp_direction;
  }

  arr boxSize = k().world.getFrame(obj)->getSize();
  boxSize.resizeCopy(3);

  // position: center in inner target plane X-specific
  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_eq, xLine*1e1);
  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, yzPlane*1e1, .5*boxSize-margin);
  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, yzPlane*(-1e1), -.5*boxSize+margin);

  // orientation: grasp axis orthoginal to target plane X-specific
  k().addObjective({time-.2, time}, align(0), {gripper, obj}, OT_eq, {1e0});
  k().addObjective({time-.2, time}, align(1), {gripper, obj}, OT_eq, {1e0});

  // no collision with palm
  k().addObjective({time-.3, time}, FS_distance, {palm, obj}, OT_ineq, {1e1}, {-.001});
}

void ManipulationHelper::grasp_cylinder(double time, const char* gripper, const char* obj, const char* palm, double margin) {
  arr size = k().world.getFrame(obj)->getSize();

  // 1. 位置约束: 必须抓在圆柱轴线上 (Hard Eq)
  // 保证不偏离中心
  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_eq, arr{{2, 3}, {1, 0, 0, 0, 1, 0}}*1e1);
  
  // 2. 高度约束: 必须在圆柱长度范围内 (Hard Ineq)
  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, arr{0, 0, 1}*1e1, arr{0., 0., .5*size(0)-margin});
  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, arr{0, 0, 1}*(-1e1), arr{0., 0., -.5*size(0)+margin});

  // 3. 姿态约束: 严格垂直 (Hard Eq)
  k().addObjective({time-.2, time}, FS_scalarProductXZ, {gripper, obj}, OT_eq, {1e0});

  // 4. 避障
  k().addObjective({time-.3, time}, FS_distance, {palm, obj}, OT_ineq, {1e1}, {-.001});
}

//void ManipulationModelling::grasp_cylinder(double time, const char* gripper, const char* obj, const char* palm, double margin){
//  auto size = k().world[obj]->getSize();

//  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_eq, arr({2,3},{1,0,0,0,1,0})*1e1);
//  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, arr({1,3},{0,0,1})*1e1, {0.,0.,.5*size(0)-margin});
//  k().addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, arr({1,3},{0,0,1})*(-1e1), {0.,0.,-.5*size(0)+margin});

//  // orientation: grasp axis orthoginal to target plane X-specific
//  k().addObjective({time-.2,time}, FS_scalarProductXZ, {gripper, obj}, OT_eq, {1e0});

//  // no collision with palm
//  k().addObjective({time-.3,time}, FS_negDistance, {palm, obj}, OT_ineq, {1e1}, {-.001});
//}

//void ManipulationHelper::no_collisions(const arr& times, const char* obj1, const char* obj2, double margin){
//  k().addObjective(times, FS_negDistance, {obj1, obj2}, OT_ineq, {1e1}, {-margin});
//}

void ManipulationHelper::place_box(double time, const char* obj, const char* table, const char* palm, str place_direction, double margin) {
  /* placement of one box on another */
  arr zVectorTarget = arr{0., 0., 1.} ;
  rai::Frame *obj_frame = k().world.getFrame(obj);
  arr boxSize = obj_frame->getSize();
  if(obj_frame->shape->type()==rai::ST_ssBox){
    boxSize.resizeCopy(3);
  }else if(obj_frame->shape->type()==rai::ST_ssCylinder){
    boxSize = {boxSize(1), boxSize(1), boxSize(0)} ;
  }else NIY
  arr tableSize = k().world.getFrame(table)->getSize();  tableSize.resizeCopy(3);
  double relPos=0.;
  FeatureSymbol zVector = FS_none;
  rai::Array<FeatureSymbol> align;
  if(place_direction == "x") {
    relPos = .5*(boxSize(0)+tableSize(2));
    zVector = FS_vectorX;
    align = {FS_scalarProductXX, FS_scalarProductYX} ;
  } else if(place_direction == "y") {
    relPos = .5*(boxSize(1)+tableSize(2));
    zVector = FS_vectorY;
    align = {FS_scalarProductXY, FS_scalarProductYY} ;
  } else if(place_direction == "z") {
    relPos = .5*(boxSize(2)+tableSize(2));
    zVector = FS_vectorZ;
    align = {FS_scalarProductXZ, FS_scalarProductYZ} ;
  } else if(place_direction == "xNeg") {
    relPos = .5*(boxSize(0)+tableSize(2));
    zVector = FS_vectorX;
    zVectorTarget *= -1.;
    align = {FS_scalarProductXX, FS_scalarProductYX} ;
  } else if(place_direction == "yNeg") {
    relPos = .5*(boxSize(1)+tableSize(2));
    zVector = FS_vectorY;
    zVectorTarget *= -1.;
    align = {FS_scalarProductXY, FS_scalarProductYY} ;
  } else if(place_direction == "zNeg") {
    relPos = .5*(boxSize(2)+tableSize(2));
    zVector = FS_vectorZ;
    zVectorTarget *= -1.;
    align = {FS_scalarProductXZ, FS_scalarProductYZ} ;
  } else {
    LOG(-2) <<"place_direction not defined:" <<place_direction;
  }

  // position: above table, inside table
  k().addObjective({time}, FS_positionDiff, {obj, table}, OT_eq, 1e1*arr{{1, 3}, {0, 0, 1}}, arr{.0, .0, relPos});
  k().addObjective({time}, FS_positionRel, {obj, table}, OT_ineq, 1e1*arr{{2, 3}, {1, 0, 0, 0, 1, 0}}, .5*tableSize-margin);
  k().addObjective({time}, FS_positionRel, {obj, table}, OT_ineq, -1e1*arr{{2, 3}, {1, 0, 0, 0, 1, 0}}, -.5*tableSize+margin);

  // orientation: Z-up
  k().addObjective({time-.2, time}, zVector, {obj}, OT_eq, {0.5}, zVectorTarget);
  k().addObjective({time-.2, time}, align(0), {table, obj}, OT_eq, {1e0});
  k().addObjective({time-.2, time}, align(1), {table, obj}, OT_eq, {1e0});

  // no collision with palm
  if(palm) k().addObjective({time-.3, time}, FS_distance, {palm, table}, OT_ineq, {1e1}, {-.001});
}

void ManipulationHelper::straight_push(arr time_interval, str obj, str gripper, str table) {
  //start & end helper frames
  str helperStart = STRING("_straight_pushStart_" <<gripper <<"_" <<obj <<'_' <<time_interval(0));
  if(!k().world.getFrame(helperStart, false)){
    // add_helper_frame(rai::JT_hingeZ, table, helperStart, obj, 0, .3);
    rai::Frame* helper_frame = komo->addFrameDof(helperStart, obj, rai::JT_hingeZ, true);
    helper_frame->setAutoLimits();
    helper_frame->joint->sampleUniform=1.;
  }

  //x-axis of A aligns with diff-pos of B AT END TIME! (always backward diff)
  k().addObjective({time_interval(1)}, make_shared<F_AlignWithDiff>(Vector_y), {helperStart, obj}, OT_eq, {1e0}, {}, 1);

  //gripper touch
  k().addObjective({time_interval(0)}, FS_negDistance, {gripper, obj}, OT_eq, {1e0}, {-.025});
  // //gripper start position
  k().addObjective({time_interval(0)}, FS_positionRel, {gripper, helperStart}, OT_eq, 1e0*arr{{2, 3}, {1., 0., 0., 0., 0., 1.}});
  k().addObjective({time_interval(0)}, FS_positionRel, {gripper, helperStart}, OT_ineq, 1e0*arr{{1, 3}, {0., 1., 0.}}, {.0, -.02, .0});
  //gripper start orientation
  k().addObjective({time_interval(0)}, FS_scalarProductYY, {gripper, helperStart}, OT_ineq, {-1e0}, {.2});
  k().addObjective({time_interval(0)}, FS_scalarProductYZ, {gripper, helperStart}, OT_ineq, {-1e0}, {.2});
  k().addObjective({time_interval(0)}, FS_vectorXDiff, {gripper, helperStart}, OT_eq, {1e0});

  freeze_relativePose({time_interval(1)}, gripper, obj);
}

void ManipulationHelper::no_collisions(const arr& time_interval, const StringA& pairs, double margin, double scale) {
  /* inequality on distance between pairs of objects */
  StringA _pairs = pairs.ref();
  _pairs.reshape(-1,2);
  for(uint i=0;i<_pairs.d0;i++){
    k().addObjective(time_interval, FS_negDistance, _pairs[i], OT_ineq, {scale}, {-margin});
  }
}

void ManipulationHelper::freeze_joint(const arr& time_interval, const StringA& joints){
  komo->addObjective(time_interval, FS_qItself, joints, OT_eq, {1e1}, {}, 1);
}

void ManipulationHelper::freeze_relativePose(const arr& time_interval, str to, str from){
  komo->addObjective(time_interval, FS_poseRel, {to, from}, OT_eq, {1e1}, {}, 1);
}


void ManipulationHelper::action_pick_cylinder(double time, str gripper, str obj){
  // 1. 获取对象(Object Frame)
  rai::Frame* bodyFrame = komo->world.getFrame(obj);
  
  CHECK(bodyFrame, "Object Frame '" << obj << "' not found!");

  // 2. 运动学架构(Kinematic Structure)
  str snapFrame; snapFrame <<"pickPose_" <<gripper <<'_' <<obj <<'_' <<time;
  rai::Frame* f = komo->addFrameDof(snapFrame, gripper, rai::JT_free, true, 0);
  komo->addRigidSwitch(time, {snapFrame, obj}, true);
  if(f) komo->initFrameDof(f, bodyFrame);

  // =================================================================
  // 3. 准备避障数据 (Prepare Obstacle Avoidance Data)
  // =================================================================
  
  // A. 识别部件 (Gripper Parts)
  StringA gripperParts;
  str prefix = "";
  if(gripper.endsWith("_gripper")) prefix = gripper.getFirstN(gripper.N-7); 
  gripperParts.append(prefix + "palm");
  gripperParts.append(prefix + "finger1");
  gripperParts.append(prefix + "finger2");

  // B. 识别“环境”物体 (Obstacles)
  FrameL obstacles;
  for(rai::Frame *f : komo->world.frames){
      if(f->shape && f->shape->type() != rai::ST_marker){ // 必须有物理形状
          if(!gripperParts.contains(f->name)){ // 只要不是手，就是障碍物
              obstacles.append(f);
          }
      }
  }

  // =================================================================
  // 4. 几何约束 (Geometric Constraints)
  // =================================================================
  arr size = bodyFrame->getSize();
  double margin = 0.02;
  double pre_grasp_z = 0.5 * size(0) + 0.05;
  //修改:先靠近物体正上方
  komo->addObjective({time-0.1}, FS_positionRel, {gripper, obj}, OT_sos, arr{1e2, 1e2, 1e2}, {0., 0., pre_grasp_z});

  komo->addObjective({time}, FS_positionRel, {gripper, obj}, OT_eq, arr{{2, 3}, {1, 0, 0, 0, 1, 0}}*1e3);
  komo->addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, arr{0, 0, 1}*1e2, arr{0., 0., .5*size(0)-margin});
  komo->addObjective({time}, FS_positionRel, {gripper, obj}, OT_ineq, arr{0, 0, 1}*(-1e1), arr{0., 0., -.5*size(0)+margin});
  komo->addObjective({time-0.2, time}, FS_scalarProductXZ, {gripper, obj}, OT_sos, {1e0});

  // =================================================================
  // 5. 三段式避障 (Three-Stage Hard Collision Control)
  // =================================================================
  
  if(komo->stepsPerPhase >= 10){
      
      // -----------------------------------------------------------
      // [阶段 1: 退出段] (-1.0 ~ -0.9)
      // -----------------------------------------------------------
      komo->addObjective({time-1.0, time-0.9}, FS_accumulatedCollisions, {}, OT_ineq, {1e0}, {-0.01}); // Target=0: 零容忍

      komo->addObjective({time-1.0, time-0.9}, make_shared<F_LinAngVel>(), {gripper}, OT_sos, {1e2}, {0., 0., 0.5, 0., 0., 0.});


      // -----------------------------------------------------------
      // [阶段 2: 移动段] (-0.9 ~ -0.2)
      // -----------------------------------------------------------
      for(const str& handPart : gripperParts){
          // 检查手部部件是否存在
          rai::Frame* handF = komo->world.getFrame(handPart);
          if(!handF || !handF->shape) continue;

          for(rai::Frame* obs : obstacles){
              // 排除父子关系（比如 link 连着 link）避免自碰撞误报
              bool isParent = (obs == handF->parent || handF == obs->parent);
              if(!isParent){
                  komo->addObjective({time-0.9, time-0.2}, FS_negDistance, {handPart, obs->name}, OT_ineq, {1e1}, {-0.02});
              }
          }
      }
  }

  // -----------------------------------------------------------
  // [阶段 3: 抓取段] (-0.2 ~ 0.0)
  // -----------------------------------------------------------

  // 手可以贴在物体表面 (dist=0)，但不许穿进去 (dist<0)。
  komo->addObjective({time-0.2, time}, FS_accumulatedCollisions, {}, OT_ineq, {1e1}, {0.0});
}

void ManipulationHelper::action_pick(str action, double time, str gripper, str obj){
  // 0. 卫语句
  if(action != "pick_touch" && action != "pick_box") return;

  rai::Frame* bodyF = komo->world.getFrame(obj);
  CHECK(bodyF, "Object Frame '" << obj << "' not found!");
  rai::Frame* targetF = bodyF; 
  for(auto* c : bodyF->children) if(c->name.contains("handle")) { targetF = c; break; }

  str snapFrame; snapFrame <<"pickPose_" <<gripper <<'_' <<obj <<'_' <<time;
  rai::Frame* f = komo->addFrameDof(snapFrame, gripper, rai::JT_free, true, 0);
  komo->addRigidSwitch(time, {snapFrame, obj}, true);
  if(f) komo->initFrameDof(f, targetF);


  // =================================================================
  // 3. [Phase 2] 引导路点 (Waypoint) - 防止斜插
  // =================================================================
  // 时间: t-0.2
  // 逻辑: 飞到 Target Local Z+ 0.12m (正前方/上方)
  // Mask: 3D全约束 {1e2, 1e2, 1e2}，Target: {0, 0, 0.12}
  komo->addObjective({time-0.2}, FS_positionRel, {gripper, targetF->name}, OT_sos, arr{1e2, 1e2, 1e2}, {0., 0., 0.12});

  // =================================================================
  // 4. [Phase 3] 最终抓取 (Final Grasp)
  // =================================================================
  targetF->ensure_X();
  double score_x = fabs(targetF->get_X().rot * rai::Vector(1, 0, 0) * rai::Vector(1, 0, 0));
  double score_y = fabs(targetF->get_X().rot * rai::Vector(0, 1, 0) * rai::Vector(1, 0, 0));
  bool graspAlongX = (score_x > score_y); 

  komo->addObjective({time}, FS_vectorZDiff, {gripper, targetF->name}, OT_eq, {1e2});
  
  if(graspAlongX) {
      komo->addObjective({time}, FS_scalarProductXX, {gripper, targetF->name}, OT_eq, {1e2}, {1.});
      komo->addObjective({time}, FS_positionRel, {gripper, targetF->name}, OT_eq, arr{1,0,0} * 1e2);
      komo->addObjective({time}, FS_positionRel, {gripper, targetF->name}, OT_eq, arr{0,1,0} * 1e2);
  } else {
      komo->addObjective({time}, FS_scalarProductXY, {gripper, targetF->name}, OT_eq, {1e2}, {1.});
      komo->addObjective({time}, FS_positionRel, {gripper, targetF->name}, OT_eq, arr{0,1,0} * 1e2);
      komo->addObjective({time}, FS_positionRel, {gripper, targetF->name}, OT_eq, arr{1,0,0} * 1e2);
  }
  komo->addObjective({time}, FS_positionDiff, {gripper, targetF->name}, OT_sos, {1e2});

  // =================================================================
  // 5. [Phase 4] 全程避障 (Global Collision Avoidance)
  // =================================================================
  StringA gripperParts;
  str prefix = "";
  if(gripper.endsWith("_gripper")) prefix = gripper.getFirstN(gripper.N-7); 
  gripperParts.append(prefix + "palm");
  gripperParts.append(prefix + "finger1");
  gripperParts.append(prefix + "finger2");

  FrameL obstacles;
  for(rai::Frame *fr : komo->world.frames){
      if(fr->shape && fr->shape->type() != rai::ST_marker){ 
          if(!gripperParts.contains(fr->name)){ 
              obstacles.append(fr);
          }
      }
  }

  if(komo->stepsPerPhase >= 10){
      // 全程避障: 从 t-1.0 到 t-0.2
      // 保持 3cm 安全距离
      for(const str& handPart : gripperParts){
          rai::Frame* handF = komo->world.getFrame(handPart);
          if(!handF || !handF->shape) continue;

          for(rai::Frame* obs : obstacles){
              bool isParent = (obs == handF->parent || handF == obs->parent);
              if(!isParent){
                  komo->addObjective({time-1.0, time-0.2}, FS_negDistance, {handPart, obs->name}, OT_ineq, {1e0}, {-0.03});
              }
          }
      }
      // 抓取瞬间: 允许接触
      komo->addObjective({time-0.2, time}, FS_accumulatedCollisions, {}, OT_ineq, {1e2}, {0.});
  }
}

void ManipulationHelper::action_place_straightOn(str action, double time, str obj, str table){
  // ==============================================================================
  // 1. 初始化与几何参数
  // ==============================================================================
  rai::Frame *targetF = komo->world.getFrame(table);
  rai::Frame *objF = komo->world.getFrame(obj); 
  CHECK(targetF, "Table not found"); CHECK(objF, "Object not found");

  arr tableSize = targetF->getSize();
  if(targetF->shape->type()==rai::ST_ssBox) tableSize.resizeCopy(3);
  else if(targetF->shape->type()==rai::ST_cylinder) tableSize = {tableSize(0), tableSize(0), tableSize(1)};
  if(tableSize(0) < 1e-3) tableSize(0) = 0.1; 
  if(tableSize(1) < 1e-3) tableSize(1) = 0.1;

  auto get_Z_dim = [](rai::Frame* f) -> double {
      if(!f || !f->shape) return 0.0;
      if(f->shape->type() == rai::ST_cylinder || f->shape->type() == rai::ST_ssCylinder || f->shape->type() == rai::ST_capsule) return f->shape->size(0);
      if(f->shape->size.N > 2) return f->shape->size(2); 
      return 0.0;
  };
  
  // rel_z: 物体放置在桌面上时的理论 Z 轴中心距 (接触高度)
  double rel_z = 0.5 * (get_Z_dim(targetF) + get_Z_dim(objF));
  bool isCylinder = (objF->shape && (objF->shape->type() == rai::ST_cylinder || objF->shape->type() == rai::ST_ssCylinder));

  // ==============================================================================
  // 2. 拓扑: World Anchor + Keep Kinematics
  // ==============================================================================
  str snapFrame; snapFrame <<"placePose_" <<table <<'_' <<obj <<'_' <<time;
  
  rai::Frame* f = komo->addFrameDof(snapFrame, "world", rai::JT_free, true);

  if(f && f->joint){
      rai::Transformation targetPose = targetF->ensure_X();
      targetPose.pos.z += rel_z; 
      f->joint->setDofs(targetPose.getArr7d());
  }

  komo->addRigidSwitch(time, {snapFrame, obj}, true);

  // ==============================================================================
  // [NEW] 3. 预放置引导 (Pre-Place Guidance / Funnel)
  // ==============================================================================
  // 时间: time - 0.1
  // 目的: 构造一个漏斗，引导物体先飞到桌子上方 5cm 处，再垂直下降。
  // Target Z: rel_z (接触面) + 0.05 (悬停高度)
  // Mask: {1e2, 1e2, 1e2} 全向引导 (SOS 软约束)，允许微小偏差，但强烈建议对齐。
  
  komo->addObjective({time-0.5}, FS_positionRel, {obj, table}, OT_sos, arr{0, 0, 1e2}, {0., 0., rel_z + 0.1});

  komo->addObjective({time-0.1}, FS_positionRel, {obj, table}, OT_sos, arr{1e2, 1e2, 1e2}, {0., 0., rel_z + 0.05});

  // ==============================================================================
  // 4. 最终几何约束 (Final Geometric Constraints)
  // ==============================================================================
  
  // A. 高度锁定 (接触)
  komo->addObjective({time}, FS_positionDiff, {obj, table}, OT_eq, arr{0,0,1}*1e2, {rel_z});

  // B. 垂直锁定 (Z轴向上)
  komo->addObjective({time}, FS_vectorZ, {obj}, OT_eq, {1e2}, {0., 0., 1.});

  // C. 旋转对齐 (非圆柱体)
  if(!isCylinder) {
      komo->addObjective({time}, FS_quaternionDiff, {table, obj}, OT_eq, {1e1});
  }

  // D. 桌面范围限制 (防止掉下去)
  double margin = 0.02;
  double x_lim = 0.5*tableSize(0) - margin;
  double y_lim = 0.5*tableSize(1) - margin;
  komo->addObjective({time}, FS_positionRel, {table, obj}, OT_ineq, arr{1,0,0}*1e1, {x_lim});
  komo->addObjective({time}, FS_positionRel, {table, obj}, OT_ineq, arr{-1,0,0}*1e1, {x_lim});
  komo->addObjective({time}, FS_positionRel, {table, obj}, OT_ineq, arr{0,1,0}*1e1, {y_lim});
  komo->addObjective({time}, FS_positionRel, {table, obj}, OT_ineq, arr{0,-1,0}*1e1, {y_lim});

  // ==============================================================================
  // 5. 定义避障组 (Genealogical Fix Applied)
  // ==============================================================================
  str gripper = "l_gripper"; 
  for(rai::Frame* fr : komo->world.frames){
      if(fr->name.endsWith("_gripper")) { gripper = fr->name; break; }
  }

  StringA movingParts;
  str prefix = "";
  if(gripper.endsWith("_gripper")) prefix = gripper.getFirstN(gripper.N-7); 
  movingParts.append(prefix + "palm");
  movingParts.append(prefix + "finger1");
  movingParts.append(prefix + "finger2");

  FrameL obstacles;
  for(rai::Frame *fr : komo->world.frames){
      if(fr->shape && fr->shape->type() != rai::ST_marker){ 
          bool isHand = movingParts.contains(fr->name);
          bool isPayload = false;
          if(fr->name == obj) isPayload = true;
          else if(objF){
              rai::Frame* p = fr->parent;
              while(p){
                  if(p == objF){ isPayload = true; break; }
                  p = p->parent;
              }
          }
          bool isTable = fr->name.contains("table");

          if(!isHand && !isPayload && !isTable){ 
              obstacles.append(fr);
          }
      }
  }

  // ==============================================================================
  // 6. 执行避障约束
  // ==============================================================================
  if(komo->stepsPerPhase >= 10){
      
      // [阶段 2: 空中巡航] (time-0.7 ~ time-0.2)
      // 保持 1cm 气囊 (注意：这里我统一修正为 -0.01，避免之前的 -0.05 导致过高)
      for(const str& handPart : movingParts){
          rai::Frame* handF = komo->world.getFrame(handPart);
          if(!handF || !handF->shape) continue;

          for(rai::Frame* obs : obstacles){
              bool isParent = (obs == handF->parent || handF == obs->parent);
              if(!isParent){
                  komo->addObjective({time-0.7, time-0.2}, FS_negDistance, {handPart, obs->name}, OT_ineq, {1e0}, {-0.01});
              }
          }
      }
  }

  // [阶段 3: 最终放置] (time-1 ~ time)
  // 允许接触，防止穿模
  komo->addObjective({time-1, time}, FS_accumulatedCollisions, {}, OT_ineq, {1e2}, {0});

  std::cout << "INFO: [action_place] Pre-Place Guidance (Z+5cm) Added." << std::endl;
}

// In manipTools.cpp

void ManipulationHelper::action_place_on_multi_support(double time, const str& obj, const StringA& supports){

  CHECK_GE(supports.N, 2, "Must have at least two support objects for placement!");

  // ==============================================================================
  // 1. 几何与位姿计算 (Target Calculation)
  // ==============================================================================
  arr positions(supports.N, 3);
  for(uint i=0; i<supports.N; ++i) positions[i] = komo->world.getFrame(supports(i))->getPosition();
  arr centroid_world = mean(positions, 0);
  
  rai::Frame* first_support = komo->world.getFrame(supports(0));
  rai::Frame* objF = komo->world.getFrame(obj); 
  CHECK(objF, "Object frame '" << obj << "' not found");

  double support_top_z_world = first_support->getPosition()(2) + 0.5 * first_support->getSize()(0);
  double obj_half_z = (objF->getShapeType() == rai::ST_cylinder) ? 0.5 * objF->getSize()(0) : 0.5 * objF->getSize()(2);
  
  rai::Transformation targetWorldPose;
  targetWorldPose.pos.set(centroid_world(0), centroid_world(1), support_top_z_world + obj_half_z);
  targetWorldPose.rot.setDeg(0, 1, 0, 0);

  // ==============================================================================
  // 2. 拓扑: 虚拟锚点 (Virtual Anchor)
  // ==============================================================================
  str virtualAnchorName;
  virtualAnchorName <<"virtualAnchor_for_" <<obj <<'_' <<time;

  // 创建自由锚点，让它代表物体的"完美归宿"
  rai::Frame* virtualAnchor = komo->addFrameDof(virtualAnchorName, "world", rai::JT_free, false);
  
  if(virtualAnchor && virtualAnchor->joint){
    arr q_initial = targetWorldPose.getArr7d();
    virtualAnchor->joint->setDofs(q_initial);
  }

  // 锚点位置软约束 (让求解器去微调最佳位置)
  komo->addObjective({time-1.0, time}, FS_pose, {virtualAnchorName}, OT_sos, {1e2}, targetWorldPose.getArr7d());

  // 切换所有权 (Kinematic Switch)
  komo->addRigidSwitch(time, {virtualAnchorName, obj}, true);

  // 相对位姿软约束 (物体最终要和锚点重合)
  komo->addObjective({time}, FS_poseDiff, {virtualAnchorName, obj}, OT_sos, {1e2});

  // 姿态约束 (垂直向上)
  komo->addObjective({time}, FS_vectorZ, {obj}, OT_sos, {1e1}, {0., 0., 1.});

  // ==============================================================================
  // [NEW] 3. 预放置漏斗 (Pre-Place Funnel)
  // ==============================================================================
  // 逻辑: 在 time-0.1 时刻，强制物体位于虚拟锚点正上方 5cm 处。
  // 因为 virtualAnchor 就在最终接触位置，所以相对坐标直接设为 0.05
  komo->addObjective({time-0.1}, FS_positionRel, {obj, virtualAnchorName}, OT_sos, arr{1e2, 1e2, 1e2}, {0., 0., 0.05});

  // ==============================================================================
  // 4. 避障逻辑: 族谱豁免 + 严格障碍物定义
  // ==============================================================================

  str gripper = "l_gripper"; 
  for(rai::Frame* fr : komo->world.frames){
      if(fr->name.endsWith("_gripper")) { gripper = fr->name; break; }
  }

  StringA movingParts;
  str prefix = "";
  if(gripper.endsWith("_gripper")) prefix = gripper.getFirstN(gripper.N-7); 
  movingParts.append(prefix + "palm");
  movingParts.append(prefix + "finger1");
  movingParts.append(prefix + "finger2");
  //增加物体自身和支撑物到避障列表中，避免穿模
  movingParts.append(obj); 

  FrameL obstacles;
  for(rai::Frame *fr : komo->world.frames){
      if(fr->shape && fr->shape->type() != rai::ST_marker){ 
          bool isHand = movingParts.contains(fr->name);
          bool isPayload = false;
          if(fr->name == obj) isPayload = true;
          else if(objF){
              rai::Frame* p = fr->parent;
              while(p){
                  if(p == objF){ isPayload = true; break; }
                  p = p->parent;
              }
          }

          if(!isHand && !isPayload){ 
              obstacles.append(fr);
          }
      }
  }

  // C. 执行三段式避障
  if(komo->stepsPerPhase >= 10){
      
      // [阶段 2: 空中巡航段] (time-0.8 ~ time-0.2)
      // 避开所有障碍物 (包括 Supports) 5cm。
      for(const str& handPart : movingParts){
          rai::Frame* handF = komo->world.getFrame(handPart);
          if(!handF || !handF->shape) continue;

          for(rai::Frame* obs : obstacles){
              bool isParent = (obs == handF->parent || handF == obs->parent);
              if(!isParent){
                  komo->addObjective({time-0.95, time-0.8}, FS_negDistance, {handPart, obs->name}, OT_ineq, {1e1}, {-0.01});

                  //komo->addObjective({time-0.8, time-0.2}, FS_negDistance, {handPart, obs->name}, OT_ineq, {1e0}, {-0.05});
              }
          }
      }
  }

  // [阶段 3: 最终放置段] (time-0.1 ~ time)
  // 允许接触
  //komo->addObjective({time-0.1, time}, FS_accumulatedCollisions, {}, OT_ineq, {1e2}, {0});

  std::cout << "INFO: [action_place_multi] Funnel Added: Z+5cm at t-0.1" << std::endl;
}


void ManipulationHelper::action_place_box(str action, double time, str obj, str table, str gripper, str place_direction){
  str snapFrame;
  snapFrame <<"placePose_" <<table <<'_' <<obj <<'_' <<time;

  if(time<komo->T/komo->stepsPerPhase){
    komo->addFrameDof(snapFrame, table, rai::JT_free, true, obj); //a permanent free stable target->place joint
    komo->addRigidSwitch(time, {snapFrame, obj}, true); //and a snap place->object
    if(komo->stepsPerPhase>2) komo->addObjective({time}, FS_poseDiff, {snapFrame, obj}, OT_eq, {1e0}, NoArr, 0, -1, 0);
  }

  str palm;
  if(gripper.endsWith("_gripper")){  palm = gripper.getFirstN(gripper.N-8); palm <<"_palm";  }
  place_box(time, obj, table, palm, place_direction);
  //gripper center at least inside object
  komo->addObjective({time}, FS_negDistance, {obj, gripper}, OT_ineq, {-1e1});

}

void ManipulationHelper::snap_switch(double time, str parent, str obj){
  /* a kinematic mode switch, where at given time the obj becomes attached to parent with zero relative transform
     the parent is typically a stable_frame (i.e. a frame that has parameterized but stable (i.e. constant) relative transform) */
  komo->addRigidSwitch(time, {parent, obj});
}

void ManipulationHelper::target_relative_xy_position(double time, const char* obj, const char* relativeTo, arr pos) {
  /* impose a specific 3D target position on some object */
  if(pos.N==2) {
    pos.append(0.);
  }
  k().addObjective({time}, FS_positionRel, {obj, relativeTo}, OT_eq, 1e1*arr{{2, 3}, {1, 0, 0, 0, 1, 0}}, pos);
}

void ManipulationHelper::target_x_orientation(double time, const char* obj, const arr& x_vector) {
  k().addObjective({time}, FS_vectorX, {obj}, OT_eq, {1e1}, x_vector);
}

void ManipulationHelper::bias(double time, arr& qBias, double scale) {
  /* impose a square potential bias directly in joint space */
  k().addObjective({time}, FS_qItself, {}, OT_sos, {scale}, qBias);
}

void ManipulationHelper::retract(const arr& time_interval, const char* gripper, double dist) {
  auto helper = STRING("_" <<gripper <<"_retract_" <<time_interval(0));
  int t = conv_time2step(time_interval(0), k().stepsPerPhase);
  rai::Frame *f = k().timeSlices(k().k_order+t, k().world[gripper]->ID);
  add_stable_frame(rai::JT_none, 0, helper, 0, f);
//  k().view(true, helper);

  k().addObjective(time_interval, FS_positionRel, {gripper, helper}, OT_eq, 1e2 * arr{{1, 3}, {1, 0, 0}});
  k().addObjective(time_interval, FS_quaternionDiff, {gripper, helper}, OT_eq, {1e2});
  k().addObjective({time_interval(1)}, FS_positionRel, {gripper, helper}, OT_ineq, -1e2 * arr{{1, 3}, {0, 0, 1}}, {0., 0., dist});
}

void ManipulationHelper::approach(const arr& time_interval, const char* gripper, double dist) {
  auto helper = STRING("_" <<gripper <<"_approach_" <<time_interval(1));
  int t = conv_time2step(time_interval(1), k().stepsPerPhase);
  rai::Frame *f = k().timeSlices(k().k_order+t, k().world[gripper]->ID);
  add_stable_frame(rai::JT_none, 0, helper, 0, f);
//  k().view(true, helper);

  k().addObjective(time_interval, FS_positionRel, {gripper, helper}, OT_eq, 1e2 * arr{{1, 3}, {1, 0, 0}});
  k().addObjective(time_interval, FS_quaternionDiff, {gripper, helper}, OT_eq, {1e2});
  k().addObjective({time_interval(0)}, FS_positionRel, {gripper, helper}, OT_ineq, -1e2 * arr{{1, 3}, {0, 0, 1}}, {0., 0., dist});
}

void ManipulationHelper::retractPush(const arr& time_interval, const char* gripper, double dist) {
  auto helper = STRING("_" <<gripper <<"_retractPush_"  <<time_interval(0));
  int t = conv_time2step(time_interval(0), k().stepsPerPhase);
  rai::Frame *f = k().timeSlices(k().k_order+t, k().world[gripper]->ID);
  add_stable_frame(rai::JT_none, 0, helper, 0, f);
//  k().addObjective(time_interval, FS_positionRel, {gripper, helper}, OT_eq, 1e2 * arr{{1,3},{1,0,0}});
//  k().addObjective(time_interval, FS_quaternionDiff, {gripper, helper}, OT_eq, {1e2});
  k().addObjective(time_interval, FS_positionRel, {gripper, helper}, OT_eq, 1e2 * arr{{1, 3}, {1, 0, 0}});
  k().addObjective({time_interval(1)}, FS_positionRel, {gripper, helper}, OT_ineq, 1e2 * arr{{1, 3}, {0, 1, 0}}, {0., -dist, 0.});
  k().addObjective({time_interval(1)}, FS_positionRel, {gripper, helper}, OT_ineq, -1e2 * arr{{1, 3}, {0, 0, 1}}, {0., 0., dist});
}

void ManipulationHelper::approachPush(const arr& time_interval, const char* gripper, double dist, str _helper) {
//  if(!helper.N) helper = STRING("_push_start");
//  k().addObjective(time_interval, FS_positionRel, {gripper, helper}, OT_eq, 1e2 * arr{{2,3},{1,0,0,0,0,1}});
//  k().addObjective({time_interval(0)}, FS_positionRel, {gripper, helper}, OT_ineq, 1e2 * arr{{1,3},{0,1,0}}, {0., -dist, 0.});
  auto helper = STRING("_" <<gripper <<"_approachPush_" <<time_interval(1));
  int t = conv_time2step(time_interval(1), k().stepsPerPhase);
  rai::Frame *f = k().timeSlices(k().k_order+t, k().world[gripper]->ID);
  add_stable_frame(rai::JT_none, 0, helper, 0, f);
  k().addObjective(time_interval, FS_positionRel, {gripper, helper}, OT_eq, 1e2 * arr{{1, 3}, {1, 0, 0}});
  k().addObjective({time_interval(0)}, FS_positionRel, {gripper, helper}, OT_ineq, 1e2 * arr{{1, 3}, {0, 1, 0}}, {0., -dist, 0.});
  k().addObjective({time_interval(0)}, FS_positionRel, {gripper, helper}, OT_ineq, -1e2 * arr{{1, 3}, {0, 0, 1}}, {0., 0., dist});
}

std::shared_ptr<SolverReturn> ManipulationHelper::solve(int verbose) {
  CHECK(komo, "komo is not setup");
  if(verbose>1) komo->set_viewer(Cviewer->get_viewer());
  rai::NLP_Solver sol;
  sol.setProblem(k().nlp());
  sol.opt/*.set_damping(1e-1) */->set_verbose(verbose-1) .set_stopTolerance(1e-3) .set_lambdaMax(100.) .set_stopInners(30) .set_stopEvals(500);
  ret = sol.solve();
  if(ret->feasible) {
    path = k().getPath_qOrg();
  } else {
    path.clear();
  }
  if(verbose>0) {
    if(!ret->feasible) {
      cout <<"  -- infeasible: " <<info <<"\n     " <<*ret <<endl;
      cout <<k().report(false, true, verbose>1) <<endl;
      cout <<"  --" <<endl;
      if(verbose>1) {
        cout <<sol.reportLagrangeGradients(k().featureNames) <<endl;
      }
      k().view(true, STRING("infeasible: " <<info <<"\n" <<*ret));
    } else {
      cout <<"  -- feasible: " <<info <<"\n     " <<*ret <<endl;
      if(verbose>2) {
        cout <<sol.reportLagrangeGradients(k().featureNames) <<endl;
        cout <<k().report(false, true, verbose>2) <<endl;
        rai::wait(.5);
        cout <<"  --" <<endl;
        k().view(true, STRING("feasible: " <<info <<"\n" <<*ret));
      }
    }
  }
  return ret;
}

arr ManipulationHelper::sample(const char* sampleMethod, int verbose) {
  CHECK(komo, "");

  NLP_Sampler sol(k().nlp());
  arr data;
  uintA dataEvals;
  double time = -rai::cpuTime();

//  sol.opt.seedMethod="gauss";
  if(sampleMethod) sol.opt.seedMethod=sampleMethod;
  sol.opt.verbose=verbose;
  sol.opt.downhillMaxSteps=50;
  sol.opt.slackMaxStep=.5;

  sol.run(data, dataEvals);
  time += rai::cpuTime();

  ret = make_shared<SolverReturn>();
  if(data.N){
    ret->x = data.reshape(-1);
    ret->evals = dataEvals.elem();
    ret->feasible = true;
  }else{
    ret->evals = k().evalCount;
    ret->feasible = false;
  }
  ret->time = time;
  ret->done = true;
  {
    arr totals = k().info_errorTotals(k().info_objectiveErrorTraces());
    ret->sos = totals(OT_sos);
    ret->ineq = totals(OT_ineq);
    ret->eq = totals(OT_eq);
    ret->f = totals(OT_f);
  }

  if(ret->feasible) {
    path = k().getPath_qOrg();
  } else {
    path.clear();
  }
  if(!ret->feasible) {
    if(verbose>0) {
      cout <<"  -- infeasible:" <<info <<"\n     " <<*ret <<endl;
      if(verbose>1) {
        cout <<k().report(false, true, verbose>1) <<endl;
        cout <<"  --" <<endl;
      }
      k().view(true, STRING("infeasible: " <<info <<"\n" <<*ret));
    }
  } else {
    if(verbose>0) {
      cout <<"  -- feasible:" <<info <<"\n     " <<*ret <<endl;
      if(verbose>2) {
        cout <<k().report(false, true, verbose>2) <<endl;
        cout <<"  --" <<endl;
        k().view(true, STRING("feasible: " <<info <<"\n" <<*ret));
      }
    }
  }

  return path;
}

void ManipulationHelper::debug(bool listObjectives, bool plotOverTime){
  cout <<"  -- DEBUG: " <<info <<endl;
  cout <<"  == solver return: " <<*ret <<endl;
  cout <<"  == all KOMO objectives with increasing errors:\n" <<k().report(false, listObjectives, plotOverTime) <<endl;
//  cout <<"  == objectives sorted by error and Lagrange gradient:\n" <<sol.reportLagrangeGradients(k().featureNames) <<endl;
  cout <<"  == view objective errors over slices in gnuplot" <<endl;
  cout <<"  == scroll through solution in display window using SHIFT-scroll" <<endl;
  k().view(true, STRING("debug: " <<info <<"\n" <<*ret));
}

void ManipulationHelper::play(rai::Configuration& C, double duration) {
  uintA dofIndices = C.getDofIDs();
  for(uint t=0; t<path.d0; t++) {
    C.setFrameState(k().getConfiguration_X(t));
    C.setJointState(k().getConfiguration_dofs(t, dofIndices));
    C.view(false, STRING("step " <<t <<"\n" <<info));
    rai::wait(duration/path.d0);
  }
}

std::shared_ptr<ManipulationHelper> ManipulationHelper::sub_motion(uint phase, uint steps_per_phase, bool fixEnd, double homing_scale, double acceleration_scale, bool accumulated_collisions, bool joint_limits, bool quaternion_norms, const StringA& activeDofs) {
  rai::Configuration C;
  arr q0, q1;
  k().getSubProblem(phase, C, q0, q1);

  if(activeDofs.N){
    DofL orgDofs = C.activeDofs;
    C.selectJointsByName(activeDofs);
    C.setDofState(q1, orgDofs);
    q1 = C.getJointState();
    C.setDofState(q0, orgDofs);
    q0 = C.getJointState();
  }

  if(!fixEnd) q1.clear();

  std::shared_ptr<ManipulationHelper> manip = make_shared<ManipulationHelper>(STRING("sub_motion"<<phase));
  manip->setup_point_to_point_motion(C, q1, steps_per_phase, homing_scale, acceleration_scale, accumulated_collisions, joint_limits, quaternion_norms);
  manip->Cviewer = Cviewer;
  return manip;
}

std::shared_ptr<rai::RRT_PathFinder> ManipulationHelper::sub_rrt(uint phase, const StringA& explicitCollisionPairs, const StringA& activeDofs) {
  std::shared_ptr<rai::Configuration> C = make_shared<rai::Configuration>();
  arr q0, q1;
  k().getSubProblem(phase, *C, q0, q1);

  if(activeDofs.N){
    DofL orgDofs = C->activeDofs;
    C->selectJointsByName(activeDofs);
    C->setDofState(q1, orgDofs);
    q1 = C->getJointState();
    C->setDofState(q0, orgDofs);
    q0 = C->getJointState();
  }

  std::shared_ptr<rai::RRT_PathFinder> rrt = make_shared<rai::RRT_PathFinder>();
  rrt->setProblem(C);
  rrt->setStartGoal(q0, q1);
  if(explicitCollisionPairs.N) rrt->setExplicitCollisionPairs(explicitCollisionPairs);

  return rrt;
}
