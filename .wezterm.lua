-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Colorscheme
config.color_scheme = 'Everforest Dark (Gogh)'
-- Opacity
config.window_background_opacity = 0.70

-- Nav bar
config.hide_tab_bar_if_only_one_tab = true

-- Font
config.font = wezterm.font_with_fallback({
    -- { family = 'JetBrains Mono',          weight = 'Regular' },
    { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
    "JetBrainsMono Nerd Font",
    "Material Design Icons",
    "Symbols Nerd Font",
})
config.font_size = 10.5
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
    left = 4,
    right = 4,
    top = 4,
    bottom = 4,
}

config.window_close_confirmation = 'NeverPrompt'

-- Cursor things
config.force_reverse_video_cursor = true
config.hide_mouse_cursor_when_typing = false

config.max_fps = 144

-- Disable fullscreen keybinding to prevent overlap with code actions
config.keys = {
    { key = "Enter", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
}

-- and finally, return the configuration to wezterm
return config
