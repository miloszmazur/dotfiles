#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

cd "$WALLPAPER_DIR" || exit

selected=$(
    find . -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | sed 's|^\./||' \
    | while read -r file; do
        echo -en "$file\0icon\x1f$WALLPAPER_DIR/$file\n"
    done | rofi -dmenu -show-icons -icon-size 4 -placeholder "Wallpaper"
)

[[ -z "$selected" ]] && exit 0

WALLPAPER="$WALLPAPER_DIR/$selected"
awww img "$WALLPAPER" --transition-type wipe --transition-fps 120 --resize=fit
wallust run "$WALLPAPER"
cat ~/.cache/wallust/sequences 2>/dev/null
