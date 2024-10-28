#!/bin/bash

#AutoCpufreq | powerprofile

### installing 

printf "%b\n" "Installing auto-cpufreq..."
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq
sudo ./auto-cpufreq-installer
sudo  auto-cpufreq --install
cd ..
rm -rf auto-cpufreq
printf "%b\n" "done"

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

