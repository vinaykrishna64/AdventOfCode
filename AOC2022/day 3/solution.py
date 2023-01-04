import string

keys = list(string.ascii_letters)
values = range(1,53)
dict_map = dict(zip(keys, values))


file_name = 'input.txt'

file = open(file_name, 'r')
Lines = file.readlines()
file.close

total = 0
for i in range(0,len(Lines)):
	n = int(len(Lines[i])/2)
	list1 = set(Lines[i][0:n])
	list2 = set(Lines[i][n:])
	common_elements = list(set(list1).intersection(list2))
	total += dict_map[common_elements[0]]


print(total)


total = 0
n = int(len(Lines)/3)
for i in range(0,n):
	list1 = set(Lines[3*i][:-1])
	list2 = set(Lines[3*i+1][:-1])
	if i < (n-1):
		list3 = set(Lines[3*i+2][:-1])
	else:
		list3 = set(Lines[3*i+2][:])
	common_elements = list(set(list1).intersection(list2,list3))
	total += dict_map[common_elements[0]]


print(total)