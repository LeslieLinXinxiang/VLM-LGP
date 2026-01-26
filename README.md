# VLM-LGP: Vision-Language Logic-Geometric Programming

VLM-LGP is a closed-loop robotic manipulation framework that integrates Vision-Language Models (VLM) with Logic-Geometric Programming (LGP). The system utilizes high-level semantic reasoning to drive low-level geometric motion planning.

## 🧠 System Architecture
![System Architecture](./assets/pipeline.png)

## ⚖️ LGP Solver Optimizations
The solver is an optimized fork of the [rai](https://github.com/MarcToussaint/rai) library. We have refined core functions and introduced specialized modules to satisfy the practical requirements of **real-machine hardware deployment**.

---

## 🐳 Docker Deployment (Recommended for Leeds Deployment)
To ensure ABI compatibility and avoid dependency conflicts (especially FCL and PhysX), we provide a pre-configured Docker environment. 

**Note**: The Docker version is **Headless**. It disables all GUI pop-ups to optimize performance and ensures raw trajectory output directly to the bridge.

### 1. Build the Image
```bash
# Build the brain with a fully isolated 22.04 environment
docker build -t vlm-lgp:final .
```

### 2. Run the Container
```bash
# Use --net=host for low-latency ZMQ communication with the Host
docker run --net=host -it --rm vlm-lgp:final
```

### 3. Headless Solver Execution
VLM-LGP requires specific executables for different running modes. You must compile the one matching your usage (or both).

```bash
# [Target A] Native GUI Solver (For driver.py)
cd ~/VLM-LGP/rai/bin
make -j$(nproc)

# [Target B] Headless/Docker Solver (For docker_driver.py)
cd ~/VLM-LGP/rai/docker_bin
make -j$(nproc)
```

Inside the container, the solver runs in **Headless Mode**:
- **No GUI windows** will be initialized.
- **Trajectory Output**: High-frequency (100Hz/500Hz) resampled trajectories are printed to `stdout` and sent via ZMQ.
- **Solver Location**: The headless executable is located at `/app/docker_bin/x.exe`.

---

## 🤖 Simulation & Bridge Testing

VLM-LGP uses a **Split-Brain Architecture**:
- **Brain (Docker)**: Computes LGP nodes and generates trajectories.
- **Body (Host/Robot)**: Receives trajectories and executes via ZMQ.

### Communication Verification (Mock Loop)
1. **On Host**: Start the mock robot agent to listen for trajectories:
   ```bash
   python3 host_mock.py
   ```
2. **In Docker**: Execute the solver bridge:
   ```bash
   python3 test_bridge_docker.py
   ```
*If communication is successful, the Host will display the received joint-space waypoints.*

---

## 🛠️ Native Installation (Legacy/Manual)

*Use this only if you prefer to build directly on your Ubuntu 22.04+ system.*

### 1. Dependencies & rai Build
Refer to the original instructions to install system-level libraries:
```bash
cd rai/_make
# Ensure FCL 0.5.0 is manually compiled if system version is 0.7+
./install.sh libann && ./install.sh libccd && ./install.sh fcl && ./install.sh physx
cd ..
make -j$(nproc)
```

### 2. Path Setup
```bash
export PYTHONPATH=$HOME/VLM-LGP/rai/lib:$PYTHONPATH
export LD_LIBRARY_PATH=$HOME/VLM-LGP/rai/lib:$LD_LIBRARY_PATH
```

---

## ✅ Verification & ROS 2 Integration
VLM-LGP uses **MuJoCo** for high-fidelity simulation. Symlink the simulation folder into your ROS 2 workspace:
```bash
cd ~/ros2_ws/src
ln -s ~/VLM-LGP/simulation .
cd ..
colcon build --symlink-install
```

## Documentation
- Solver Core: [rai/README.md](rai/README.md)
- Simulation Framework: [mujoco_ros2_control](https://github.com/moveit/mujoco_ros2_control)
