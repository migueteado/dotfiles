#!/usr/bin/env bash

# Get active interface
iface=$(ip route get 1.1.1.1 | awk '{print $5; exit}')

# If no interface
if [ -z "$iface" ]; then
  echo "NO NET"
  exit
fi

# Check if wifi
if iw dev "$iface" info >/dev/null 2>&1; then
  ssid=$(iwgetid -r)
  echo "  ${ssid:-WIFI}"
else
  ip=$(ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
  echo "  ${ip:-ETH}"
fi
