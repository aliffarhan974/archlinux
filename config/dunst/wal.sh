#!/bin/sh

# Symlink dunst config
yes | cp -rf .cache/wal/dunstrc .config/dunst/

# Restart dunst with the new color scheme
pkill dunst
dunst &
