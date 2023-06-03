#!/bin/bash

cd /storage/roms/retroverse
arguments="$@"

# check if any updates are available
git remote update &>/dev/null
available=$(git status | grep "Your branch is behind" | sed 's/[^0-9]//g')
current=$(git rev-list --count HEAD)

function check_update() {
	if [[ "$arguments" == *"canupdate"* ]]; then
		echo "1.0 $(current + available)"
	elif [[ "$arguments" == *"geturl"* ]]; then
		echo "http://github.com/ebeem/retroverse"
	elif [[ "$arguments" == *"getsize"* ]]; then
		echo "~1MB"
	fi
}

function forced_update() {
	chmod 755 -R ./storage/.config/emuelec/scripts
	./storage/.config/emuelec/scripts/emuelec-upgrade
}

case $available in
	'' | *[!0-9]*)
		echo "no"
		exit 1
		;;
	*)
		check_update
		;;
esac

if [[ "$arguments" == *"forceupdate"* ]]; then
	# run the update script
	chmod 755 -R ./storage/.config/emuelec/scripts
	./storage/.config/emuelec/scripts/emuelec-upgrade
fi
