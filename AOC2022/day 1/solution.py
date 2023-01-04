file_name = 'input.txt'

file = open(file_name, 'r')
Lines = file.readlines()
file.close


cal = []
sum = 0
for i in range(0,len(Lines)-1):
	if not Lines[i].isspace():
		sum = sum + int(Lines[i])
	else:
		cal.append(sum)
		sum = 0

cal.sort(reverse=True)
print(cal[0])
sum = 0
for i in range(3):
	sum = sum + cal[i]

print(sum)