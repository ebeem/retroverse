#!/bin/bash

cd /storage/roms/retroverse

# check if any updates are available
if [ "$1" == "canupdate" ]; then
	git remote update &>/dev/null
	available=$(git status | grep "Your branch is behind" | sed 's/[^0-9]//g')

	case $available in
		'' | *[!0-9]*)
			echo "no"
			exit 1
			;;
		*)
			echo "($available updates are available)"
			# run the update script
			chmod 755 -R ./storage/.config/emuelec/scripts
			./storage/.config/emuelec/scripts/retroverse-update
			exit 12
			;;
	esac
fi
