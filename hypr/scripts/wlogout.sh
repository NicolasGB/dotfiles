#!/bin/sh

# Keep the menu on the focused display and size margins in logical pixels.
height=$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .height / .scale | floor')
margin=$((height * 27 / 100))

exec wlogout -n -b 5 -T "$margin" -B "$margin"
