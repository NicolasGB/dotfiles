-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Colorscheme
config.color_scheme = "Everforest Dark (Gogh)"
-- Opacity
config.window_background_opacity = 0.70

-- Nav bar
config.hide_tab_bar_if_only_one_tab = true

-- Font
config.font = wezterm.font_with_fallback({
	-- { family = 'JetBrains Mono',          weight = 'Regular' },
	{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
	"Noto Sans CJK",
	"Material Design Icons",
	"Symbols Nerd Font",
})
config.font_size = 13
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

config.window_close_confirmation = "NeverPrompt"

-- Cursor things
config.force_reverse_video_cursor = true
config.hide_mouse_cursor_when_typing = false

config.max_fps = 120

-- Disable fullscreen keybinding to prevent overlap with code actions
config.keys = {
	{ key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
	{ key = "q", mods = "CTRL", action = wezterm.action.DisableDefaultAssignment },
}

-- Enable hyperlinks
-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- make task numbers clickable
-- the first matched regex group is captured in $1.
table.insert(config.hyperlink_rules, {
	regex = [[\b[tt](\d+)\b]],
	format = "https://example.com/tasks/?t=$1",
})

-- make username/project paths clickable. this implies paths like the following are for github.
-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
-- as long as a full url hyperlink regex exists above this it should not match a full url to
-- github or gitlab / bitbucket (i.e. https://gitlab.com/user/project.git is still a whole clickable url)
table.insert(config.hyperlink_rules, {
	regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
	format = "https://www.github.com/$1/$3",
})

config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- and finally, return the configuration to wezterm
return config
