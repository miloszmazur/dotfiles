WALLPAPER="$(find ~/Pictures/wallpapers -type f | shuf -n 1)"
swww img "${WALLPAPER}" --transition-type wipe --transition-fps 120
wallust run "${WALLPAPER}"

cat ~/.cache/wallust/sequences 2>/dev/null
