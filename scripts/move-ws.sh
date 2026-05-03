#!/bin/bash
current=$(swaymsg -t get_workspaces | jq '.[] | select(.focused) | .name | tonumber')
target=$((current + $1))
swaymsg "move container to workspace number $target; workspace number $target"
