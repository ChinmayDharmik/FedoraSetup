#! /bin/bash

HEIGHT=25
WIDTH=100
CHOICE_HEIGHT=4
BACKTITLE="Fedora post-install-fedora script"
MENU_MSG="Please select one of following options:"

#first lets optimise the dnf package manager
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp dotfiles/dnf/dnf.conf /etc/dnf/dnf.conf

#check for updates
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y
sudo dnf autoremove -y

sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update -y



# lets install some essentials 
rpm_apps=(
    git
    nano
    fastfetch
    htop
    bpytop
    speedtest-cli
    axel
    deltarpm
    unzip
    dialog
    wget
    curl
    dnf-plugin-core
    dnf-plugins-core
    gnome-extension-app
    gnome-tweaks
    gnome-shell-extension-appindicator
    rpmfusion-free-release-tainted
    nodejs
    npm
    fedora-workstation-repositories
    @virtualization
    dnf-automatic
    neofetch
    kitty
)

for app in "${rpmapps[@]}";do
    sudo dnf install "$app" -y
done 

echo "Enabling dnf-automatic(Automatic updates)"
sudo cp dotfiles/dnf/automatic.conf /etc/dnf/automatic.conf
sudo systemctl enable --now dnf-automatic.timer

## Media Codecs
echo "Installing media codecs"
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav libavcodec-freeworld --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y

OPTIONS=(
    1  "Run First-Boot tweaks"
    2  "Optimize BootTime"
    3  "Install Dev tools"
    4  "Install flutter"
    5  "Install Nvidia drivers"
    0  "Post Installing Nvidia Drivers"
    6  "Install Update-GRUB"
    7  "Install Prefered apps"
    8  "Run All"
    9 "Reboot"
    10 "Quit"
)

while true; do
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE - Main menu $(lscpu | grep -i "Model name:" | cut -d':' -f2- - )" \
                --title "$TITLE" \
                --nocancel \
                --menu "$MENU_MSG" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
    clear
    case $CHOICE in 
        0)
            scripts/postNvidiaGPU.sh
        ;;
        1) 
            scripts/base.sh
        ;;
       
        2) 
            scripts/optimizeBootTime.sh
        ;;
        
        3) 
            scripts/installDevTools.sh
        ;;


        4) 
            scripts/flutter.sh
        ;;

        5)
            scripts/nvidiaGpu.sh
        ;;

        6)
            scripts/update_grub.sh
        ;;
        7)
            scripts/autoInstallMyApps.sh
        ;;
        8)
            scripts/base.sh
            scripts/optimizeBootTime.sh
            scripts/installDevTools.sh
            scripts/flutter.sh
            #scripts/nvidiaGpu.sh
            scripts/update_grub.sh
            scripts/autoInstallMyApps.sh
        ;;
        9)
            sudo systemctl reboot
        ;;

        10) 
            # Undo any changes made to this repository to clean up
            exit 0
        ;;

    esac
done