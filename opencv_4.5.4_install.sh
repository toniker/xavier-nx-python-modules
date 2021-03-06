#!/bin/bash
set -e

echo "Installing OpenCV 4.5.4 on your Jetson Xavier NX"
echo "It will take 2.5 hours !"

# reveal the CUDA location
cd ~
sudo sh -c "echo '/usr/local/cuda/lib64' >> /etc/ld.so.conf.d/nvidia-tegra.conf"
sudo ldconfig

# install the dependencies
sudo apt-get install -y build-essential cmake git unzip pkg-config zlib1g-dev \
libjpeg-dev libjpeg8-dev libjpeg-turbo8-dev libpng-dev libtiff-dev \
libavcodec-dev libavformat-dev libswscale-dev libglew-dev \
libgtk2.0-dev libgtk-3-dev libcanberra-gtk* \
python-dev python-numpy python-pip \
python3-dev python3-numpy python3-pip \
libxvidcore-dev libx264-dev libgtk-3-dev \
libtbb2 libtbb-dev libdc1394-22-dev libxine2-dev \
gstreamer1.0-tools libv4l-dev v4l-utils v4l2ucp  qv4l2 \
libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev \
libavresample-dev libvorbis-dev libxine2-dev libtesseract-dev \
libfaac-dev libmp3lame-dev libtheora-dev libpostproc-dev \
libopencore-amrnb-dev libopencore-amrwb-dev \
libopenblas-dev libatlas-base-dev libblas-dev \
liblapack-dev liblapacke-dev libeigen3-dev gfortran \
libhdf5-dev protobuf-compiler \
gcc-7 \
libprotobuf-dev libgoogle-glog-dev libgflags-dev

# download the latest version
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.5.4.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.5.4.zip
# unpack
unzip opencv.zip
unzip opencv_contrib.zip
# some administration to make live easier later on
mv opencv-4.5.4 opencv
mv opencv_contrib-4.5.4 opencv_contrib
# clean up the zip files
rm opencv.zip
rm opencv_contrib.zip

# set install dir
cd ./opencv
mkdir build
cd build

# run cmake
cmake \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_C_COMPILER=/usr/bin/gcc-7 \
-D CMAKE_CXX_COMPILER=/usr/bin/g++-7 \
-D CMAKE_INSTALL_PREFIX=/usr \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
-D WITH_OPENCL=OFF \
-D WITH_CUDA=ON \
-D CUDA_ARCH_BIN=7.2 \
-D CUDA_ARCH_PTX="" \
-D WITH_CUDNN=ON \
-D WITH_CUBLAS=ON \
-D ENABLE_FAST_MATH=ON \
-D CUDA_FAST_MATH=ON \
-D OPENCV_DNN_CUDA=ON \
-D ENABLE_NEON=ON \
-D WITH_QT=OFF \
-D WITH_OPENMP=ON \
-D WITH_OPENGL=ON \
-D BUILD_TIFF=ON \
-D WITH_FFMPEG=ON \
-D WITH_GSTREAMER=ON \
-D WITH_TBB=ON \
-D BUILD_TBB=ON \
-D BUILD_TESTS=OFF \
-D WITH_EIGEN=ON \
-D WITH_V4L=ON \
-D WITH_LIBV4L=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D BUILD_NEW_PYTHON_SUPPORT=ON \
-D BUILD_opencv_python3=TRUE \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D BUILD_EXAMPLES=OFF \
-D BUILD_opencv_sfm=OFF ..

make -j1

sudo rm -r /usr/include/opencv4/opencv2
sudo make install
sudo ldconfig

# cleaning (frees 300 MB)
make clean
