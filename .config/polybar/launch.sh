#!/usr/bin/env bash

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.2; done

MONITOR=DP-0 polybar 4k &
MONITOR=DP-2 polybar hd &

wait
