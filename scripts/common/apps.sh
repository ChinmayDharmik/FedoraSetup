#!/bin/bash

curl -sS https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm -o google-chrome.rpm
sudo dnf install google-chrome.rpm -y
rm google-chrome.rpm

curl -sS https://releases.warp.dev/stable/v0.2024.02.27.08.01.stable_03/warp-terminal-v0.2024.02.27.08.01.stable_03-1.x86_64.rpm -o warp.rpm
sudo dnf install warp.rpm -y
rm warp.rpm

# Install system utilities and applications via dnf
rpmapps=(
    vlc
    kitty
    bpytop
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
)

for app in "${flatpak_apps[@]}"; do
    sudo flatpak install flathub "$app" -y
done
