#! /bin/bash

###########################################################################################################################################
# Install packages
###########################################################################################################################################

# Install packages from pacman
packages=$(cat config-files/packages/packages.conf)
custom_packages=$(cat custom-settings/custom_packages.conf)

sudo pacman -Syu $packages $custom_packages --noconfirm

# Install yay
yay_packages=$(cat config-files/packages/yay_packages.conf)
yay_custom_packages=$(cat custom-settings/yay_custom_packages.conf)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# install packages from yay
yay -Syu $yay_packages $custom_yay_packages

###########################################################################################################################################
# Enable systems
###########################################################################################################################################

# enable sddm
sudo systemctl enable sddm.service

###########################################################################################################################################
# Moving configs
###########################################################################################################################################

# sddm configs
sudo cp config-files/sddm/sddm.conf /etc/sddm.conf
sudo cp config-files/sddm-sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
sudo cp custom_packages/wallpaper.jpg /usr/share/sddm/themes/sugar-candy/Backgrounds/

# Waybar and hyprland
cp config-files/waybar/* ~/.config/waybar/
cp config-files/hypr/* ~/.config/hypr/