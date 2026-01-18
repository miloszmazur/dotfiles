#!/bin/bash

echo -e "poweroff\nreboot\nsuspend\nhibernate" | walker --dmenu --minheight 1 | while read -r choice; do
    [ -n "$choice" ] && systemctl "$choice"
done
