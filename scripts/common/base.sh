#! /bin/bash

echo "Installing Essentials for Fedora"

echo "Enabling RPMFusion and Flathub"
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y
sudo dnf install rpmfusion-free-release-tainted -y
sudo dnf install dnf-plugins-core -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Enabling dnf-automatic(Automatic updates)"
sudo dnf install dnf-automatic -y
sudo cp dotfiles/dnf/automatic.conf /etc/dnf/automatic.conf
sudo systemctl enable --now dnf-automatic.timer



# First, optimize the dnf package manager
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp dotfiles/dnf/dnf.conf /etc/dnf/dnf.conf

# System update and cleanup
sudo dnf upgrade --refresh -y && sudo dnf autoremove -y

# Firmware updates
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update -y

# Enable RPM Fusion repositories
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y

# Add Flathub repository for Flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install various utilities and system enhancements
sudo dnf install -y axel deltarpm unzip fastfetch fedora-workstation-repositories \
    @virtualization dialog rpmfusion-free-release-tainted dnf-automatic dnf-plugins-core wget curl git

# Configure automatic updates
sudo cp dotfiles/dnf/automatic.conf /etc/dnf/automatic.conf
sudo systemctl enable --now dnf-automatic.timer

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /home/kyrotron/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

mkdir "$HOME"/.config/kitty/
# Copy all of my config files to the config folder
cp -r dotfiles/kitty/ ~/.config/kitty

echo "Go to ~/.config/kitty/ to edit Kitty's config files"

echo "Installing Starship and its dependencies"
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config && touch ~/.config/starship.toml

echo 'eval "$(starship init bash)"'>> ~/.bashrc
echo 'export TERM=xterm-256color'>> ~/.bashrc
cp dotfiles/starship.toml ~/.config/starship.toml