#!/usr/bin/env bash

if ! tmux has-session -t Update; then
	tmux new -n Update -s Update ~/.local/share/bin/update.sh
    else
        notify-send --urgency=normal "Update session already exists, exiting..."
        exit
fi

