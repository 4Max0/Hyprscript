#!/usr/bin/env bash
###########################################################################################################################################
# Init logger
###########################################################################################################################################
# logfile path
LOGFILE="logfile.log"

exec > >(tee -a $LOGFILE) 2>&1          # Logfile writer
set -x                                  # Debug mode
set -e                                  # end on error

trap 'Error on line $LINENO' ERR
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
# Pacamn Packages
PACKAGES=$(cat config-files/packages/packages.conf)
CUSTOM_PACKAGES=$(cat custom-settings/custom_packages.conf)

# Yay Packages
YAY_PACKAGES=$(cat config-files/packages/yay_packages.conf)
YAY_CUSTOM_PACKAGES=$(cat custom-settings/yay_custom_packages.conf)

# Install packages from pacman
write_log "Installing packages of of pacman"
sudo pacman -Syu $PACKAGES $CUSTOM_PACKAGES

write_log "Checking for yay"
# Install yay if not already
if ! command -v yay &> /dev/null; then
    write_log "installing yay"
    git clone https://aur.archlinux.org/yay.git
    (cd yay && makepkg -si)
    rm -rf yay
else
    write_log "Yay is already installed"
fi

# install packages from yay
write_log "Installing packages of of yay"
yay -Syu $YAY_PACKAGES $YAY_CUSTOM_PACKAGES

###########################################################################################################################################
# Enable settings and Moving configs
###########################################################################################################################################
# enable sddm
DM=$(basename "$(readlink /etc/systemd/system/display-manager.service)")

write_log "Checking display mananger"
if [[ -n "$DM" && "$DM" != "sddm.service" ]]; then
    write_log "Found other Display Manager than sddm"
    write_log "Deactivating $DM"
    sudo systemctl disable "$DM"
    write_log "Deactivated $DM"
    write_log "Enabling sddm"
    sudo systemctl enable sddm.service
elif [[ ! -L /etc/systemd/system/display-manager.service ]]; then
    write_log "No display manager found"
    write_log "Enabling sddm"
    sudo systemctl enable sddm.service
elif [[ -n "$DM" && "$DM" == "sddm.service" ]]; then
    write_log "sddm already enabled"
fi

# Set GTK theme
write_log "Setting GTK Theme"
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

# Set the GHOSTTY theme
write_log "Checking if ghostty is installed"
if [ -d ~/.config/ghostty ]; then
    write_log "Ghostty is installed writing into the config"
    sudo echo "theme=VibrantInk" >> ~/.config/ghostty/config
fi

# Create .config if it doesn't exist
write_log "Check if .config exists"
if [[ ! -d ~/.config ]]; then
    write_log "Creating ~/.config"
    mkdir -p ~/.config
fi

# sddm configs
write_log "Copying sddm config files into directories"
sudo cp -p config-files/sddm/sddm.conf /etc/sddm.conf
sudo cp -p config-files/sddm-sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.conf
sudo cp -p custom-settings/wallpaper.png /usr/share/sddm/themes/sugar-candy/Backgrounds/

# Waybar configs
write_log "Copying Waybar config files into directories"
sudo cp -rf config-files/waybar/ ~/.config/

# Hyprland and extra configs
write_log "Copying Hyprland config files into directories"
sudo cp -rf config-files/hypr/ ~/.config/

# Change the Keyboard Layout to german via copying my special conf
# I know this is a kind of stupid way but it works
write_log "Checking for -de flag"
for arg in "$@"; do
    if [[ "$arg" == "-de" ]]; then
        sudo cp -p config-files/hypr-special/hyprland-de.conf ~/.config/hypr/hyprland.conf
    fi
done

# Hyprshot screenshot directory
write_log "Create Hyprshot Screenshot Directory"
if [[ ! -d "~/Pictures/Screenshots" ]]; then
    write_log "Creating ~/Pictures/Screenshots"
    sudo mkdir -p ~/Pictures/Screenshots
fi
write_log "Setting owner of ~/Pictures/Screenshots to the user"
sudo chown $USER:$USER ~/Pictures/Screenshots

# Move the Desktop Wallpaper
write_log "Checking if ~/Pictures/wallpapers exists"
if [[ ! -d ~/Pictures/wallpapers ]]; then
    write_log "Creating ~/Pictures/wallpapers"
    sudo mkdir -p ~/Pictures/wallpapers
fi
write_log "Copying the wallpaper into the directory"
sudo cp custom-settings/wallpaper.png ~/Pictures/wallpapers/wallpaper.png

# qt6ct config files
write_log "Copying the qt6ct config files"
sudo cp -rf config-files/qt6ct ~/.config

# Finished setup
write_log "Finished setup"
write_log "Restart the system for the changes to take full effect"
