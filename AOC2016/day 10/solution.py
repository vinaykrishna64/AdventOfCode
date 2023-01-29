import copy
import re

with open("input.txt",'r') as f:
    S = f.readlines()

def add_val2bot(bots,n,v):
    temp = bots[n]       
    if temp == []:
        temp = [v]
        bots[n] = temp
    else:
        temp.append(v)
        bots[n] = temp
    return bots

    
def check_l(bots):
    for i in range(len(bots)):
        if len(bots[i]) == 2:
            return 1
    return 0


keys = []
vals = []
bots = [[]]*250


for i in range(len(S)):
    numbers = re.findall('[0-9]+', S[i])
    if len(numbers) == 3:
        keys.append(int(numbers[0]))
        vals.append([int(x) for x in numbers[1:]])
    else:
        bots = add_val2bot(bots,int(numbers[1]),int(numbers[0])) 
        
        

rules = dict(zip(keys,vals)) 


first = 0

while check_l(bots):
    comp = []
    for i in range(len(bots)):
        if len(bots[i]) == 2:    
            dest = rules[i]
            comp = bots[i]
            if len(bots[dest[0]]) < 2 and len(bots[dest[1]]) < 2:
                if bots[i][0] < bots[i][1]:
                    bots = add_val2bot(bots,dest[0],bots[i][0])
                    bots = add_val2bot(bots,dest[1],bots[i][1])
                else:
                    bots = add_val2bot(bots,dest[0],bots[i][1])
                    bots = add_val2bot(bots,dest[1],bots[i][0])
                bots[i] = []
                if (comp == [61,17] or comp == [17,61]) and first == 0:
                    first = 1
                    print('part_1 = ',i)
            
            

p2 = 1
for i in range(3):
    p2 *= bots[i][0]
print('part_2 = ',p2) 




