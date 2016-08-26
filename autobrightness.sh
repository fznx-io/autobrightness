#!/bin/bash

# Configuration
NIGHT_BRIGHTNESS=0
DAY_BRIGHTNESS=3

if [ `date +%H` -lt 7  -o `date +%H` -gt 17 ]; then
echo $NIGHT_BRIGHTNESS > /sys/class/backlight/acpi_video0/brightness
else
echo $DAY_BRIGHTNESS > /sys/class/backlight/acpi_video0/brightness
fi
