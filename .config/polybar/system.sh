#!/usr/bin/env bash

# CPU (simple avg)
cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf("%02.0f", usage)}')

# Memory in GiB (used)
mem=$(free -b | awk '/Mem:/ {printf("%.1f", $3/1024/1024/1024)}')

# Output
echo "  ${cpu}% / ${mem}GiB"
