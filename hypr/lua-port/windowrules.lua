-- Pulseaudio Volume Control
-- hl.window_rule({
-- 	name = "windowrule-1",
-- 	float = true,
-- 	size = { 700, 600 },
-- 	center = true,
-- 	pin = true,
-- 	match = { class = ".*org.pulseaudio.pavucontrol.*" },
-- })

-- Waypaper
hl.window_rule({
	name = "windowrule-4",
	float = true,
	size = { 900, 700 },
	center = true,
	pin = true,
	match = { class = ".*waypaper.*" },
})

-- Swaync
hl.layer_rule({ name = "layerrule-1", blur = true, ignore_alpha = 0.5, match = { namespace = "swaync-control-center" } })
hl.layer_rule({
	name = "layerrule-2",
	blur = true,
	ignore_alpha = 0.5,
	match = { namespace = "swaync-notification-window" },
})

-- NWG-look and NWG-displays
hl.window_rule({
	name = "windowrule-10",
	float = true,
	size = { 700, 600 },
	move = { "(monitor_w*0.1)", "(monitor_h*0.2)" },
	pin = true,
	match = { class = "nwg-look" },
})
hl.window_rule({
	name = "windowrule-11",
	float = true,
	size = { 1000, 800 },
	move = { "(monitor_w*0.1)", "(monitor_h*0.2)" },
	pin = true,
	match = { class = "nwg-displays" },
})

-- Calculator
hl.window_rule({
	name = "windowrule-14",
	float = true,
	size = { 700, 600 },
	center = true,
	match = { class = "org.gnome.Calculator" },
})

-- Browsers
hl.window_rule({ name = "ms-edge", tile = true, match = { title = "^(Microsoft-edge)$" } })
hl.window_rule({ name = "brave-browser", tile = true, match = { title = "^(Brave-browser)$" } })
hl.window_rule({ name = "chromium", tile = true, match = { title = "^(Chromium)$" } })
-- Pavucontrol
hl.window_rule({ name = "pavucontrol", float = true, match = { title = "^(pavucontrol)$" } })
-- Blueman-manager
hl.window_rule({ name = "blueman-manager", float = true, match = { class = "^(blueman-manager)$" } })
-- NetworkManager Connection Editor
hl.window_rule({ name = "nm-connection-editor", float = true, match = { title = "^(nm-connection-editor)$" } })
hl.window_rule({ name = "qalculate-gtk", float = true, match = { title = "^(qalculate-gtk)$" } })
-- Picture-in-Picture
hl.window_rule({
	name = "pip-rule",
	float = true,
	pin = true,
	move = { "(monitor_w*0.695)", "(monitor_h*0.04)" },
	match = { title = "^(Picture-in-Picture)$" },
})

-- Zen Browser
hl.window_rule({ name = "zen-rule", workspace = "1", match = { class = "zen" } })
-- Discord
hl.window_rule({ name = "discord-rule", workspace = "3", match = { class = "discord" } })
-- 1Password
hl.window_rule({
	name = "1Password-rule",
	float = true,
	center = true,
	match = { title = "(1Password)" },
	size = { "(monitor_w*0.5)", "(monitor_h*0.6)" },
	no_screen_share = true,
})
-- Satty
hl.window_rule({
	name = "satty-rule",
	float = true,
	size = { "(monitor_w*0.7)", "(monitor_h*0.7)" },
	center = true,
	match = { title = "(satty)" },
})
-- ShowMeTheKey
hl.window_rule({ name = "showmethekey-rule", float = true, match = { class = "(showmethekey-gtk)" } })
