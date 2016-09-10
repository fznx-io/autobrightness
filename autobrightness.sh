#!/bin/bash

# Configuration
NIGHT_BRIGHTNESS=0          # Brightness for night (10:00 PM - 5:00 AM)
DAWN_BRIGHTNESS=2           # Brightness for dawn (5:00 AM - 7:00 AM)
DAY_BRIGHTNESS=5            # Brightness for day (7:00 AM - 5:00 PM)
DUSK_BRIGHTNESS=3           # Brightness for dusk (5:00 PM - 10:00 PM)

DAWN_START=5
DAWN_END=7
DAY_END=17
DUSK_END=22

# Auto-detect backlight device
BACKLIGHT_DEVICES=(
    "/sys/class/backlight/intel_backlight"
    "/sys/class/backlight/amdgpu_bl0"
    "/sys/class/backlight/radeon_bl0"
    "/sys/class/backlight/acpi_video0"
    "/sys/class/backlight/nvidia_backlight"
)

BACKLIGHT_PATH=""
for device in "${BACKLIGHT_DEVICES[@]}"; do
    if [ -d "$device" ]; then
        BACKLIGHT_PATH="$device"
        break
    fi
done

if [ -z "$BACKLIGHT_PATH" ]; then
    echo "Error: No backlight device found" >&2
    exit 1
fi

# Determine target brightness based on time of day
HOUR=$(date +%H)

if [ "$HOUR" -ge "$DAWN_START" ] && [ "$HOUR" -lt "$DAWN_END" ]; then
    # Dawn period (5 AM - 7 AM)
    TARGET_BRIGHTNESS=$DAWN_BRIGHTNESS
elif [ "$HOUR" -ge "$DAWN_END" ] && [ "$HOUR" -lt "$DAY_END" ]; then
    # Day period (7 AM - 5 PM)
    TARGET_BRIGHTNESS=$DAY_BRIGHTNESS
elif [ "$HOUR" -ge "$DAY_END" ] && [ "$HOUR" -lt "$DUSK_END" ]; then
    # Dusk period (5 PM - 10 PM)
    TARGET_BRIGHTNESS=$DUSK_BRIGHTNESS
else
    # Night period (10 PM - 5 AM)
    TARGET_BRIGHTNESS=$NIGHT_BRIGHTNESS
fi

# Apply brightness
echo $TARGET_BRIGHTNESS > "$BACKLIGHT_PATH/brightness"
