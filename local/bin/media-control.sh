#!/bin/sh

# media-control is a script that acts like playerctl, but controls MPD
# instead of MPRIS if MPD is runnning.
# I created media-control to replace playerctl when binding media keys.

mpc_status=$(mpc status | grep -o playing)

if [ "$mpc_status" = "playing" ]; then
	# translate playerctl commands to mpc commands
	case "$1" in
		play-pause)
			mpc toggle
			;;
		previous)
			mpc prev
			;;
		next)
			mpc next
			mpc sticker "$(mpc status -f '%file%' | sed 1q)" list
			;;
		*) mpc "$@" ;;
	esac
elif playerctlpath="$(command -v playerctl >/dev/null)"; then
	if echo "$playerctlpath" | grep "^$HOME/.local" >/dev/null; then
		LD_LIBRARY_PATH="$HOME/.local/lib/:$LD_LIBRARY_PATH"
		GI_TYPELIB_PATH="$HOME/.local/lib/:$GI_TYPELIB_PATH"
	fi
	playerctl "$@"
else
	# shellcheck disable=SC2016 # I don't want expansion in this string
	echo 'mpd is not running, and playerctl is not in your $PATH'
fi

# vi:ft=sh
