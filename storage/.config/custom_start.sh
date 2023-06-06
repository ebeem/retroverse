#!/usr/bin/env sh
emuelec-bluetooth 15 -1

# write version number
cd /storage/roms/retroverse
current_version=$(git rev-list --count HEAD)
echo "1.0$current_version" >/storage/.config/EE_VERSION
