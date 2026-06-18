#!/usr/bin/env python3
"""
Compute initial TCP (gripper) position from retract joint configuration.
Output: 6D pose (x, y, z, roll, pitch, yaw) for VLM prompt.
"""

import sys
sys.path.insert(0, '/home/leslie/Projects/VLM_LGP')

import numpy as np
try:
    import robotic as ry
except ImportError:
    print("ERROR: robotic (RAI) module not found. Install via: pip install robotic")
    sys.exit(1)

def compute_retract_pose():
    """
    Compute TCP position from retract joint configuration in planar_scene.g
    """
    # Create config from scene file
    C = ry.Config()
    C.addFile('/home/leslie/Projects/VLM_LGP/test/planar_exp/planar_scene.g')
    
    # Set arm base position
    # l_panda_base is attached to table at Q:"t(0 0 0.05)"
    # (table surface is at z=0.6, so arm base is at z=0.65 in world frame)
    
    # Get retract joint configuration
    retract_joints = {
        'l_panda_joint1': 0.0,
        'l_panda_joint2': -1.5,
        'l_panda_joint3': 0.0,
        'l_panda_joint4': -2.5,
        'l_panda_joint5': 0.0,
        'l_panda_joint6': 1.5,
        'l_panda_joint7': 0.0,
    }
    
    # Set joint angles
    for joint_name, q_val in retract_joints.items():
        try:
            C.setJointState([q_val], [joint_name])
        except:
            pass  # Joint might not exist, skip
    
    # Get TCP frame (end-effector)
    # Try common panda gripper frame names
    tcp_frame_name = None
    for candidate in ['l_panda_hand_joint', 'l_gripper', 'l_palm', 'l_panda_joint8']:
        try:
            tcp_frame = C.getFrame(candidate)
            tcp_frame_name = candidate
            print(f"Using TCP frame: {tcp_frame_name}")
            break
        except:
            pass
    
    if tcp_frame_name is None:
        print("ERROR: Could not find any end-effector frame")
        sys.exit(1)
    
    # Get TCP position and orientation
    tcp_pos = tcp_frame.getPosition()  # [x, y, z]
    R = tcp_frame.getRotationMatrix()  # 3x3 rotation matrix
    
    # Convert rotation matrix to Euler angles (ZYX convention)
    # R = R_z(yaw) @ R_y(pitch) @ R_x(roll)
    # Extract Euler angles
    roll, pitch, yaw = matrix_to_euler_zyx(R)
    
    print("=" * 60)
    print("INITIAL TCP POSE (RETRACT CONFIGURATION)")
    print("=" * 60)
    print(f"Position (x, y, z): {tcp_pos}")
    print(f"Orientation (Euler ZYX):")
    print(f"  roll:  {roll:.6f} rad = {np.degrees(roll):.2f}°")
    print(f"  pitch: {pitch:.6f} rad = {np.degrees(pitch):.2f}°")
    print(f"  yaw:   {yaw:.6f} rad = {np.degrees(yaw):.2f}°")
    print()
    print("Output format for VLM prompt:")
    print(f"{tcp_pos[0]:.4f} {tcp_pos[1]:.4f} {tcp_pos[2]:.4f} {roll:.6f} {pitch:.6f} {yaw:.6f}")
    print()
    print("Rotation matrix (for verification):")
    print(R)
    print("=" * 60)
    
    return tcp_pos, np.array([roll, pitch, yaw])

def matrix_to_euler_zyx(R):
    """
    Convert 3x3 rotation matrix to ZYX Euler angles.
    R = R_z(yaw) @ R_y(pitch) @ R_x(roll)
    
    Returns: roll, pitch, yaw (in radians)
    """
    # Ensure R is normalized
    R = np.array(R, dtype=float)
    
    # Extract pitch
    sin_pitch = -R[2, 0]
    # Clamp to [-1, 1] to avoid numerical errors
    sin_pitch = np.clip(sin_pitch, -1.0, 1.0)
    pitch = np.arcsin(sin_pitch)
    
    # Extract roll and yaw
    cos_pitch = np.cos(pitch)
    if np.abs(cos_pitch) > 1e-6:
        roll = np.arctan2(R[2, 1], R[2, 2])
        yaw = np.arctan2(R[1, 0], R[0, 0])
    else:
        # Singularity: pitch = ±π/2
        roll = 0.0
        yaw = np.arctan2(-R[0, 1], R[1, 1])
    
    return roll, pitch, yaw

if __name__ == '__main__':
    try:
        tcp_pos, tcp_rot = compute_retract_pose()
    except Exception as e:
        print(f"ERROR: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
