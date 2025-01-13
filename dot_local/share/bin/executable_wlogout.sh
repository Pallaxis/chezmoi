#!/usr/bin/env bash

# Check if wlogout is already running
if pgrep -x "wlogout" > /dev/null; then
    pkill -x "wlogout"
    exit 0
fi

# Detect monitor resolution and scaling factor
resolution=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .height / .scale' | awk -F'.' '{print $1}')
hypr_scale=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true) | .scale')
echo $resolution
if ((resolution >= 1440 )); then
    HEIGHT=600
    WIDTH=780
else
    HEIGHT=400
    WIDTH=400
fi
wlogout -C $HOME/.config/wlogout/style.css -l $HOME/.config/wlogout/layout --protocol layer-shell -b 5 -T $(awk "BEGIN {printf \"%.0f\", $WIDTH * 1080 * $hypr_scale / $resolution}") -B $(awk "BEGIN {printf \"%.0f\", $HEIGHT * 1080 * $hypr_scale / $resolution}") &
