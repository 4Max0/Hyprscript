#! /bin/bash

###########################################################################################################################################
# Variables
###########################################################################################################################################
# init log things
LOGFILE="logfile.log"

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
    echo -e "$TIME\t$1" >> $LOGFILE
    echo -e "$TIME\t$1"
}

###########################################################################################################################################
# Install packages
###########################################################################################################################################
# Install packages from pacman

write_log "installing packages of of pacman"
sudo pacman -Syu $PACKAGES $CUSTOM_PACKAGES --noconfirm

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
sudo cp config-files/sddm/sddm.conf /etc/sddm.conf
sudo cp config-files/sddm-sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
sudo cp custom_packages/wallpaper.jpg /usr/share/sddm/themes/sugar-candy/Backgrounds/

# Waybar configs
write_log "copying Waybar config files into directories"
cp config-files/waybar/* ~/.config/waybar/

# Hyprland and extra configs
write_log "copying Hyprland config files into directories"
cp config-files/hypr/* ~/.config/hypr/

# Move the Desktop Wallpaper
write_log "Copying the wallpaper into the directory"
cp custom-settings/wallpaper.jpg ~/Pictures/wallpapers/wallpaper.jpg

# Finished setup
write_log "Finished setup"
