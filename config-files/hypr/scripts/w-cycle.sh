#!/usr/bin/env bash

DIR="$HOME/Pictures/wallpapers"
read -r CURRENT < "$HOME/.config/hypr/scripts/current.conf"

# Extract current if it existent
if [[ "$CURRENT" =~ ^[0-9]+$ ]]; then
    CURRENT=$((CURRENT + 1))
else
    CURRENT=0
fi

# Array for allowed images
image_files=()
while IFS= read -r -d '' file; do
    image_files+=("$file")
done < <(find "$DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.jxl" -o -iname "*.webp" \) -print0)

# Lenght of wallpapers
image_count=${#image_files[@]}

if [ "$image_count" -lt 1 ]; then
    exit
fi

# Check if current has a valid size
if [ "$CURRENT" -ge "$image_count" ]; then
    CURRENT=0
fi

# Get size
current_image="${image_files[$CURRENT]}"

# laod wallpaper
# Load the new wallpaper into hyprpaper
# hyprctl hyprpaper reload ", $current_image"
# Load the new wallpaper into swww
swww img "$current_image" --transition-type center --transition-duration 1

#
# If you want to use Hyprpaper (wallpapers with not transitions uncomment the code below and comment out the line above mentioning swww) 
#
## Also update the hyprpaper.conf so it starts with current on the next restart
#cat <<-EOF > "$HOME/.config/hypr/hyprpaper.conf"
#preload = $current_image
#wallpaper = , $current_image
#EOF

# write the new wallpaper into hyprlock
cat <<-EOF > "$HOME/.config/hypr/hyprlock-background.conf"
background {
    monitor =
    path = $current_image
    color = rgba(25, 20, 20, 1.0)
    blur_passes = 2
    blur_size = 1
}
EOF

wal -i "$current_image" --no-apply tmux

# Update current
echo "$CURRENT" > "$HOME/.config/hypr/scripts/current.conf"
