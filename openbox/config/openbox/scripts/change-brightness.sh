#!/bin/bash
# changeBrightness

scripts="$HOME/.config/openbox/scripts"
msgId="991949"

# Change brightness
xbacklight "$@"

# Query brightness
brightness="$(xbacklight -get | cut -d '.' -f 1)"

# Show the volume notification
dunstify -a "changeBrightness" -u low -i colorfx -r "$msgId" \
"Brightness: ${brightness}%" "$(bash "${scripts%%/}/getProgressString.sh" 10 "<b>o</b>" "o" $brightness)"

# Sound
canberra-gtk-play -i audio-volume-change -d "changeVolume"
