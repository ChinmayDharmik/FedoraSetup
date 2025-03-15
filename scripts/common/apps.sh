#!/bin/bash

sudo rpm --import https://rpm.packages.shiftkey.dev/gpg.key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg

sudo dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/dev/x86_64/sublime-text.repo


# Install system utilities and applications via dnf
rpmapps=(
    github-desktop
    vlc
    kitty
    bpytop
    nodejs
    npm
    fastfetch
    htop
    bpytop
    speedtest-cli
    neofetch
    kitty
    sublime-text
    code
    okular
    multitail
    tree
    trash-cli
    fzf
    bash-completion
)

for app in "${rpmapps[@]}";do
    sudo dnf install "$app" -y
done
# Install various applications via Flatpak (Flathub repository)
flatpak_apps=(
    com.slack.Slack
    md.obsidian.Obsidian
    com.spotify.Client
    com.discordapp.Discord
    org.qbittorrent.qBittorrent
    com.brave.Browser
    org.zotero.Zotero
    com.toolstack.Folio
    us.zoom.Zoom
    dev.zed.Zed
    org.libreoffice.LibreOffice
)

for app in "${flatpak_apps[@]}"; do
    sudo flatpak install flathub "$app" -y
done

curl -sS https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -o google-chrome.rpm
sudo dnf install google-chrome.rpm -y
rm google-chrome.rpm

curl -sS https://releases.warp.dev/stable/v0.2024.02.27.08.01.stable_03/warp-terminal-v0.2024.02.27.08.01.stable_03-1.x86_64.rpm -o warp.rpm
sudo dnf install warp.rpm -y
rm warp.rpm

