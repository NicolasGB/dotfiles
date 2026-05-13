-- Mirrors previous logic from ~/.config/hypr/workspaces.conf (nwg-displays):
-- workspace 1/3/4 on eDP-1, workspace 2/5 on DP-2.
-- All other workspaces remain dynamic on the currently focused monitor.
local MAIN_MONITOR = "eDP-1"
local SECONDARY_MONITOR = "DP-2"

hl.workspace_rule({ workspace = "1", monitor = MAIN_MONITOR, default = true })
hl.workspace_rule({ workspace = "2", monitor = SECONDARY_MONITOR, default = true })
hl.workspace_rule({ workspace = "3", monitor = MAIN_MONITOR })
hl.workspace_rule({ workspace = "4", monitor = MAIN_MONITOR })
hl.workspace_rule({ workspace = "5", monitor = SECONDARY_MONITOR })
