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
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular', stretch = 'Expanded' })
-- config.font = wezterm.font 'JetBrains Mono'
config.font_size = 10.5

-- config.max_fps = 144

-- and finally, return the configuration to wezterm
return config
