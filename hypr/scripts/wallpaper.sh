WALLPAPER="$(find ~/Pictures/wallpapers -type f -maxdepth 1  | shuf -n 1)"
swww img "${WALLPAPER}" --transition-type wipe --transition-fps 120 --resize=fit
wallust run "${WALLPAPER}"
# matugen image ${WALLPAPER}

cat ~/.cache/wallust/sequences 2>/dev/null
