BASE = ../rai

DEPEND = Core Kin Gui Geo KOMO LGP Logic Optim Algo

OBJS = main.o

include $(BASE)/_make/generic.mk

# Build-only target for waypoint pick feasibility checker.
pick-waypoint: pick_waypoint_check.exe

pick_waypoint_check.exe: pick_waypoint_check.o $(BUILDS)
	$(LINK) $(LDFLAGS) -o $@ pick_waypoint_check.o $(LIBS)

# Offscreen scene renderer used to produce ablation figures.
render-scene: render_scene.exe

render_scene.exe: render_scene.o $(BUILDS)
	$(LINK) $(LDFLAGS) -o $@ render_scene.o $(LIBS)

# Renders the arm at the solved grasp pose (feasible or not) for ablation figures.
render-grasp: render_grasp.exe

render_grasp.exe: render_grasp.o $(BUILDS)
	$(LINK) $(LDFLAGS) -o $@ render_grasp.o $(LIBS)
