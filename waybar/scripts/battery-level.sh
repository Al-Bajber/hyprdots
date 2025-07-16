#!/usr/bin/env bash

# Battery levels (match these with your Waybar config)
WARNING_LEVEL=20
CRITICAL_LEVEL=10

# Get battery data using acpi
BATTERY_INFO=$(acpi -b 2>/dev/null)

# Extract status and percentage
BATTERY_STATE=$(echo "$BATTERY_INFO" | awk '{print $3}' | tr -d ',')
BATTERY_LEVEL=$(echo "$BATTERY_INFO" | awk '{print $4}' | tr -d '%,')

# Extract and format time remaining
TIME_REMAINING=$(echo "$BATTERY_INFO" | awk -F ',' '{print $3}' | sed '
  s/^ *//; 
  s/ remaining//; 
  s/ until charged//;
  s/hours/h/; 
  s/hour/h/; 
  s/minutes/m/;
')

# JSON output for Waybar
if [ -n "$TIME_REMAINING" ]; then
  echo "{\"text\": \"$BATTERY_LEVEL%\", \"tooltip\": \"$BATTERY_STATE: $TIME_REMAINING\"}"
else
  echo "{\"text\": \"$BATTERY_LEVEL%\", \"tooltip\": \"$BATTERY_STATE\"}"
fi

# Notification logic (unchanged from your original)
FILE_FULL=/tmp/battery-full
FILE_WARNING=/tmp/battery-warning
FILE_CRITICAL=/tmp/battery-critical

if [ "$BATTERY_STATE" == "Discharging" ]; then
  rm -f $FILE_FULL
elif [ "$BATTERY_STATE" == "Charging" ]; then
  brightnessctl set 50%
  rm -f "$FILE_WARNING" "$FILE_CRITICAL"
fi

if [ "$BATTERY_LEVEL" -eq 100 ] && [ "$BATTERY_STATE" == "Full" ] && [ ! -f $FILE_FULL ]; then
  notify-send -a "state" "Battery Charged (${BATTERY_LEVEL}%)" "You might want to unplug your PC." -i "battery-full" -r 9991
  touch $FILE_FULL
elif [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_STATE" == "Discharging" ] && [ ! -f $FILE_WARNING ]; then
  brightnessctl -s set 20%
  notify-send -a "state" "Battery Low (${BATTERY_LEVEL}%)" "You might want to plug in your PC." -u critical -i "battery-caution" -r 9991
  touch $FILE_WARNING
elif [ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL ] && [ "$BATTERY_STATE" == "Discharging" ] && [ ! -f $FILE_CRITICAL ]; then
  brightnessctl set 10%
  notify-send -a "state" "Battery Critical (${BATTERY_LEVEL}%)" "Plug in your PC now." -u critical -i "battery-empty" -r 9991
  touch $FILE_CRITICAL
fi
