
import csv
from csv import DictWriter

userdetails = ["first name", "last name", "job title", "company"]

userinfo = {
}

print(" Enter first name: ")
userinfo.update({"First name: ":input()})

print(" Enter last name: ")
userinfo.update({" Last name: ":input()})

print(" Enter job title: ")
userinfo.update({" Job title: ":input()})

print(" Enter company: ")
userinfo.update({" Company: ":input()})

with open('userinfo.csv', 'a') as csvfile:
    writer = csv.DictWriter(csvfile, userinfo)
    writer.writeheader()
    writer.writerow(userinfo)
    csvfile.close()
