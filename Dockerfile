FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential cmake python3 git \
    ninja-build perl pkg-config wget xz-utils \
    libx11-dev libx11-xcb-dev libxcb1-dev libxcb-keysyms1-dev \
    libxcb-render0-dev libxcb-shape0-dev libxcb-shm0-dev \
    libxcb-icccm4-dev libxcb-image0-dev libxcb-xfixes0-dev \
    libxcb-sync-dev libxcb-xinerama0-dev libxcb-randr0-dev \
    libxcb-util-dev libxcb-cursor-dev \
    libxkbcommon-dev libxkbcommon-x11-dev \
    libgl1-mesa-dev \
    libfontconfig1-dev libfreetype6-dev \
    libinput-dev \
    libxext-dev libxrender-dev libxdamage-dev libxcomposite-dev \
    libdrm-dev \
    libegl1-mesa-dev \
    libwayland-dev wayland-protocols \
    libvulkan-dev vulkan-tools \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /Qt-src

RUN wget https://download.qt.io/archive/qt/6.6/6.6.0/single/qt-everywhere-src-6.6.0.tar.xz && \
    tar xf qt-everywhere-src-6.6.0.tar.xz

WORKDIR /Qt-src/qt-everywhere-src-6.6.0

RUN ./configure \
    -prefix /opt/Qt/6.6.0 \
    -release \
    -opensource -confirm-license \
    -nomake examples \
    -nomake tests \
    -skip qt3d \
    -skip qtpim \
    -skip qtwebengine \
    -feature-opengl \
    -cmake-generator "Ninja" \
    -DFEATURE_qt_quick3d=ON \
    -DFEATURE_shadertools=ON && \
    cmake --build . --parallel && \
    ninja install

ENV PATH="/opt/Qt/6.6.0/bin:${PATH}"

WORKDIR /

