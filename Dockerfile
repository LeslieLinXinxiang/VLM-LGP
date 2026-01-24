# ==============================================================================
# V-LGP DEPLOYMENT IMAGE - V200.1 (Fixed GPG Issue)
# ==============================================================================
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=C.UTF-8

# ------------------------------------------------------------------------------
# 1. SYSTEM BASE & ABI FIXES (LAKOS FIX: Added gpg/gpg-agent)
# ------------------------------------------------------------------------------
# 关键修复：显式安装 gpg 和 gpg-agent，否则 add-apt-repository 会失败
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    gpg \
    gpg-agent && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y --only-upgrade libstdc++6

# 安装基础编译工具 (排除不兼容的 libfcl-dev)
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

# ------------------------------------------------------------------------------
# 2. PYTHON DEPENDENCIES
# ------------------------------------------------------------------------------
COPY requirements.txt /tmp/
RUN pip3 install --no-cache-dir pybind11 && \
    pip3 install --no-cache-dir -r /tmp/requirements.txt

# ------------------------------------------------------------------------------
# 3. [MANUAL FIX] FCL 0.5.0 (Source Build)
# ------------------------------------------------------------------------------
WORKDIR /root
RUN git clone https://github.com/flexible-collision-library/fcl.git && \
    cd fcl && git checkout 0.5.0 && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DFCL_NO_DEFAULT_RPATH=OFF -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j$(nproc) && make install

# ------------------------------------------------------------------------------
# 4. INJECT PROJECT SOURCE
# ------------------------------------------------------------------------------
WORKDIR /app
COPY . /app

# [CRITICAL] 核弹级清理：删除宿主机带来的所有二进制残留
RUN find . -name "*.o" -delete && \
    find . -name "*.so" -delete && \
    find . -name "*.a" -delete && \
    rm -rf rai/lib/* rai/src/*/OBJS

# ------------------------------------------------------------------------------
# 5. [MANUAL FIX] PHYSX SETUP
# ------------------------------------------------------------------------------
WORKDIR /app/rai/build
RUN mkdir -p /root/.local/lib && \
    chmod +x ../_make/install.sh && \
    ../_make/install.sh physx && \
    ln -sf /root/.local/bin/linux.clang/release /root/.local/lib/PhysX

# ------------------------------------------------------------------------------
# 6. ENVIRONMENT VARIABLES
# ------------------------------------------------------------------------------
ENV HOME=/root
ENV LD_LIBRARY_PATH="/root/.local/lib/PhysX:/usr/local/lib:${LD_LIBRARY_PATH}"
ENV LIBRARY_PATH="/root/.local/lib/PhysX:/usr/local/lib:${LIBRARY_PATH}"
ENV CPATH="/root/git/physx/physx/include:/root/git/physx/pxshared/include:/usr/local/include:/usr/include/opencv4:/usr/include/eigen3:${CPATH}"

# ------------------------------------------------------------------------------
# 7. BUILD CONFIGURATION
# ------------------------------------------------------------------------------
WORKDIR /app/rai/_make
RUN echo "PHYSX = 1" > config.mk && \
    echo "CXXFLAGS += -DRAI_PHYSX" >> config.mk && \
    echo "GL = 1" >> config.mk && \
    echo "PYTHON = 1" >> config.mk && \
    echo "RAI_PyBind = 1" >> config.mk && \
    echo "ROS = 0" >> config.mk && \
    echo "OPENCV = 1" >> config.mk && \
    echo "PCL = 1" >> config.mk && \
    echo "FCL = 1" >> config.mk && \
    echo "BULLET = 0" >> config.mk && \
    echo "CERES = 0" >> config.mk && \
    echo "NLOPT = 1" >> config.mk && \
    echo "IPOPT = 1" >> config.mk && \
    echo "LGPL = 0" >> config.mk

RUN sed -i 's/-lANN/-lann/g' defines.mk

# ------------------------------------------------------------------------------
# 8. COMPILATION PIPELINE
# ------------------------------------------------------------------------------
WORKDIR /app/rai

# A. 编译核心库
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

# B. 编译 Binaries
RUN make bin -j$(nproc)

# ------------------------------------------------------------------------------
# 9. PYTHON WRAPPERS & RUNTIME
# ------------------------------------------------------------------------------
WORKDIR /app/rai/lib

RUN echo "import sys, os\nsys.path.append(os.path.dirname(__file__))\nfrom _robotic import *\nimport _robotic" > ry.py && \
    echo "from ry import *\nimport ry" > robotic.py

WORKDIR /app
ENV PYTHONPATH="/app/rai/lib:/app/rai/src/ry:${PYTHONPATH}"

# 验证安装
RUN python3 -c "import robotic; print('\n>>> BUILD SUCCESS: V-LGP Environment Ready. <<<')"

CMD ["/bin/bash"]
