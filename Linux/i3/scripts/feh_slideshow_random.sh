#!/bin/sh

bg_path="$HOME/Pictures/wallpapers"

while [ -d $bg_path ]
do
    # Sets the background
    feh --bg-fill --no-fehbg --randomize $bg_path

    # Waits 10 minutes to restart the loop
    sleep 300
done
