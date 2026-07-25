#!/usr/bin/env sh
# Reload Hyprland when a git operation rewrote anything under hypr/.
#
# Git writes files via temp-file + rename, which swaps the inode. That kills
# Hyprland's config watcher: it fires once on the half-written file, applies an
# empty config, and then never sees the final version. Symptoms are every option
# silently falling back to defaults (dead keybinds, 1px stock borders) while
# `hyprctl configerrors` stays clean.

changed="$1" # newline-separated paths, may be empty

[ -n "$changed" ] || exit 0
printf '%s\n' "$changed" | grep -q '^hypr/' || exit 0

command -v hyprctl >/dev/null 2>&1 || exit 0

# Only act when a compositor is actually up; skip SSH, TTY and CI checkouts.
instance="${HYPRLAND_INSTANCE_SIGNATURE:-}"
if [ -z "$instance" ]; then
    instance=$(hyprctl instances -j 2>/dev/null |
        sed -n 's/.*"instance": *"\([^"]*\)".*/\1/p' | head -1)
    [ -n "$instance" ] || exit 0
    export HYPRLAND_INSTANCE_SIGNATURE="$instance"
fi

if hyprctl reload >/dev/null 2>&1; then
    echo "dotfiles: hypr/ changed -> hyprctl reload"
else
    echo "dotfiles: hypr/ changed, but hyprctl reload failed - run it manually" >&2
fi

exit 0
