#!/bin/bash

source ~/.config/hypr/scripts/audio-helper.sh

hdmi_status=$(cat /sys/class/drm/card*-HDMI-A-1/status 2>/dev/null | head -n1)
if [ "$hdmi_status" != "connected" ]; then
    notify-send -u critical "TV mode" "HDMI not connected — refusing to disable DP-1."
    exit 1
fi

hyprctl reload
hyprctl keyword monitor "DP-1, disable"
hyprctl keyword monitor "HDMI-A-1, 3840x2160@60, 0x0, 1"

# Pin Steam + games to ws5 so Big Picture and games share one workspace
hyprctl keyword windowrule "workspace 5 silent, class:^(steam)$"
hyprctl keyword windowrule "workspace 5 silent, class:^(steam_app_.*|cs2|Hollow Knight Silksong)$"

# Move any already-running Steam / game windows over (windowrules only fire on creation)
hyprctl dispatch movetoworkspacesilent "5,class:^(steam)$"
hyprctl dispatch movetoworkspacesilent "5,class:^(steam_app_.*|cs2|Hollow Knight Silksong)$"

# Gaming tweaks
hyprctl keyword animations:enabled false
hyprctl keyword decoration:blur:enabled false
hyprctl keyword general:allow_tearing true

set_audio_to "SONY TV"

hyprctl dispatch workspace 5
steam steam://open/bigpicture &
