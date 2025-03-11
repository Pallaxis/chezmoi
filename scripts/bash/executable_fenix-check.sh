#!/usr/bin/env bash
#\ssh root@10.71.0.168 -o StrictHostKeyChecking=no 'ash -s' < ~/scripts/bash/fenix-check.sh


OS_RELEASE=$(cat /etc/os-release | awk -F '=' '/^VERSION="/ {print $2}')
echo $OS_RELEASE
#if $OS_RELEASE == "0.1.2-b1"; then
#    echo
#    echo -e "\e[32mVersion is correct!\e[0m"
#    echo
#else
#    echo -e "\e[31mWrong version!\e[0m"
#    exit
#fi

ls -l /system/factory/pki

