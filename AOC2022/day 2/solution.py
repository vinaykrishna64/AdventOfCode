file_name = 'input.txt'

file = open(file_name, 'r')
Lines = file.readlines()
file.close

P1_dict = {'AX':4 , 'AY':8 , 'AZ':3, 'BX':1 , 'BY':5 , 'BZ':9, 'CX':7 , 'CY':2 , 'CZ':6}
P2_dict = {'AX':3 , 'AY':4 , 'AZ':8, 'BX':1 , 'BY':5 , 'BZ':9, 'CX':2 , 'CY':6 , 'CZ':7}

# part 1
ans = 0
for i in range(0,len(Lines)):
	x = Lines[i].split()
	ans += P1_dict[x[0]+x[1]]

print(ans)

# part 1
ans = 0
for i in range(0,len(Lines)):
	x = Lines[i].split()
	ans += P2_dict[x[0]+x[1]]

print(ans)



