#!/bin/bash

source ~/.config/hypr/scripts/audio-helper.sh

hyprctl reload
hyprctl keyword monitor "DP-1, 3440x1440@120, 0x0, 1"
hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1, mirror, DP-1"

set_audio_to "SONY TV"
