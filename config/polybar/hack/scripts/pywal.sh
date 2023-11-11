#!/usr/bin/env bash

# Color files
PFILE="$HOME/.config/polybar/hack/colors.ini"
RFILE="$HOME/.config/polybar/hack/scripts/rofi/colors.rasi"
WFILE="$HOME/.cache/wal/colors.sh"

# Get colors
pywal_get() {
	wal --recursive -i "$1" -q -t -n -e -o $HOME/.config/dunst/wal.sh
}

# Change colors
change_color() {
	# polybar

    BG=$(echo "$BG" | sed 's/#/#B0/')
    FG=$(echo "$FG" | sed 's/#/#B0/')

	sed -i -e "s/background = #.*/background = $BG/g" $PFILE
	sed -i -e "s/foreground = #.*/foreground = $FG/g" $PFILE
	sed -i -e "s/primary = #.*/primary = $AC/g" $PFILE
	
	# rofi
	cat > $RFILE <<- EOF
	/* colors */

	* {
	  al:    #00000000;
	  bg:    ${BG};
	  ac:    ${AC}09;
	  se:    ${AC}26;
	  fg:    ${FG};
	}
	EOF
	
	polybar-msg cmd restart
    feh --bg-fill "$(< "${HOME}/.cache/wal/wal")"  
}

# Main
if [[ -x "`which wal`" ]]; then
	if [[ "$1" ]]; then
		pywal_get "$1"
36
		# Source the pywal color file
		if [[ -e "$WFILE" ]]; then
			. "$WFILE"
		else
			echo 'Color file does not exist, exiting...'
			exit 1
		fi

		BG=`printf "%s\n" "$background"`
		FG=`printf "%s\n" "$foreground"`
		AC=`printf "%s\n" "$color1"`

		change_color
        cwd=$(pwd)
        cd $HOME/.local/bin/ && $HOME/.local/bin/generate-theme.sh
        cd $cwd
        sleep 1
        $HOME/.local/bin/chromium_wal.sh
	else
		echo -e "[!] Please enter the path to wallpaper. \n"
		echo "Usage : ./pywal.sh path/to/image"
	fi
else
	echo "[!] 'pywal' is not installed."
fi
