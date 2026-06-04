-- Derive monitor names from top-level ~/.config/hypr/monitors.lua (nwg-displays generated)
-- so workspace pinning survives output-name changes.
local function get_monitors_file()
	local xdg = os.getenv("XDG_CONFIG_HOME")
	if xdg and #xdg > 0 then
		return xdg .. "/hypr/monitors.lua"
	end

	local home = os.getenv("HOME") or ""
	return home .. "/.config/hypr/monitors.lua"
end

local function read_output_names(path)
	local f = io.open(path, "r")
	if not f then
		return {}
	end

	local outputs = {}
	for line in f:lines() do
		local out = line:match('output%s*=%s*"([^"]+)"')
		if out then
			table.insert(outputs, out)
		end
	end
	f:close()

	return outputs
end

local function read_connected_output_names()
	local p = io.popen([[sh -c 'for s in /sys/class/drm/card*-*/status; do
		[ -f "$s" ] || continue
		if [ "$(cat "$s" 2>/dev/null)" = "connected" ]; then
			b=$(basename "$(dirname "$s")")
			printf "%s\n" "${b#*-}"
		fi
	done']])
	if not p then
		return {}
	end

	local outputs = {}
	local seen = {}
	for line in p:lines() do
		if line ~= "" and not seen[line] then
			table.insert(outputs, line)
			seen[line] = true
		end
	end
	p:close()

	return outputs
end

local configured = read_output_names(get_monitors_file())
local connected = read_connected_output_names()

local connected_set = {}
for _, out in ipairs(connected) do
	connected_set[out] = true
end

local function first_matching(list, pattern)
	for _, out in ipairs(list) do
		if out:match(pattern) then
			return out
		end
	end
	return nil
end

local MAIN_MONITOR = configured[1]
local SECONDARY_MONITOR = configured[2] or configured[1]

-- If nwg-displays file is stale (e.g. DP-4 renamed to DP-2), prefer currently connected outputs.
if #connected > 0 then
	if not MAIN_MONITOR or not connected_set[MAIN_MONITOR] then
		MAIN_MONITOR = first_matching(connected, "^eDP%-") or connected[1]
	end

	if not SECONDARY_MONITOR or not connected_set[SECONDARY_MONITOR] then
		SECONDARY_MONITOR = first_matching(connected, "^DP%-")
			or first_matching(connected, "^HDMI%-")
			or connected[2]
			or connected[1]
	end

	if SECONDARY_MONITOR == MAIN_MONITOR then
		for _, out in ipairs(connected) do
			if out ~= MAIN_MONITOR then
				SECONDARY_MONITOR = out
				break
			end
		end
	end
end

-- Same mapping as before:
-- workspace 1/3/4 on main monitor, workspace 2/5 on secondary.
if MAIN_MONITOR then
	hl.workspace_rule({ workspace = "1", monitor = MAIN_MONITOR, default = true })
	hl.workspace_rule({ workspace = "3", monitor = MAIN_MONITOR })
	hl.workspace_rule({ workspace = "4", monitor = MAIN_MONITOR })
end

if SECONDARY_MONITOR then
	hl.workspace_rule({ workspace = "2", monitor = SECONDARY_MONITOR, default = true })
	hl.workspace_rule({ workspace = "5", monitor = SECONDARY_MONITOR })
end
