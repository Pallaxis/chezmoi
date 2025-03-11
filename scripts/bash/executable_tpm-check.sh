#!/usr/bin/env bash

PROBE_RES=$(x cert probe 2>&1 | awk '/status_text/ {print $2}' | tr -d '",')
if [[ -n $PROBE_RES ]]; then
    echo
    echo -e "\e[32mProbe successful!\e[0m"
    echo
else
    echo -e "\e[31mProbe failed!\e[0m"
    exit
fi


VERIFY_RES=$(x cert verify 2>&1 | awk '/status_text/ {print $2}' | tr -d '",')
if [[ -n $VERIFY_RES ]]; then
    echo
    echo -e "\e[32mVerify successful!\e[0m"
    echo
else
    echo -e "\e[31mVerify failed!\e[0m"
    exit
fi

MANIFEST_RES=$(x manifest 2>&1 | awk '/status_text/ {print $2}' | tr -d '",')
if [[ -n $MANIFEST_RES ]]; then
    echo
    echo -e "\e[32mManifest successful!\e[0m"
    echo
else
    echo -e "\e[31mManifest failed!\e[0m"
    exit
fi

HYDRA_CHECK=$(hydra 2>&1 | awk '/Sucessfully loaded/')
if [[ -n $HYDRA_CHECK ]]; then
    echo
    echo -e "\e[32mHydra Provisioned!\e[0m"
    echo
else
    echo -e "\e[31mMissing Hydra Provision!\e[0m"
    exit
fi

OCLEA_VERSION=$(oclea_info | awk -F : '/oclea-version/ {print $2}' | tr -d '",')
echo -e "\e[33mFirmware Version Number:\e[0m"
echo -e "\e[34m$OCLEA_VERSION\e[0m"
echo

OCLEA_SERIAL=$(oclea_info | awk -F : '/serial-number/ {print $2}' | tr -d '",')
echo -e "\e[33mOclea Serial Number:\e[0m"
echo -e "\e[34m$OCLEA_SERIAL\e[0m"
echo
OCLEA_DTS=$(oclea_info | awk -F : '/dts-model/ {print $2}' | tr -d '",')
echo -e "\e[33mOclea DTS Model:\e[0m"
echo -e "\e[34m$OCLEA_DTS\e[0m"
echo
