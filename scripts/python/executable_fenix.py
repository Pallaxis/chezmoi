#!/usr/bin/env python3
import subprocess
import time
import sys

def get_ssh_devices():
    try:
        result = subprocess.run(
            ["avahi-browse", "-rtkp", "_ssh._tcp"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if result.returncode == 0:
            return parse_avahi_output(result.stdout)
        else:
            print(f"Error running avahi-browse: {result.stderr}")
            return {}
    except Exception as e:
        print(f"Exception occurred: {str(e)}")
        return {}

def parse_avahi_output(output):
    devices = []
    for line in output.splitlines():
        if line.startswith("="):
            segments = line.split(';')
            hostname = segments[3]
            address = segments[7]
            if "buildroot" in hostname:
                if "192.168.128" in address:
                    devices.append(address)
    return devices

def check_for_error(devices):
    devices_with_errors = []
    for device in devices:
        print(f"SSHing to {device}")
        while True:  # Loop until SSH connection is successful
            result = subprocess.run(
                ["ssh", f"root@{device}", "-o", "StrictHostKeyChecking=no", "cat /var/log/OTAHandler.log | awk '/Failed to apply update\\./'"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            if "Host is unreachable" not in result.stderr and "No route to host" not in result.stderr:
                break  # Exit loop if no "host unreachable" or "no route to host" error
            print(f"Host unreachable for {device}, retrying...")
            time.sleep(5)  # Wait for 5 seconds before retrying

        if result.returncode != 0:
            print(f"Failed to connect to {device}: {result.stderr}")
            continue

        print(result.stdout)
        if "Failed to apply update" in result.stdout:
            devices_with_errors.append(device)
            print(f"{device} has an error\n")
        else:
            print(f"{device} passed error check\n")
    return devices_with_errors

def reboot_devices(devices):
    for device in devices:
        print(f"Rebooting {device}")
        while True:  # Loop until SSH connection is successful
            result = subprocess.run(
                ["ssh", f"root@{device}", "-o", "StrictHostKeyChecking=no", "reboot"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            if "Host is unreachable" not in result.stderr and "No route to host" not in result.stderr:
                break  # Exit loop if no "host unreachable" or "no route to host" error
            print(f"Host unreachable for {device}, retrying...")
            time.sleep(5)  # Wait for 5 seconds before retrying

        if result.returncode != 0:
            print(f"Failed to connect to {device}: {result.stderr}")
            continue

        print(result.stdout)

if __name__ == "__main__":
    cli_arguments = sys.argv # Checking if reboot is in the arguments passed
    reboot = False
    if "reboot" in cli_arguments:
        reboot = True

    ssh_devices = get_ssh_devices()
    found_errors = check_for_error(ssh_devices)
    print(f"Discovered SSH devices:\n{ssh_devices}\n")
    print(f"Device IPs that have errors:\n{found_errors}")

    if reboot:
        reboot_devices(ssh_devices)
    elif found_errors:
        reboot_devices(found_errors)

