#include <KOMO/manipTools.h>
#include <Kin/kin.h>
#include <Kin/frame.h>
#include <Optim/NLP_Solver.h>

#include <algorithm>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

namespace fs = std::filesystem;

struct ObjectCheckResult {
  std::string name;
  std::string objectType;
  std::string action;
  std::string status;
  bool feasible = false;
  double timeSec = 0.0;
  std::string message;
  int qDim = 0;
  std::vector<double> times;
  std::vector<std::vector<double>> qRows;
};

static bool hasLogicalFlag(rai::Frame* f, const char* key) {
  if(!f || !f->ats) return false;
  auto* logical = f->ats->findNode("logical");
  if(!logical) return false;
  return logical->graph().findNode(key) != nullptr;
}

static std::string detectObjectType(rai::Frame* f) {
  if(!f || !f->shape) return "unknown";
  if(hasLogicalFlag(f, "is_cylinder") || f->shape->type()==rai::ST_cylinder) return "cylinder";
  if(f->shape->type()==rai::ST_ssBox || f->shape->type()==rai::ST_box) return "box";
  return "unknown";
}

static std::vector<std::string> collectCandidateObjects(rai::Configuration& C) {
  std::vector<std::string> out;
  for(rai::Frame* f : C.frames) {
    if(!f) continue;
    if(!hasLogicalFlag(f, "is_object")) continue;
    // Skip helper or base utility frames that are not grasp targets in this checker.
    if(f->name.contains("base") && !f->name.startsWith("base")) continue;
    if(f->name.contains("table") || f->name.contains("desk")) continue;
    if(!f->shape) continue;
    if(f->shape->type()!=rai::ST_ssBox && f->shape->type()!=rai::ST_box && f->shape->type()!=rai::ST_cylinder) continue;
    out.push_back(std::string(f->name.p));
  }
  std::sort(out.begin(), out.end());
  out.erase(std::unique(out.begin(), out.end()), out.end());
  return out;
}

static ObjectCheckResult runPickWaypointForObject(const std::string& scenePath,
                                                  const std::string& objectName,
                                                  const std::string& gripper,
                                                  const std::string& fromFrame) {
  ObjectCheckResult r;
  r.name = objectName;

  rai::Configuration C;
  C.addFile(scenePath.c_str());

  rai::Frame* obj = C.getFrame(objectName.c_str(), false);
  if(!obj) {
    r.objectType = "unknown";
    r.action = "unknown";
    r.status = "error";
    r.message = "object frame not found";
    return r;
  }

  r.objectType = detectObjectType(obj);
  r.action = (r.objectType == "cylinder") ? "pick_cylinder" : "pick_touch";

  try {
    ManipulationHelper manip;
    manip.setup_sequence(C, 1, 1e-2, 1e-1, true, true, true);

    const double t = 1.0;
    if(r.action == "pick_cylinder") {
      manip.action_pick_cylinder(t, gripper.c_str(), objectName.c_str());
    } else {
      // fromFrame is kept for traceability; current action_pick implementation uses obj+gripper.
      (void)fromFrame;
      manip.action_pick("pick_touch", t, gripper.c_str(), objectName.c_str());
    }

    auto ret = rai::NLP_Solver(manip.komo->nlp(), 0).solve();
    r.feasible = ret->feasible;
    r.timeSec = ret->evals;
    r.status = r.feasible ? "feasible" : "infeasible";
    r.message = r.feasible ? "solver feasible" : "solver infeasible";

    arr qPath = manip.komo->getPath_qOrg();
    arr pathTimes = manip.komo->getPath_times();
    if(qPath.nd == 2 && qPath.d0 > 0 && qPath.d1 > 0 && pathTimes.N > 0) {
      const uint n = std::min((uint)qPath.d0, pathTimes.N);
      r.qDim = (int)qPath.d1;
      r.times.reserve(n);
      r.qRows.reserve(n);
      for(uint i=0; i<n; ++i) {
        r.times.push_back(pathTimes(i));
        std::vector<double> q;
        q.reserve((size_t)qPath.d1);
        for(uint j=0; j<(uint)qPath.d1; ++j) q.push_back(qPath(i, j));
        r.qRows.push_back(std::move(q));
      }
    }
  } catch(const std::exception& e) {
    r.status = "error";
    r.message = e.what();
  }

  return r;
}

static std::string jsonEscape(const std::string& s) {
  std::ostringstream o;
  for(char c : s) {
    switch(c) {
      case '\\': o << "\\\\"; break;
      case '"': o << "\\\""; break;
      case '\n': o << "\\n"; break;
      case '\r': o << "\\r"; break;
      case '\t': o << "\\t"; break;
      default: o << c; break;
    }
  }
  return o.str();
}

static void writeReportJson(const std::string& outPath,
                            const std::string& scenePath,
                            const std::string& gripper,
                            const std::string& trajLogPath,
                            const std::vector<ObjectCheckResult>& results) {
  int nFeasible = 0;
  int nInfeasible = 0;
  int nError = 0;
  for(const auto& r : results) {
    if(r.status == "feasible") nFeasible++;
    else if(r.status == "infeasible") nInfeasible++;
    else nError++;
  }

  std::ofstream f(outPath);
  f << "{\n";
  f << "  \"scene_path\": \"" << jsonEscape(scenePath) << "\",\n";
  f << "  \"mode\": \"pick_waypoint_only\",\n";
  f << "  \"gripper\": \"" << jsonEscape(gripper) << "\",\n";
  f << "  \"trajectory_log_path\": \"" << jsonEscape(trajLogPath) << "\",\n";
  f << "  \"results\": {\n";
  for(size_t i=0; i<results.size(); ++i) {
    const auto& r = results[i];
    f << "    \"" << jsonEscape(r.name) << "\": {\n";
    f << "      \"object_type\": \"" << jsonEscape(r.objectType) << "\",\n";
    f << "      \"pick_action\": \"" << jsonEscape(r.action) << "\",\n";
    f << "      \"status\": \"" << jsonEscape(r.status) << "\",\n";
    f << "      \"message\": \"" << jsonEscape(r.message) << "\"\n";
    f << "    }" << (i+1<results.size()?",":"") << "\n";
  }
  f << "  },\n";
  f << "  \"summary\": {\n";
  f << "    \"total\": " << results.size() << ",\n";
  f << "    \"feasible\": " << nFeasible << ",\n";
  f << "    \"infeasible\": " << nInfeasible << ",\n";
  f << "    \"error\": " << nError << "\n";
  f << "  }\n";
  f << "}\n";
}

static void appendTrajectoryBlock(std::ofstream& f, const ObjectCheckResult& r) {
  f << "[OBJECT] " << r.name
    << " action=" << r.action
    << " status=" << r.status
    << "\n";

  if(r.qRows.empty() || r.times.empty() || r.qDim <= 0) {
    f << "[TRAJ] no trajectory generated\n\n";
    return;
  }

  f << ">>> V-LGP TRAJECTORY START <<<\n";
  f << "DIM: " << r.qRows.size() << " " << (r.qDim + 1) << "\n";
  for(size_t i=0; i<r.qRows.size(); ++i) {
    f << r.times[i];
    for(double q : r.qRows[i]) f << ' ' << q;
    f << "\n";
  }
  f << ">>> V-LGP TRAJECTORY END <<<\n\n";
}

int main(int argc, char** argv) {
  rai::initCmdLine(argc, argv);

  if(argc < 2) {
    std::cout << "Usage: " << argv[0] << " <scene_g> [--object name] [--gripper l_gripper] [--from table] [--json output.json] [--traj-log output.log]" << std::endl;
    return 1;
  }

  std::string scenePath = argv[1];
  std::string objectName;
  std::string gripper = "l_gripper";
  std::string fromFrame = "table";
  std::string jsonPath = "generated/pick_waypoint_report.json";
  std::string trajLogPath = "generated/pick_waypoint_trajectory.log";

  for(int i=2; i<argc; ++i) {
    std::string a = argv[i];
    if(a == "--object" && i+1<argc) objectName = argv[++i];
    else if(a == "--gripper" && i+1<argc) gripper = argv[++i];
    else if(a == "--from" && i+1<argc) fromFrame = argv[++i];
    else if(a == "--json" && i+1<argc) jsonPath = argv[++i];
    else if(a == "--traj-log" && i+1<argc) trajLogPath = argv[++i];
  }

  rai::Configuration C;
  C.addFile(scenePath.c_str());

  std::vector<std::string> targets;
  if(!objectName.empty()) {
    targets.push_back(objectName);
  } else {
    targets = collectCandidateObjects(C);
  }

  if(targets.empty()) {
    std::cerr << "[pick-waypoint] no candidate objects found" << std::endl;
    return 2;
  }

  std::vector<ObjectCheckResult> results;
  results.reserve(targets.size());

  fs::path trajP(trajLogPath);
  if(trajP.has_parent_path()) fs::create_directories(trajP.parent_path());
  std::ofstream trajFile(trajLogPath, std::ios::out | std::ios::trunc);
  if(!trajFile.is_open()) {
    std::cerr << "[pick-waypoint] failed to open trajectory log: " << trajLogPath << std::endl;
    return 3;
  }
  trajFile << "# pick-waypoint trajectory log\n";
  trajFile << "# scene=" << scenePath << "\n";
  trajFile << "# mode=pick_waypoint_only\n\n";

  std::cout << "[pick-waypoint] scene=" << scenePath << " targets=" << targets.size() << std::endl;
  for(const auto& t : targets) {
    auto r = runPickWaypointForObject(scenePath, t, gripper, fromFrame);
    std::cout << "  - obj=" << r.name << " action=" << r.action << " status=" << r.status;
    if(!r.message.empty()) std::cout << " msg='" << r.message << "'";
    std::cout << std::endl;
    appendTrajectoryBlock(trajFile, r);
    results.push_back(r);
  }

  fs::path outP(jsonPath);
  if(outP.has_parent_path()) fs::create_directories(outP.parent_path());
  writeReportJson(jsonPath, scenePath, gripper, trajLogPath, results);
  std::cout << "[pick-waypoint] report=" << jsonPath << std::endl;
  std::cout << "[pick-waypoint] traj-log=" << trajLogPath << std::endl;
  return 0;
}
