import serial
import time

# Configure the serial connection
ser = serial.Serial('/dev/ttyUSB0', 115200, timeout=1)

def send_command(cmd):
    ser.write((cmd + '\r').encode())
    time.sleep(1)

def expect_string(expected):
    while True:
        line = ser.readline().decode()
        print(line)
        if expected in line:
            break

while True:
    # Initial send
    send_command("")
    
    # Expect Oclea login prompt
    expect_string("Oclea login:")
    send_command("root")
    
    # Expect root prompt
    expect_string("[root@Oclea ~]#")
    send_command("clear")
    send_command("")
    
    # Send gstreamer command
    send_command("oclea_gstreamer_interactive_example -r")
    
    # Expect gstreamer prompt
    expect_string(">>>")

ser.close()

