#!/usr/bin/env python3
# This script requires a bash script located in the same directory as itself
# which will run TPM checks through SSH

import subprocess, contextlib, os
from boards import RPi

def main():
    device = RPi.device


    #device.power_off_period=3
    #device.power_reboot()
    file = os.path.join(os.getcwd(), "tpm-check.sh")

    try:
        ip = None
        with contextlib.suppress(EnvironmentError):
            print("Waiting for IP...")
            ip = device.wait_for_ip()
        if ip:
            ssh_string = "root@" + ip
            print(f'ip: {ip}')
            print(f'ssh string: {ssh_string}')
            subprocess.run(f"ssh -o StrictHostKeychecking=no {ssh_string} 'bash -s' < {file}", shell=True, text=True, check=True)

    except Exception as e:
        print(e)


if __name__ == '__main__':
    main()
