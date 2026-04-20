#!/usr/bin/env bash

get_volume() {
  # get first percentage safely
  volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -n1 | tr -d '%')
  mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

  # fallback if empty (prevents printf error)
  volume=${volume:-0}

  vol_padded=$(printf "%03d" "$volume")

  if [ "$mute" = "yes" ] || [ "$volume" -eq 0 ]; then
    echo "  ${vol_padded}%"
  else
    echo "  ${vol_padded}%"
  fi
}

get_volume

pactl subscribe | while read -r event; do
  if echo "$event" | grep -q "sink"; then
    get_volume
  fi
done
