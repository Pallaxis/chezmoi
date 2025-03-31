#!/usr/bin/env bash
# Just runs oclea-usb first with -e, then after without
# Has some pretty colors too

firmware_path=$1

oclea_usb=oclea-usb

oclea_erase="$oclea_usb -o $firmware_path -z normal -e"

oclea_flash="$oclea_usb -o $firmware_path -z normal"

red='\e[91m'
green='\e[92m'
blue='\e[34m'
no_color='\e[39m'

if [ ! -f $firmware_path ]; then
    echo -e "${red}Firmware not found!${no_color}"
    exit
fi

$oclea_usb -V
echo

echo $oclea_erase
if $oclea_erase; then
    echo -e "${green}Erasing complete!${no_color}"
    echo -e "${blue}Flashing with $(basename $firmware_path)${no_color}"
    sleep 2 && $oclea_flash
fi
