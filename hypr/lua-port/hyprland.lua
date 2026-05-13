require("lua-port2/monitors")
require("lua-port2/cursor")
require("lua-port2/environment")
require("lua-port2/keyboard")
require("lua-port2/colors")
require("lua-port2/window")

require("lua-port2/autostart")
require("lua-port2/animations")
require("lua-port2/windowrules")
require("lua-port2/workspace")
require("lua-port2/keybinds")
require("lua-port2/layout")

require("lua-port2/hyprlock")
require("lua-port2/hypridle")
require("lua-port2/hyprpaper")

-- Analyze if this can be moved to an autostart
hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

-- Miscelaneous things
hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		initial_workspace_tracking = 1,
		focus_on_activate = true,
	},
})
