#!/bin/bash

sudo dnf group install "KDE Plasma Workspaces" -y
sudo dnf install sddm -y
sudo systemctl enable --force sddm.service
sudo systemctl set-default graphical.target

dnf install plasma-workspace-x11
