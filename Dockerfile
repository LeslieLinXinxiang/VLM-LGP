# ==============================================================================
# VLM-LGP OFFICIAL DEPLOYMENT IMAGE
# ==============================================================================
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=C.UTF-8

# 1. 系统基础环境与 ABI 修复 (关键：防止 libstdc++ 符号错误)
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common gpg gpg-agent && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y --only-upgrade libstdc++6

# 2. 安装所有物理依赖
RUN apt-get install -y --no-install-recommends \
    build-essential g++ clang make cmake git wget curl unzip pkg-config sudo vim \
    python3 python3-pip python3-dev \
    liblapack-dev libblas-dev libf2c2-dev libqhull-dev \
    libeigen3-dev libjsoncpp-dev libyaml-cpp-dev libhdf5-dev \
    libassimp-dev libglew-dev freeglut3-dev libglm-dev libx11-dev \
    libglu1-mesa-dev libglfw3-dev libpng-dev libfreetype-dev \
    fonts-ubuntu ca-certificates \
    libopencv-dev libpcl-dev libceres-dev \
    libnlopt-dev libnlopt-cxx-dev \
    coinor-libipopt-dev \
    libann-dev \
    libccd-dev \
    && rm -rf /var/lib/apt/lists/*

# 3. Python 环境
COPY requirements.txt /tmp/
RUN pip3 install --no-cache-dir pybind11 && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt

# 4. 手动编译 FCL 0.5 (API 兼容性核心)
WORKDIR /root
RUN git clone https://github.com/flexible-collision-library/fcl.git && \
    cd fcl && git checkout 0.5.0 && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DFCL_NO_DEFAULT_RPATH=OFF -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j$(nproc) && make install

# 5. 注入整个仓库 (全盘复制策略)
WORKDIR /app
COPY . /app

# [重要] 清理宿主机残留，强制 Docker 内原生重编
RUN find . -name "*.o" -delete && \
    find . -name "*.so" -delete && \
    find . -name "*.a" -delete && \
    rm -rf rai/lib/* rai/src/*/OBJS

# 6. 安装 PhysX (物理引擎核心)
WORKDIR /app/rai/build
RUN mkdir -p /root/.local/lib && \
    chmod +x ../_make/install.sh && \
    ../_make/install.sh physx && \
    ln -sf /root/.local/bin/linux.clang/release /root/.local/lib/PhysX

# 7. 环境变量设置
ENV HOME=/root
ENV LD_LIBRARY_PATH="/root/.local/lib/PhysX:/usr/local/lib:${LD_LIBRARY_PATH}"
ENV LIBRARY_PATH="/root/.local/lib/PhysX:/usr/local/lib:${LIBRARY_PATH}"
ENV CPATH="/root/git/physx/physx/include:/root/git/physx/pxshared/include:/usr/local/include:/usr/include/opencv4:/usr/include/eigen3:${CPATH}"

# 8. RAI 构建配置 (config.mk)
WORKDIR /app/rai/_make
RUN echo "PHYSX = 1\nCXXFLAGS += -DRAI_PHYSX\nGL = 1\nPYTHON = 1\nRAI_PyBind = 1\nROS = 0\nOPENCV = 1\nPCL = 1\nFCL = 1\nBULLET = 0\nCERES = 0\nNLOPT = 1\nIPOPT = 1\nLGPL = 0" > config.mk && \
    sed -i 's/-lANN/-lann/g' defines.mk

# 9. 分步编译 RAI 核心 (按依赖拓扑)
WORKDIR /app/rai
RUN cd src/Core && make -j$(nproc) && \
    cd ../Algo && make -j$(nproc) && \
    cd ../Geo && make -j$(nproc) && \
    cd ../Kin && make -j$(nproc) && \
    cd ../Search && make -j$(nproc) && \
    cd ../Logic && make -j$(nproc) && \
    cd ../PathAlgos && make -j$(nproc) && \
    cd ../KOMO && make -j$(nproc) && \
    cd ../LGP && make -j$(nproc) && \
    cd ../DataGen && make -j$(nproc) && \
    cd ../ry && make -j$(nproc)

# 10. [核心] 编译自定义 Headless 求解器 (docker_bin/x.exe)
WORKDIR /app/docker_bin
# 运行你放在 docker_bin 里的 Makefile。
# 注意：Makefile 里的路径可能需要根据容器环境微调，通常建议在 Makefile 里使用相对路径 ../rai
RUN make -j$(nproc) && \
    chmod +x x.exe

# 11. Python 包装器固化
WORKDIR /app/rai/lib
RUN echo "import sys, os\nsys.path.append(os.path.dirname(__file__))\nfrom _robotic import *\nimport _robotic" > ry.py && \
    echo "from ry import *\nimport ry" > robotic.py

# 12. 运行时入口
WORKDIR /app
ENV PYTHONPATH="/app/rai/lib:/app/rai/src/ry:${PYTHONPATH}"

# 打印成功标志
RUN python3 -c "import robotic; print('\n>>> GITHUB BUILD SUCCESS: Environment Fully Consolidated. <<<')"

CMD ["/bin/bash"]
