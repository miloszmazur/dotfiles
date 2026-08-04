# Mode-picker rewrite: DPMS + workspace rebinding

## Context

The current `mode-tv.sh` / `mode-desktop.sh` flow has three problems:

1. **Workspace routing is broken.** Steam Big Picture lands on ws6, the game on ws5, because the static `steam-float` rule (hyprland.conf:336–341, `workspace = 6 silent`) wins over the dynamic `hyprctl keyword windowrule` added inside `mode-tv.sh`. The two rule systems (block-form named rules vs. inline `windowrule = ...`) don't reliably override each other.

2. **Switching back from TV mode is blind.** `mode-tv.sh` runs `monitor=DP-1, disable`, which fully removes DP-1 from Hyprland's monitor list. When the user walks back to the desk they see a black screen, have to unlock and invoke the mode-picker without visual feedback.

3. **Reload churn.** `hyprctl reload` plus monitor reconfig forces waybar bars and `awww-daemon` wallpaper surfaces to re-bootstrap on the affected outputs, often leaving the default Hyprland wallpaper on the TV until things settle.

The fix: don't disable monitors. Keep both monitors permanently registered with Hyprland and use **DPMS** to power them on/off. Routing of games / Big Picture between desk and TV becomes a matter of rebinding workspaces 5 and 6 to a different monitor, not reconfiguring outputs. DP-1 stays the default ("display first, TV later").

Bonus: solves the "lag in Big Picture" question via a separate Steam-side toggle (no config changes here) — see Out of scope.

## Changes

### 1. `hypr/hyprland.conf`

Add persistent workspace bindings near the existing workspace section (after the window rules, ~line 376):

```
# Workspace bindings — ws5/6 default to desk; mode-tv.sh rebinds them to HDMI-A-1
workspace = 5, monitor:DP-1, persistent:true
workspace = 6, monitor:DP-1, persistent:true
```

Add an `exec-once` near the other autostarts (~line 35) to keep the TV off at boot:

```
exec-once = sleep 1 && hyprctl dispatch dpms off HDMI-A-1
```

(The `sleep 1` is because exec-once fires before monitor probing is fully settled; without it the dpms call sometimes no-ops.)

Leave the existing static `windowrule` blocks alone — `steam-float` stays pinned to ws6, `steam-games-workspace` stays pinned to ws5. The mode scripts now only move the *workspaces*, not the windows.

### 2. `hypr/scripts/mode-desktop.sh` (rewrite)

```bash
#!/bin/bash
source ~/.config/hypr/scripts/audio-helper.sh

hyprctl dispatch dpms on DP-1
hyprctl dispatch dpms off HDMI-A-1

hyprctl keyword workspace "5, monitor:DP-1, persistent:true"
hyprctl keyword workspace "6, monitor:DP-1, persistent:true"
hyprctl dispatch moveworkspacetomonitor "5 DP-1"
hyprctl dispatch moveworkspacetomonitor "6 DP-1"

# Restore visual chrome (these were disabled by mode-tv.sh)
hyprctl keyword animations:enabled false
hyprctl keyword decoration:blur:enabled true
hyprctl keyword general:allow_tearing false

set_audio_to "Odyssey G85SB"

hyprctl dispatch focusmonitor DP-1
```

No `hyprctl reload`, no monitor reconfig.

### 3. `hypr/scripts/mode-tv.sh` (rewrite)

```bash
#!/bin/bash
source ~/.config/hypr/scripts/audio-helper.sh

hdmi_status=$(cat /sys/class/drm/card*-HDMI-A-1/status 2>/dev/null | head -n1)
if [ "$hdmi_status" != "connected" ]; then
    notify-send -u critical "TV mode" "HDMI not connected."
    exit 1
fi

hyprctl dispatch dpms on HDMI-A-1
hyprctl dispatch dpms off DP-1

hyprctl keyword workspace "5, monitor:HDMI-A-1, persistent:true"
hyprctl keyword workspace "6, monitor:HDMI-A-1, persistent:true"
hyprctl dispatch moveworkspacetomonitor "5 HDMI-A-1"
hyprctl dispatch moveworkspacetomonitor "6 HDMI-A-1"

# Gaming tweaks
hyprctl keyword animations:enabled false
hyprctl keyword decoration:blur:enabled false
hyprctl keyword general:allow_tearing true

set_audio_to "SONY TV"

hyprctl dispatch focusmonitor HDMI-A-1
hyprctl dispatch workspace 5

# Launch Big Picture if Steam isn't already in BP mode
steam steam://open/bigpicture &
```

Gone: `hyprctl reload`, the dynamic `windowrule` lines, the `movetoworkspacesilent` dispatches. Because windowrules still pin `class:steam` → ws6 and games → ws5, and *both those workspaces now live on HDMI-A-1*, Big Picture and games end up on the TV automatically.

### 4. `hypr/scripts/mode-mirror.sh` (small update)

Drop `hyprctl reload`. Keep the mirror monitor reconfig (mirror genuinely needs a monitor mode change, not just DPMS):

```bash
#!/bin/bash
source ~/.config/hypr/scripts/audio-helper.sh

hyprctl dispatch dpms on DP-1
hyprctl dispatch dpms on HDMI-A-1
hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1, mirror, DP-1"

set_audio_to "SONY TV"
```

(Leaves workspace bindings alone — mirror is a "both screens show desk" mode.)

## Critical files

- `hypr/hyprland.conf` — workspace bindings + exec-once DPMS
- `hypr/scripts/mode-desktop.sh` — full rewrite
- `hypr/scripts/mode-tv.sh` — full rewrite
- `hypr/scripts/mode-mirror.sh` — drop reload

Untouched: `mode-picker.sh`, `audio-helper.sh`, `hypridle.conf`, `hyprlock.conf`.

## Verification

After applying the changes, reload Hyprland once via the existing `Super+Shift+R` binding (which runs `scripts/reload.sh`).

1. **Boot state.** Confirm HDMI-A-1 is DPMS-off: `hyprctl monitors all | grep -A1 HDMI`. Should show `dpmsStatus: false`. Desk display normal.

2. **Desktop gaming (the common path).** Launch Steam, open library, launch any game. Library window should appear on DP-1 ws6 (existing rule, floating). Game should appear on DP-1 ws5 (existing rule). TV stays dark. ✅ if no behavior change from today.

3. **TV mode entry.** From the desk, `Super+Ctrl+G` → pick "TV":
   - DP-1 goes dark, HDMI-A-1 wakes.
   - Audio switches to SONY TV (`pactl get-default-sink` to verify).
   - Steam library window appears on the TV (it migrated with ws6).
   - Launch a game — appears on the TV (ws5 lives there now).
   - `hyprctl monitors all` should show DP-1 dpms false / HDMI true.
   - Crucially: waybar bar on HDMI-A-1 visible, wallpaper from awww-daemon present (no Hyprland default fallback).

4. **The blind-switch fix.** With TV mode active, walk back to the desk and press any key on the desk keyboard. DP-1 should *not* wake automatically (Hyprland's DPMS is manual; hypridle has no `on-resume` DPMS handler). Confirm with the user that this matches expectations — if they'd rather have keyboard activity wake DP-1, we'd add an `on-resume` to hypridle.conf as a follow-up.

   To switch back: at the desk, `Super+Ctrl+G` blind (one key chord), then arrow + return to pick "Desktop". Once the script runs, DP-1 wakes and you see the lock screen / desktop.

5. **No reload side-effects.** Compare `pgrep -fa waybar` and `pgrep -fa awww-daemon` PIDs before and after a TV → Desktop → TV cycle. PIDs should be unchanged (we never killed them).

6. **Gamepad sanity check.** Once on the TV with a controller, leave the desk keyboard untouched for a few minutes while pressing gamepad buttons. DP-1 should stay dark. (This validates the assumption that gamepad input doesn't trip any wake path.)

## Out of scope (separate Steam-side toggle)

For the "Big Picture is laggy" complaint: in Steam → Settings → Interface, toggle **Enable GPU accelerated rendering of web views** off, and also **Smooth scrolling in web views** off. On NVIDIA + Wayland these two are the typical culprits since Big Picture's UI is CEF/Chromium. No dotfiles change needed — try this first before reaching for `gamescope`.

## Rollback

Everything is in two files (`hyprland.conf`) and three scripts. `git checkout hypr/hyprland.conf hypr/scripts/mode-*.sh` reverts the lot.
