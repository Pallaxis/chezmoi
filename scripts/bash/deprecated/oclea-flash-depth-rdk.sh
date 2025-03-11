#!/usr/bin/env bash

# Set the folder you keep your firmware in,
# as well as the specific firmware to use.
FIRMWARE_HOME=$HOME/Firmware
FIRMWARE_FILE=oclea-cv25-firmware-depth-rdk-v2.7z

# Combines them to keep things clean
COMPLETE_PATH=$FIRMWARE_HOME/$FIRMWARE_FILE

# Check that our folder/file exists and give an error if they don't
if [ ! -d $FIRMWARE_HOME ]; then
    printf "%s doesn't exist" "$FIRMWARE_HOME"
    exit
fi
if [ ! -f $COMPLETE_PATH ]; then
    printf "%s doesn't exist in %s" "$FIRMWARE_FILE" "$FIRMWARE_HOME"
    exit
fi


# Finally run our flash command
while true; do
    if oclea-usb -o $COMPLETE_PATH -z normal; then
        notify-send -u normal -w -a oclea-flash "FINISHED FLASHING CV25"
        echo
        printf "Flashing complete at %s" "$(date | awk '{print $4}')"
        echo
    else
        printf "Flashing didn't complete properly."
    fi

done
