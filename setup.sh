#! /bin/bash

HEIGHT=25
WIDTH=100
CHOICE_HEIGHT=4
BACKTITLE="Fedora post-install-fedora script"
MENU_MSG="Please select one of following options:"

#first lets optimise the dnf package manager
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak
sudo cp dotfiles/dnf/dnf.conf /etc/dnf/dnf.conf

CURRENT_DIR=$(pwd)

#check for updates
sudo dnf upgrade --refresh -y && sudo dnf autoremove -y
sudo dnf install -y flatpak git nano
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

mkdir -p "$HOME/.local/share"
cd "$HOME/.local/share"
if [ -d 'Top-5-Bootloader-Themes' ]; then
    rm -rf 'Top-5-Bootloader-Themes'
fi
git clone "https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes"
cd "Top-5-Bootloader-Themes"
"$ESCALATION_TOOL" ./install.sh
cd "$CURRENT_DIR"

echo "Optimizing boot time for your PC/laptop"
echo "Checking if your CPU is Intel's CPU or not"
if [ "$(< /proc/cpuinfo grep "GenuineIntel" | head -1 | cut -d "e" -f 4-)" == "Intel" ]; 
then 
    echo "Your CPU is Intel's CPU, let's optimize it"
    lscpu | grep -i "Model name"
    echo -e "\nGRUB_CMDLINE_LINUX_DEFAULT=\"intel_idle.max_cstate=1 cryptomgr.notests initcall_debug intel_iommu=igfx_off no_timer_check noreplace-smp page_alloc.shuffle=1 rcupdate.rcu_expedited=1 tsc=reliable quiet splash video=SVIDEO-1:d\"" | sudo tee -a /etc/default/grub 
    scripts/update_grub.sh
    sudo systemctl disable NetworkManager-wait-online.service 
else
    echo "Your CPU is not Intel's CPU, doing some basic optimization"
    sudo systemctl disable NetworkManager-wait-online.service 
fi

if [ -f "/sys/firmware/efi" ]; 
then
    sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg
else
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
fi

AUTO_CPUFREQ_PATH="$HOME/.local/share/auto-cpufreq"
if [ -d "$AUTO_CPUFREQ_PATH" ]; then
    rm -rf "$AUTO_CPUFREQ_PATH"
fi

git clone --depth=1 https://github.com/AdnanHodzic/auto-cpufreq.git "$AUTO_CPUFREQ_PATH"
sudo ./auto-cpufreq-installer
auto-cpufreq --install
sudo auto-cpufreq --force performance

cd "$CURRENT_DIR"


# lets install some essentials 
rpm_apps=(
    git
    nano
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
    fedora-workstation-repositories
    @virtualization
    dnf-automatic
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

sudo dnf install "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora)".noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm -y
sudo config-manager --enable fedora-cisco-openh264
sudo config-manager --set-enabled rpmfusion-nonfree-updates
sudo config-manager --set-enabled rpmfusion-free-updates
sudo dnf install gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y

OPTIONS=(
    0  "Run First-Boot tweaks"
    1  "Optimize BootTime"
    2  "Install Dev tools"
    3  "Install flutter"
    4  "Install Nvidia drivers"
    5  "Post Installing Nvidia Drivers"
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
            scripts/base.sh
        ;;
        1) 
            
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