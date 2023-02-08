import copy
import re

with open("input.txt",'r') as f:
    S = f.readlines()


Op = []
Cl = []
for i in range(len(S)):
    s = re.findall(r'[0-9]+',S[i])
    Op.append(int(s[0]))
    Cl.append(int(s[1]))

sort_index = [i for i, x in sorted(enumerate(Op), key=lambda x: x[1])]
Op.sort()

Cl2 = []
for i in range(len(sort_index)):
    Cl2.append(Cl[sort_index[i]])

def compress_lmts(Op,Cl):
    Op1 = [0]
    Cl1 = []
    cl_trk = Cl[0]
    for i in range(len(Op)-1):
        if cl_trk+1 >= Op[i+1] and cl_trk >= Cl[i+1]:
            continue
        elif cl_trk+1 >= Op[i+1] and cl_trk < Cl[i+1]:
            cl_trk = Cl[i+1]
        else:
            Cl1.append(cl_trk)
            Op1.append(Op[i+1])
            cl_trk = Cl[i+1]
            
    
    Cl1.append(Cl[-1])
    return Op1,Cl1
[op,cl] = compress_lmts(Op,Cl2)

print('part_1 = ', cl[0]+1)

count = 0
for i in range(len(op)-1):
    count += op[i+1] - cl[i] -1

print('part_2 = ',count)