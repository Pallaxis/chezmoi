#!/usr/bin/env bash

name="$(echo "" | rofi -dmenu -p "Enter session name: " <&-)"

if [[ -n $TMUX ]]; then
    tmux new-session -Ad -s $name
    tmux switch -t $name
fi
