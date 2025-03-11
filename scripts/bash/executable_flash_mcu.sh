#!/bin/bash

FILE_NAME=""
FLASH_FILE_NAME="flash.jlink"

function createFlashJlink {
    echo "speed 500" > $FLASH_FILE_NAME
    echo "SelectInterface c2" >> $FLASH_FILE_NAME
    echo "device EFM8BB51F16G" >> $FLASH_FILE_NAME
    echo "connect" >> $FLASH_FILE_NAME
    echo "erase" >> $FLASH_FILE_NAME
    echo "loadfile ${FILE_NAME} 0" >> $FLASH_FILE_NAME
    echo "exit" >> $FLASH_FILE_NAME
}

function show_help {
    echo "Usage: $0 <fileName> | -h | --help"
    echo "Example:"
    echo "  $0 CV28_MCU"
}

if [[ $1 == "-h" || $1 == "--help" ]]; then
    show_help
    exit 0
fi

if [[ -z "$1" ]]; then
    echo "No file name provided."
    show_help
    exit 1
fi

FILE_NAME="$1"

createFlashJlink

JLinkExe -CommanderScript $FLASH_FILE_NAME

# delete the flash file
rm $FLASH_FILE_NAME
