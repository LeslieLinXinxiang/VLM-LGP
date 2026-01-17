# 基础镜像：Ubuntu 22.04 (Jammy)
FROM ubuntu:22.04

# --- 1. 基础设置 ---
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    locales \
    curl \
    gnupg \
    lsb-release \
    wget \
    git \
    build-essential \
    cmake \
    python3-pip \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置语言
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8

# --- 2. 安装 ROS 2 Humble ---
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu jammy main" > /etc/apt/sources.list.d/ros2.list && \
    apt-get update && apt-get install -y ros-humble-desktop ros-dev-tools python3-rosdep

# --- 3. 安装 Miniforge (替代 Miniconda 以避开 ToS 问题) ---
# 下载 Miniforge3
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O ~/miniforge.sh && \
    bash ~/miniforge.sh -b -p /opt/conda && \
    rm ~/miniforge.sh

# 将 conda 加入 PATH
ENV PATH /opt/conda/bin:$PATH

# --- 4. 配置 Conda 环境 ---
# 创建 vlm 环境 python 3.10
RUN conda create -n vlm python=3.10 -y && \
    echo "conda activate vlm" >> ~/.bashrc

# 在 vlm 环境中安装库
# 注意：使用 -n vlm 指定环境
RUN conda install -n vlm -y pip && \
    /opt/conda/envs/vlm/bin/pip install \
    mujoco \
    opencv-python \
    numpy \
    catkin-pkg \
    lark \
    empy

# --- 5. 设置工作空间 & 环境变量 ---
WORKDIR /root/ros2_ws

# 每次进入容器自动加载 ROS 2 Humble 和 Conda
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc

# --- 6. 初始化 rosdep ---
RUN rosdep init && \
    rosdep update

# --- 7. 设置入口 ---
ENTRYPOINT ["/bin/bash"]