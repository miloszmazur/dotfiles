#!/bin/bash
# Sourceable helper for switching the default audio sink between HDMI outputs.

CARD="alsa_card.pci-0000_01_00.1"

find_profile_for() {
  pactl list cards | awk -v target="$1" '
    $0 ~ target { found=1 }
    found && /Part of profile/ {
      if (match($0, /output:hdmi-stereo[^ ,)]*/)) {
        print substr($0, RSTART, RLENGTH)
      }
      exit
    }
  '
}

set_audio_to() {
  local profile
  profile=$(find_profile_for "$1")
  if [ -n "$profile" ]; then
    pactl set-card-profile "$CARD" "$profile"
    pactl set-default-sink "alsa_output.pci-0000_01_00.1.${profile#output:}"
  fi
}
