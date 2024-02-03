
integers = [1, 3, 5, 7, 9]

for i in range(len(integers)):
   
    if i != (len(integers) - 1):
        print(integers[i]+integers[i+1])
    
    else:
        print(integers[i]+integers[i-i])