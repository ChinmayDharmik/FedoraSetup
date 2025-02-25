#!/bin/bash

## Miniconda
curl -sS https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o miniconda.sh
bash ./miniconda.sh 
rm miniconda.sh

## VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install -y code

# GitHub Desktop
sudo flatpak install flathub io.github.shiftey.Desktop

#docker
sudo dnf install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker && sudo gpasswd -a ${USER} docker && sudo systemctl restart docker
newgrp docker

#ollama client
curl -fsSL https://ollama.com/install.sh | sh
sudo systemctl enable --now ollama  

#futter
git clone https://github.com/flutter/flutter.git -b stable ~/flutter
~/flutter/bin/flutter precache
~/flutter/bin/flutter doctor

