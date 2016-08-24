#!/bin/bash

if [ `date +%H` -lt 7  -o `date +%H` -gt 17 ]; then
echo 0 > /sys/class/backlight/acpi_video0/brightness
else
echo 3 > /sys/class/backlight/acpi_video0/brightness
fi
