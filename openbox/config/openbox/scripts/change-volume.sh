#!/bin/bash
# changeVolume

scripts="$HOME/.config/openbox/scripts"
msgId="991949"

# Query mute
mute="$(amixer -D pulse get Master | grep '%' |head -n 1| grep -oE '[^ ]+$' | grep off |cut -d '[' -f 2|cut -d ']' -f 1)"

# Change the volumen using pulseaudio
if [[ $@ == "m" ]]; then
  if [[ $mute == "off" ]]; then
    pactl set-sink-mute @DEFAULT_SINK@ false 
    mute="on"
  else
    pactl set-sink-mute @DEFAULT_SINK@ true 
    mute="off"
  fi
else
  pactl set-sink-mute @DEFAULT_SINK@ false
  pactl set-sink-volume @DEFAULT_SINK@ "$@"
fi

# Query volume
volume="$(amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1)"

if [[ $volume == 0 || $mute == "off" ]]; then
    # Show the sound muted notification
    dunstify -a "changeVolume" -u low -i audio-volume-muted -r "$msgId" "Volume muted" 
else
    #Show the volume notification
    echo $volume
    if (($volume <= 40)); then
      icon=audio-volume-low;
    elif (($volume > 30 && $volume <= 70)); then
      icon=audio-volume-medium;
    else
      icon=audio-volume-high;
    fi

    dunstify -a "changeVolume" -u low -i "$icon" -r "$msgId" \
    "Volume: ${volume}%" "$(bash "${scripts%%/}/getProgressString.sh" 10 "██" "░░" $volume)"
    # Sound
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
fi

