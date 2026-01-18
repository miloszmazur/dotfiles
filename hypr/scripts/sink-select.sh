#!/bin/bash

current=$(pactl get-default-sink)

declare -A sinks=(
    ["alsa_output.usb-Generic_USB_Audio-00.HiFi__Headphones__sink"]="Headphones"
    ["alsa_output.pci-0000_01_00.1.hdmi-stereo"]="Speakers"
)

pactl list short sinks | awk '{print $2}' | while read -r sink; do
    # skip other sinks
    [[ ! -v sinks[$sink] ]] && continue
    
    display_name="${sinks[$sink]}"
    
    if [ "$sink" = "$current" ]; then
        echo "* $display_name|$sink"
    else
        echo "  $display_name|$sink"
    fi
done | cut -d'|' -f1 | walker --dmenu --minheight 1 --placeholder "Source" | sed 's/^[* ] //' | while read -r name; do
    for sink in "${!sinks[@]}"; do
        if [ "${sinks[$sink]}" = "$name" ]; then
            pactl set-default-sink "$sink"
            break
        fi
    done
done
