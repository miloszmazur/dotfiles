--------------------
---- MONITORS ----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ output = "DP-1",     mode = "3440x1440@120", position = "auto",   scale = "auto" })
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@60",  position = "3440x0", scale = 1 })
-- hl.monitor({ output = "HDMI-A-2", mode = "2560x1600@60", position = "auto", scale = "auto" })


---------------------
------ DEFAULTS -----
---------------------

local terminal    = "ghostty"
local fileManager = "dolphin"
local browser     = "zen-browser"
local menu        = "walker --minheight 1"
-- local menu = "wofi --show drun"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("elephant")
    hl.exec_cmd("walker --gapplication-service")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh")
    hl.exec_cmd("discord", { workspace = "special:magic silent" })
end)

-- Was `exec =` in hyprlang: runs on every config load, not just at startup.
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')


-------------------------------
-------------ENV --------------
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("NVD_BACKEND", "direct")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")

hl.env("HYPRSHOT_DIR", "/home/tyr/Pictures/screenshots/")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- hl.config({ ecosystem = { enforce_permissions = true } })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing    = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a, -- rgba(1a1a1aee)
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

-- Curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })

hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = false,
        vrr                     = 2,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "pl,se",

        follow_mouse = 1,
        repeat_rate  = 60,
        repeat_delay = 400,

        sensitivity    = 0, -- -1.0 - 1.0, 0 means no modification.
        accel_profile  = "flat",
        force_no_accel = true,

        touchpad = {
            natural_scroll = false,
        },
    },
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/reload.sh"))

hl.bind(mainMod .. " + SHIFT + CTRL + Q", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.exec_cmd("hyprlock"))

-- apps
hl.bind(mainMod .. " + RETURN",      hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + B",           hl.dsp.exec_cmd("uwsm app -- " .. browser))
hl.bind(mainMod .. " + O",           hl.dsp.exec_cmd("uwsm app -- obsidian"))
hl.bind(mainMod .. " + SHIFT + E",   hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + E",           hl.dsp.exec_cmd("uwsm app -- ghostty -e yazi"))
hl.bind(mainMod .. " + SPACE",       hl.dsp.exec_cmd("uwsm app -- " .. menu))

-- other menus
hl.bind(mainMod .. " + CTRL + Q",         hl.dsp.exec_cmd("~/.config/hypr/scripts/systemctl-menu.sh"))
hl.bind(mainMod .. " + SHIFT + B",        hl.dsp.exec_cmd("uwsm app -- walker --provider bluetooth"))
hl.bind(mainMod .. " + CTRL + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/sink-select.sh"))
hl.bind(mainMod .. " + CTRL + G",         hl.dsp.exec_cmd("~/.config/hypr/scripts/mode-picker.sh"))
hl.bind(mainMod .. " + y",                hl.dsp.exec_cmd("uwsm app -- walker --provider aur"))

hl.bind(mainMod .. " + P",         hl.dsp.window.pin())
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())

-- super + ]
hl.bind(mainMod .. " + code:35", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

-- swapwindow for tiled, moveactive for floating -- both fire, in order.
local function swapOrMove(direction, dx, dy)
    return function()
        hl.dispatch(hl.dsp.window.swap({ direction = direction }))
        hl.dispatch(hl.dsp.window.move({ x = dx, y = dy, relative = true }))
    end
end

hl.bind(mainMod .. " + SHIFT + h", swapOrMove("l", -50, 0), { repeating = true })
hl.bind(mainMod .. " + SHIFT + l", swapOrMove("r", 50, 0),  { repeating = true })
hl.bind(mainMod .. " + SHIFT + k", swapOrMove("u", 0, -50), { repeating = true })
hl.bind(mainMod .. " + SHIFT + j", swapOrMove("d", 0, 50),  { repeating = true })

-- Switch workspaces, and move the active window to a workspace
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- resize windows without mouse
hl.bind("ALT + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
    hl.bind("l", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), { repeating = true })
    hl.bind("h", hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), { repeating = true })

    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- screenshots
hl.bind(mainMod .. " + CTRL + 2",         hl.dsp.exec_cmd("hyprshot -m window --freeze"))
hl.bind(mainMod .. " + CTRL + 3",         hl.dsp.exec_cmd("hyprshot -m output --freeze"))
hl.bind(mainMod .. " + CTRL + 4",         hl.dsp.exec_cmd("hyprshot -m region --freeze"))
hl.bind(mainMod .. " + CTRL + SHIFT + 4", hl.dsp.exec_cmd("hyprshot -m region --freeze --clipboard-only"))
hl.bind(mainMod .. " + CTRL + 5",         hl.dsp.exec_cmd("~/.config/hypr/scripts/obs-toggle-recording.sh"))

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/wallpaper.sh"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "xwayland-drag-fix",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name      = "steam-float",
    match     = { class = "steam" },
    float     = true,
    workspace = "6 silent",
})

hl.window_rule({
    name  = "steam-main",
    match = { class = "steam", title = "Steam" },
    move  = { 10, 100 },
    size  = { 2600, 1300 },
})

hl.window_rule({
    name  = "steam-friends",
    match = { class = "steam", title = "Friends List" },
    move  = { 2700, 100 },
    size  = { 600, 1300 },
})

hl.window_rule({
    name      = "steam-games-workspace",
    match     = { class = "^(steam_app_.*|cs2|Hollow Knight Silksong)$" },
    immediate = true,
    workspace = "5 silent",
})

hl.window_rule({
    name      = "discord-workspace",
    match     = { class = "discord" },
    workspace = "special:magic silent",
})

hl.window_rule({
    name      = "obs-special",
    match     = { class = "com.obsproject.Studio" },
    workspace = "special:magic silent",
})

-- walker
hl.layer_rule({
    name    = "walker-no-anim",
    match   = { namespace = "walker" },
    no_anim = true,
})

-- Remove 1px border around hyprshot screenshots
hl.layer_rule({
    name    = "hyprshot-no-anim",
    match   = { namespace = "selection" },
    no_anim = true,
})


-- wallust-generated colors; must stay last so it overrides general.col above.
-- Not tracked by git, so tolerate it missing (e.g. fresh clone, pre-wallust).
if not pcall(require, "colors") then
    print("hypr: colors.lua not found, run wallust; using default border colors")
end
