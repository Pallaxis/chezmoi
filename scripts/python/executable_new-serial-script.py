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

        try:
            line = ser.readline().decode('utf-8')
            if expected in line:
                print(line)
                break
        except:
            print("error mfer")

def wait_for_prompt():
    line = ser.readline().decode('utf-8')
    output = ""
    output += line
    while "root@Oclea" not in line:
        print(line)
        output += line
        line = ser.readline().decode('utf-8')



while True:
    print("waiting for login:")
    expect_string("login:")
    print("sending command root:")
    send_command("root") 

    expect_string("root@Oclea")
    send_command("oclea_info")
    wait_for_prompt()
    send_command("x cert probe")
    wait_for_prompt()
    send_command("x cert verify")
    wait_for_prompt()
    send_command("x manifest")
    wait_for_prompt()
    #stream = subprocess.Popen(["ffplay","rtsp://10.71.0.100:8554/test"])
    #time.sleep(8)
    #subprocess.Popen.terminate(stream)
    #send_command("exit")
    #send_command("poweroff")
