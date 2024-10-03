#!/bin/bash

# Formats with day and month in text
# sketchybar --set $NAME icon="$(date '+%a %d. %b')" label="$(date '+%H:%M')"

# Formats with day and month in numbers
sketchybar --set "$NAME" label="$(date '+%d-%m | %H:%M')"
