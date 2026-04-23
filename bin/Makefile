BASE = ../rai

DEPEND = Core Kin Gui Geo KOMO LGP Logic Optim Algo

OBJS = main.o

include $(BASE)/_make/generic.mk

# Build-only target for waypoint pick feasibility checker.
pick-waypoint: pick_waypoint_check.exe

pick_waypoint_check.exe: pick_waypoint_check.o $(BUILDS)
	$(LINK) $(LDFLAGS) -o $@ pick_waypoint_check.o $(LIBS)
