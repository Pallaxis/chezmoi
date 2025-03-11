#!/usr/bin/env python3

import serial, signal, sys, time, subprocess
from serial import SerialException

# Configure the serial port. Adjust the parameters as necessary
ser = serial.Serial(
    port='/dev/ttyUSB0',
    baudrate=115200,
    timeout=1
)

# traps ctrl c so we can close serial port gracefully
def signal_handler(sig, frame):
    print(f'\nCtrl-C pressed, Closing Serial Port and Exiting...')
    serial.Serial.close(ser)
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

def send_command(command):
    ser.write((command + '\n').encode('utf-8'))
    print(f"Sent command: {command}")
    
def expect_string(expected):
    while True:
        line = ser.readline().decode()
        if expected in line:
            print(line)
            break



while True:
    # skips printing if new line read is the same as previous
    lineprev = ""
    line = ser.readline().decode('utf-8').strip()  # Read a line from the serial port
    if lineprev != line:
        print(f"{line}")
    
    # auto logs in as root
    if "login:" in line:
        send_command("root") 
        time.sleep(5)
        send_command("")
    if "root@Oclea" in line:
        send_command("oclea_gstreamer_interactive_example -r &> /dev/void")
        stream = subprocess.Popen(["ffplay","rtsp://10.71.0.100:8554/test"])
        time.sleep(8)
        subprocess.Popen.terminate(stream)
        send_command("exit")
        send_command("poweroff")
