#! /bin/bash

echo "Installing Nvidia Drivers"
sudo dnf install kmodtool akmods mokutil openssl -y
sudo kmodgenca -a

sudo mokutil --import /etc/pki/akmods/certs/public_key.der

sudo dnf install gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs

sudo akmods --force
sudo dracut --force

sudo dnf config-manager add-repo --from-repofile=https://developer.download.nvidia.com/compute/cuda/repos/fedora39/x86_64/cuda-fedora39.repo
sudo dnf clean all -y
sudo dnf module disable nvidia-driver
sudo dnf -y install cuda

sudo dnf install https://developer.download.nvidia.com/compute/machine-learning/repos/rhel8/x86_64/nvidia-machine-learning-repo-rhel8-1.0.0-1.x86_64.rpm
sudo dnf install libcudnn7 libcudnn7-devel libnccl libnccl-devel -y
