# autobrightness

Simple script to adjust screen brightness based on time of day.

## Usage

Run with sudo:
```bash
sudo ./autobrightness.sh
```

## Configuration

Edit the brightness values at the top of the script:
- `NIGHT_BRIGHTNESS`: Brightness for night (10 PM - 5 AM)
- `DAWN_BRIGHTNESS`: Brightness for dawn (5 AM - 7 AM)
- `DAY_BRIGHTNESS`: Brightness for day (7 AM - 5 PM)
- `DUSK_BRIGHTNESS`: Brightness for dusk (5 PM - 10 PM)

## Automatic Execution with Cron

To run automatically, add to your crontab:

```bash
sudo crontab -e
```

Add this line to run every 15 minutes:
```
*/15 * * * * /path/to/autobrightness.sh
```
