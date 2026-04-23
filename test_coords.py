import robotic as ry
import math

C = ry.Config()
C.addFile('generated/scene_named.g')

def check_obj(name):
    target = C.getFrame(name)
    pos_w = target.getPosition()
    # local_x = world_y + 0.3
    # local_y = -world_x
    # local_z = world_z - 0.65
    local_x = pos_w[1] + 0.3
    local_y = -pos_w[0]
    local_z = pos_w[2] - 0.65
    print(f'{name}: RAI world {pos_w} => manual local ({local_x:.3f}, {local_y:.3f}, {local_z:.3f})')

check_obj('rect_1')
check_obj('rect_4')
check_obj('cube_1')
