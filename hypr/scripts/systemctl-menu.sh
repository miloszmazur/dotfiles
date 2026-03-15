#!/bin/bash

echo -e "poweroff\nreboot\nsuspend" | walker --dmenu --minheight 1 | while read -r choice; do
    [ -n "$choice" ] && systemctl "$choice"
done
