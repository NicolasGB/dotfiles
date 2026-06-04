local C = require("colors")

hl.config({

	general = {
		gaps_in = 10,
		gaps_out = 14,
		border_size = 2,
		col = {
			active_border = "rgba(8ae1c1ff)",
			inactive_border = C.color8,
		},
		resize_on_border = true,
	},

	decoration = {
		rounding = 10,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		fullscreen_opacity = 1.0,
		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			new_optimizations = true,
			ignore_opacity = true,
			xray = true,
		},
		shadow = {
			enabled = true,
			range = 30,
			render_power = 3,
			color = "0x66000000",
		},
	},
})
