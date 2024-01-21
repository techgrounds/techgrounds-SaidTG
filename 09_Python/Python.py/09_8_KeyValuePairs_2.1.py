
# define dictionary
userinfo = {}

# ask user for info
firstName = input("Enter first name: ")
lastName = input("Enter last name: ")
jobTitle = input("Enter job title: ")
company = input("Enter company: ")

# store info in dictionary "userinfo"
userinfo['First name'] = firstName
userinfo["Last name"] = lastName
userinfo["Job title"] = jobTitle
userinfo["Company"] = company

print(userinfo)