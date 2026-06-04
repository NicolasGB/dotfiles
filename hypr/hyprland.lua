require("cursor")
require("environment")
require("keyboard")
require("colors")
require("window")

require("autostart")
require("animations")
require("windowrules")
require("monitors")
require("workspace")
require("keybinds")
require("layout")

require("hyprlock")
require("hypridle")
require("hyprpaper")

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
