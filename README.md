# autobrightness

A smart bash script that automatically adjusts screen brightness based on the time of day on Linux systems.

## Features

- **4 Time Periods**: Dawn, Day, Dusk, and Night with different brightness levels
- **Auto-Detection**: Automatically finds your backlight device (Intel, AMD, Radeon, ACPI, NVIDIA)
- **Fully Configurable**: Easy-to-adjust brightness levels and time periods
- **Lightweight**: Simple bash script with no dependencies
- **Hardware Compatible**: Works with most Linux laptop and desktop backlight interfaces

## Configuration

All settings are located at the top of the script for easy customization:

### Brightness Levels
```bash
NIGHT_BRIGHTNESS=0    # 10:00 PM - 5:00 AM
DAWN_BRIGHTNESS=2     # 5:00 AM - 7:00 AM
DAY_BRIGHTNESS=5      # 7:00 AM - 5:00 PM
DUSK_BRIGHTNESS=3     # 5:00 PM - 10:00 PM
```

### Time Periods
```bash
DAWN_START=5     # Dawn begins at 5 AM
DAWN_END=7       # Dawn ends at 7 AM
DAY_END=17       # Day ends at 5 PM
DUSK_END=22      # Dusk ends at 10 PM
```

## Installation

1. Clone or download the script:
```bash
git clone https://github.com/yourusername/autobrightness.git
cd autobrightness
```

2. Make the script executable:
```bash
chmod +x autobrightness.sh
```

3. Test the script (requires sudo):
```bash
sudo ./autobrightness.sh
```

## Usage

### Manual Execution
Run the script anytime to adjust brightness based on current time:
```bash
sudo ./autobrightness.sh
```

### Automatic Execution with Cron

To run automatically every hour, add to your crontab:

```bash
sudo crontab -e
```

Add this line:
```
0 * * * * /path/to/autobrightness.sh
```

For more frequent updates (every 15 minutes):
```
*/15 * * * * /path/to/autobrightness.sh
```

### Startup Application

#### Using systemd (Recommended)

1. Create a service file:
```bash
sudo nano /etc/systemd/system/autobrightness.service
```

2. Add the following content:
```ini
[Unit]
Description=Auto Brightness Adjustment
After=graphical.target

[Service]
Type=oneshot
ExecStart=/path/to/autobrightness.sh

[Install]
WantedBy=graphical.target
```

3. Create a timer file:
```bash
sudo nano /etc/systemd/system/autobrightness.timer
```

4. Add the following content:
```ini
[Unit]
Description=Run autobrightness every 15 minutes

[Timer]
OnBootSec=1min
OnUnitActiveSec=15min

[Install]
WantedBy=timers.target
```

5. Enable and start the timer:
```bash
sudo systemctl enable autobrightness.timer
sudo systemctl start autobrightness.timer
```

#### Using Desktop Autostart

Create a desktop entry for your desktop environment's autostart:

```bash
mkdir -p ~/.config/autostart
nano ~/.config/autostart/autobrightness.desktop
```

Add:
```ini
[Desktop Entry]
Type=Application
Name=Auto Brightness
Exec=sudo /path/to/autobrightness.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
```

**Note**: You'll need to configure passwordless sudo for this script.

## Supported Hardware

The script automatically detects backlight devices in this order:
1. Intel backlight (`/sys/class/backlight/intel_backlight`)
2. AMD GPU backlight (`/sys/class/backlight/amdgpu_bl0`)
3. Radeon backlight (`/sys/class/backlight/radeon_bl0`)
4. ACPI video backlight (`/sys/class/backlight/acpi_video0`)
5. NVIDIA backlight (`/sys/class/backlight/nvidia_backlight`)

## Troubleshooting

### Permission Denied
The script requires root privileges to modify brightness:
```bash
sudo ./autobrightness.sh
```

### No Backlight Device Found
Check available backlight devices:
```bash
ls /sys/class/backlight/
```

If your device uses a different path, you can modify the `BACKLIGHT_DEVICES` array in the script.

### Brightness Values
Different hardware has different maximum brightness values. Check your max brightness:
```bash
cat /sys/class/backlight/*/max_brightness
```

Adjust the brightness values in the script accordingly.

## Customization

### Adjust for Your Schedule
If you wake up later or work different hours, modify the time periods:
```bash
DAWN_START=7      # Start dawn at 7 AM instead of 5 AM
DAY_END=19        # Extend day until 7 PM
```

### Add More Time Periods
You can extend the script to include more granular time periods by adding additional conditions in the time-checking logic.

### Use Percentages
To use percentage-based brightness, first check your max brightness and calculate accordingly:
```bash
MAX=$(cat /sys/class/backlight/*/max_brightness)
DAY_BRIGHTNESS=$((MAX * 80 / 100))  # 80% brightness
```

## Requirements

- Linux operating system
- Bash shell
- Root/sudo access
- Backlight device in `/sys/class/backlight/`

## License

This project is open source and available under the MIT License.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
