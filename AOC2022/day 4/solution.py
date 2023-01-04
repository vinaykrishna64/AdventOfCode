

file_name = 'input.txt'

file = open(file_name, 'r')
Lines = file.readlines()
file.close

def is_contains(S,flg =1):
	A = []
	for i in range(0,2):
		A.append( [int(x) for x in S[i].split('-')])
	
	if flg == 1:
		return ((A[0][0] <= A[1][0]) and (A[0][1] >= A[1][1])) or ((A[1][0] <= A[0][0]) and (A[1][1] >= A[0][1]))
	else:
		if A[1][1] >= A[0][1]:
			return A[0][1] >= A[1][0]
		else:
			return A[1][1] >= A[0][0]
total = 0

for i in range(0,len(Lines)):
	if i < (len(Lines)-1):
		S = Lines[i][:-1].split(',')
	else:
		S = Lines[i][:].split(',')
	if is_contains(S):
		total += 1

print(total)

total = 0
for i in range(0,len(Lines)):
	if i < (len(Lines)-1):
		S = Lines[i][:-1].split(',')
	else:
		S = Lines[i][:].split(',')
	if is_contains(S,2):
		total += 1

print(total)

