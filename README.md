# xavier-nx-modules

### Instructions to install OpenCV 4.5.4 with CUDA Acceleration and Jetson-inference on your Nvidia Jetson Xavier NX
#### Jetson Inference

[Source](https://github.com/dusty-nv/jetson-inference/blob/master/docs/building-repo-2.md)

```
mkdir repos; cd repos
sudo apt update
sudo apt install git cmake libpython3-dev python3-numpy
git clone --recursive https://github.com/dusty-nv/jetson-inference
cd jetson-inference
mkdir build; cd build
cmake ../
make -j$(nproc)
sudo make install
sudo ldconfig
```

#### OpenCV 4.5.4 CUDA Install

[Source with modifications](https://qengineering.eu/install-opencv-4.5-on-jetson-nano.html)

See `opencv_4.5.4_install.sh`
