#!/bin/bash

choice=$(printf "Desktop\nTV\nMirror" | walker --dmenu --minheight 1 --placeholder "Mode")

case "$choice" in
  Desktop) exec ~/.config/hypr/scripts/mode-desktop.sh ;;
  TV)      exec ~/.config/hypr/scripts/mode-tv.sh ;;
  Mirror)  exec ~/.config/hypr/scripts/mode-mirror.sh ;;
esac
