#!/usr/bin/env python3

print("Enter number to Calc (Short for Calculator)")
while True:
    first_number = input("First number: ")
    try:
        value = int(first_number)
    except:
        print("Input must be a number")
    else:
        break

while True:
    symbols = ['+', '-', '*', '/']
    print("What operation would you like to perform?")
    print("""+
-
*
/
        """)
    operator = input("Choice:")

    if operator in symbols:
        break

while True:
    second_number = input(f"{first_number} {operator} ")
    try:
        value = int(second_number)
    except:
        print("Input must be a number")
    else:
        break

output = first_number + operator + second_number
print(eval(output)) # very quick and dirty
