#! /bin/bash

echo "Installing Nvidia Drivers"
sudo dnf config-manager --set-enabled "rpmfusion-nonfree-nvidia-driver"
sudo dnf makecache
sudo dnf install kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-cuda-libs
# sudo kmodgenca -a

# sudo mokutil --import /etc/pki/akmods/certs/public_key.der

# sudo dnf install gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs -y

# sudo akmods --force
# sudo dracut --force

# sudo dnf -y install nvidia-open
# sudo dnf -y install cuda-drivers

# sudo dnf module disable nvidia-driver
# sudo dnf config-manager addrepo --from-repofile https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/cuda-fedora41.repo
# sudo dnf clean all
# sudo dnf -y install cuda-toolkit-12-8
# sudo dnf -y install cuda

# # sudo dnf install https://developer.download.nvidia.com/compute/machine-learning/repos/rhel8/x86_64/nvidia-machine-learning-repo-rhel8-1.0.0-1.x86_64.rpm -y
# # sudo dnf install libcudnn7 libcudnn7-devel libnccl libnccl-devel -y
