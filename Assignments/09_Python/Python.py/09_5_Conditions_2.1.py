
# ask user to input number
num = float(input("Enter a number: "))

if num < 100:
    # if input number is lower than 100
    print("Too low")
elif num == 100:
    # if input number is  100
    print("Perfect!")
else:
    # if input number is higher than 100
    print("Too high")