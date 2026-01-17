# V-LGP: Vision-Language Geometric Programming
### 🧠 Neuro-Symbolic Robot Manipulation with Receding Horizon Planning

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![ROS2](https://img.shields.io/badge/ROS2-Jazzy-blue)](https://docs.ros.org/en/jazzy/)
[![Physics](https://img.shields.io/badge/MuJoCo-3.x-orange)](https://mujoco.org/)

**V-LGP** bridges the semantic reasoning of **VLMs** (e.g., Gemini, Qwen) with the rigorous constraints of **Logic-Geometric Programming** (RAI/KOMO). It enables robust Sim-to-Real transfer for complex, multi-stage manipulation tasks.

---

## 🏗️ Architecture

The system uses a **Hybrid Architecture**:
1.  **Host (Planner)**: Runs VLM logic & C++ Geometric Solver (`rai`).
2.  **Docker (Physics)**: Runs high-fidelity MuJoCo simulation & ROS 2 Controllers.

![System Pipeline](assets/pipeline.png)

---

## 💻 Prerequisites (Host)

*   **OS**: Ubuntu 22.04 or 24.04.
*   **ROS 2**: Distribution **Jazzy** (installed on Host).
*   **Hardware**: 32GB+ RAM, NVIDIA GPU.

---

## 🛠️ Installation

### 1. Install Dependencies & Clone
```bash
# System Libs
sudo apt update && sudo apt install build-essential cmake g++ git python3-dev \
    liblapack-dev libblas-dev libf2c2-dev libhdf5-openmpi-dev \
    libassimp-dev libqhull-dev libgl1-mesa-dev libglew-dev libglfw3-dev freeglut3-dev

# Clone Project (Recursive is MUST)
mkdir -p ~/Projects && cd ~/Projects
git clone --recursive https://github.com/YourUsername/VLM_LGP.git
cd VLM_LGP
```

### 2. Compile Solver (`rai`)
We compile the solver locally. **Do NOT use `pip install robotic`.**
```bash
# Compile Core
cd rai
make -j$(nproc)

# Compile Python Bindings
cd src/ry
make -j$(nproc)
```

### 3. Setup Python Environment
We use **Conda** for AI libs, but inherit **ROS 2** from the system.
```bash
conda create -n vlm_jazzy python=3.10
conda activate vlm_jazzy
pip install -r requirements.txt
```

### 4. Configure Environment
Add to your `~/.bashrc`:
```bash
export VLM_LGP_ROOT="$HOME/Projects/VLM_LGP"
export RAI_PATH="$VLM_LGP_ROOT/rai"
export PYTHONPATH="$RAI_PATH/lib:$RAI_PATH/src/ry:$PYTHONPATH"
export LD_LIBRARY_PATH="$RAI_PATH/lib:$LD_LIBRARY_PATH"
export GEMINI_API_KEY="AIzaSyYourKeyHere"
```
*Apply:* `source ~/.bashrc`

---

## 🐳 Simulation Setup

### 1. Build & Run Docker
```bash
cd $VLM_LGP_ROOT/docker
docker build -t vlm-lgp:latest .

# Run Container (with code mapping)
xhost +local:root
docker run -it --rm --net=host --ipc=host --pid=host \
    --gpus all \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $VLM_LGP_ROOT/simulation:/root/ros2_ws/src \
    vlm-lgp:latest /bin/bash
```

### 2. Compile Inside Docker (One-Time)
Inside the container, run the auto-setup script:
```bash
# This compiles the simulation controllers
./setup_container.sh
```

---

## 🚀 Quick Start

You need **Two Terminals**.

### Terminal 1: Physics Server (Docker)
```bash
# Inside Docker
source /root/ros2_ws/install/setup.bash
ros2 launch interactive_marker interactive_marker.launch.py
```
*Wait for the MuJoCo window to appear.*

### Terminal 2: The Planner (Host)
```bash
# On Host
conda activate vlm_jazzy
source /opt/ros/jazzy/setup.bash

cd ~/Projects/VLM_LGP
python3 driver.py
```
*The robot will automatically scan the scene, plan, and execute the task.*

---

## ⚠️ Troubleshooting

*   **"ModuleNotFoundError: ry"**: Check `PYTHONPATH` in `~/.bashrc`.
*   **Physics Jitter**: Ensure XML uses `solimp="0.9 0.95 0.001"`.
*   **Docker Error**: If `setup_container.sh` fails, ensure you mounted the volume correctly.

---

## 🤝 Acknowledgements

The action solver in this project is based on an optimized version of the [RAI](https://github.com/MarcToussaint/rai) framework by Marc Toussaint.