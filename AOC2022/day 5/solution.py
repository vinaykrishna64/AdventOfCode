import copy
file_name = 'input.txt'

file = open(file_name, 'r')
Lines = file.readlines()
file.close

for i in range(0,len(Lines)):
	if Lines[i] == '\n':
		move_start = i
		break

n_s = int(len(Lines[1])/4) #n_stacks
Stack = []
for i in range(0,n_s):
	Stack.append([])

for i in range(0,move_start-1):
	for j in range(0,n_s):
		if Lines[i][j*4+1] != ' ':
			Stack[j].append(Lines[i][j*4+1])

print(Stack)
Stack_1 = copy.deepcopy(Stack)
Stack_2 = copy.deepcopy(Stack)
for i in range(move_start+1,len(Lines)):
	moveStr = Lines[i].split(' ')
	move = []
	for j in range(0,3):
		move.append(int(moveStr[2*j+1]))
#   part 1
	mv = Stack_1[move[1]-1][:move[0]]
	Stack_1[move[2]-1] = mv[::-1] + Stack_1[move[2]-1]
	del Stack_1[move[1]-1][:move[0]]
#	part 2
	mv = Stack_2[move[1]-1][:move[0]]
	Stack_2[move[2]-1] = mv + Stack_2[move[2]-1]
	del Stack_2[move[1]-1][:move[0]]
	
tp_1 = [] #top strings
tp_2 = []
for i in range(0,n_s):
	tp_1.append(Stack_1[i][0])	
	tp_2.append(Stack_2[i][0])	

print(tp_1)
print(tp_2)