-- Generated from conf/keybindings/custom2.conf (Lua API migration)
local function bind(keys, dispatcher, flags)
	if flags then
		return hl.bind(keys, dispatcher, flags)
	end
	return hl.bind(keys, dispatcher)
end

-- Workspaces
bind("ALT + 0", hl.dsp.focus({ workspace = "10" }))
bind("ALT + 1", hl.dsp.focus({ workspace = "1" }))
bind("ALT + 2", hl.dsp.focus({ workspace = "2" }))
bind("ALT + 3", hl.dsp.focus({ workspace = "3" }))
bind("ALT + 4", hl.dsp.focus({ workspace = "4" }))
bind("ALT + 5", hl.dsp.focus({ workspace = "5" }))
bind("ALT + 6", hl.dsp.focus({ workspace = "6" }))
bind("ALT + 7", hl.dsp.focus({ workspace = "7" }))
bind("ALT + 8", hl.dsp.focus({ workspace = "8" }))
bind("ALT + 9", hl.dsp.focus({ workspace = "9" }))

-- Window management
bind("ALT + CTRL + 0", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 10"))
bind("ALT + CTRL + 1", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 2"))
bind("ALT + CTRL + 2", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 2"))
bind("ALT + CTRL + 3", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 3"))
bind("ALT + CTRL + 4", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 4"))
bind("ALT + CTRL + 5", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 5"))
bind("ALT + CTRL + 6", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 6"))
bind("ALT + CTRL + 7", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 7"))
bind("ALT + CTRL + 8", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 8"))
bind("ALT + CTRL + 9", hl.dsp.exec_cmd("~/.config/hypr/scripts/moveTo.sh 9"))

bind("ALT + CTRL + B", hl.dsp.exec_cmd("~/.config/waybar/toggle.sh"))
bind("ALT + CTRL + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/screen-record.sh"))
bind("ALT + CTRL + S", hl.dsp.exec_cmd("flatpak run com.ml4w.settings"))
bind("ALT + CTRL + T", hl.dsp.exec_cmd("~/.config/waybar/themeswitcher.sh"))

-- Switch floating/tiled, fullscreen and group
bind("ALT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
bind("ALT + G", hl.dsp.group.toggle())
bind("ALT + M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- Move to workspace (without switching)
bind("ALT + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))
bind("ALT + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
bind("ALT + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
bind("ALT + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
bind("ALT + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
bind("ALT + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
bind("ALT + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
bind("ALT + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
bind("ALT + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
bind("ALT + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))

bind("ALT + SHIFT + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-animations.sh"))
bind("ALT + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"))
bind("ALT + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m region --clipboard-onl"))
bind("ALT + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
bind("ALT + SHIFT + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/loadconfig.sh"))
bind("ALT + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --raw | satty --filename -"))
bind("ALT + CTRL + R", hl.dsp.exec_cmd("~/.config/hypr/scripts/screen-record.sh"))
bind("ALT + SHIFT + T", hl.dsp.exec_cmd('hyprctl dispatch "workspaceopt allfloat"'))
bind("ALT + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
bind("ALT + SHIFT + X", hl.dsp.exec_cmd("~/.config/hypr/scripts/power.sh lock"))
bind("ALT + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
-- Swap windows in the specified direction
bind("ALT + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
bind("ALT + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))
bind("ALT + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
bind("ALT + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))
-- Resize windows in the specified direction
bind("ALT + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
bind("ALT + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
bind("ALT + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))

bind("ALT + T", hl.dsp.window.float({ action = "toggle" }))
bind("ALT + Tab", hl.dsp.focus({ workspace = "m+1" }))
-- Focus windows in a direction (cycle through them)
bind("ALT + h", hl.dsp.focus({ direction = "left" }))
bind("ALT + j", hl.dsp.focus({ direction = "down" }))
bind("ALT + k", hl.dsp.focus({ direction = "up" }))
bind("ALT + l", hl.dsp.focus({ direction = "right" }))

-- Mouse actions
bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })
bind("ALT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind("ALT + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

--- Applications
bind("ALT + p", hl.dsp.exec_cmd("1password  --toggle"))
bind("ALT + x", hl.dsp.exec_cmd("~/.config/ml4w/scripts/wlogout.sh"))
bind("CTRL + SHIFT + p", hl.dsp.exec_cmd("1password  --quick-access"))
bind("SUPER + B", hl.dsp.exec_cmd("~/.config/ml4w/settings/browser.sh"))
bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "Insert" }), { description = "Universal copy" })
bind("SUPER + CTRL + V", hl.dsp.exec_cmd("~/.config/ml4w/scripts/cliphist.sh"))
bind("SUPER + E", hl.dsp.exec_cmd("~/.config/ml4w/settings/filemanager.sh"))
bind("SUPER + Q", hl.dsp.window.close())
bind("SUPER + RETURN", hl.dsp.exec_cmd("~/.config/ml4w/settings/terminal.sh"))
bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
bind("SUPER + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }), { description = "Universal paste" })
bind("SUPER + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }), { description = "Universal cut" })
bind("SUPER + space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun -replace -i"))

-- Special keys
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"))
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"))
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
bind("XF86Calculator", hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh"))
-- b("XF86Lock", hl.dsp.exec_cmd("hyprlock"))
bind(
	"XF86Tools",
	hl.dsp.exec_cmd(
		"$(cat ~/.config/ml4w/settings/terminal.sh) --class dotfiles-floating -e ~/.config/ml4w/apps/ML4W_Dotfiles_Settings-x86_64.AppImage"
	)
)
bind("code:238", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"))
bind("code:237", hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"))
