#! /bin/bash
###########################################################################################################################################
# Init logger
###########################################################################################################################################
# logfile path
LOGFILE="logfile.log"

exec > >(tee -a $LOGFILE) 2>&1
set -x

###########################################################################################################################################
# Variables
###########################################################################################################################################
# Pacamn Packages
PACKAGES=$(cat config-files/packages/packages.conf)
CUSTOM_PACKAGES=$(cat custom-settings/custom_packages.conf)

# Yay Packages
YAY_PACKAGES=$(cat config-files/packages/yay_packages.conf)
YAY_CUSTOM_PACKAGES=$(cat custom-settings/yay_custom_packages.conf)

###########################################################################################################################################
# Functions
###########################################################################################################################################
update_timestamp() {
    TIME='['$(date '+%Y-%m-%d %H:%M:%S')']'
}

write_log() {
    update_timestamp
    echo -e "$TIME\t$1"
}

###########################################################################################################################################
# Install packages
###########################################################################################################################################
# Install packages from pacman
write_log "installing packages of of pacman"
sudo pacman -Syu $PACKAGES $CUSTOM_PACKAGES

write_log "checking for yay"
# Install yay if not already
if ! command -v yay &> /dev/null; then
    write_log "installing yay"
    git clone https://aur.archlinux.org/yay.git
    (cd yay && makepkg -si)
    rm -rf yay
else
    write_log "yay is already installed"
fi

# install packages from yay
write_log "installing packages of of yay"
yay -Syu $YAY_PACKAGES $YAY_CUSTOM_PACKAGES

###########################################################################################################################################
# Enable systems
###########################################################################################################################################
# enable sddm
write_log "enabling sddm"
sudo systemctl enable sddm.service

###########################################################################################################################################
# Moving configs
###########################################################################################################################################
# sddm configs
write_log "copying sddm config files into directories"
sudo cp -p config-files/sddm/sddm.conf /etc/sddm.conf
sudo cp -p config-files/sddm-sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
sudo cp -p custom-settings/wallpaper.png /usr/share/sddm/themes/sugar-candy/Backgrounds/

# Waybar configs
write_log "copying Waybar config files into directories"
sudo cp -rf config-files/waybar/ ~/.config/waybar/

# Hyprland and extra configs
write_log "copying Hyprland config files into directories"
sudo cp -rf config-files/hypr/ ~/.config/

# Hyprshot screenshot directory
write_log "create Hyprshot Screenshot Directory"
sudo mkdir -p ~/Pictures/Screenshots
sudo chown $USER:$USER ~/Pictures/Screenshots

# Move the Desktop Wallpaper
write_log "Copying the wallpaper into the directory"
sudo mkdir -p ~/Pictures/wallpapers
sudo cp custom-settings/wallpaper.png ~/Pictures/wallpapers/wallpaper.png

# qt6ct config files
write_log "Copying the qt6ct config files"
sudo cp -rf config-files/qt6ct ~/.config

# GTK config files
write_log "Copying the GTK config files"
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# Finished setup
write_log "Finished setup"
write_log "Restart the system for the changes to take full effect"
