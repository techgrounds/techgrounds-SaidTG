
# ask user for input number
num = float(input("Enter a number: "))

while num != 100:
    # while input number is not 100
    print("Entered number is not 100.")
    # input a number again
    num = float(input("Enter a number: "))

else:
    # when input number is 100
    print("Perfect!")