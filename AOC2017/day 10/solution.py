
import copy
import numpy as np

with open("input.txt",'r') as f:
    S = f.readlines()

s = S[0].split(',')
s = [int(x) for x in s]

L = [i for i in range(256)]
skp = 0
crnt = 0
for i in range(len(s)): 
    r = s[i]
    if r > 1:
        L = L[crnt:] + L[:crnt]  
        L[0:r] = L[r-1::-1] #step 1
        L = L[-crnt:] + L[:-crnt]  
    mv = (skp + r)%len(L)
    crnt = (crnt + mv)%len(L) #step 2
    skp += 1 #step 3
print('part_1 =', L[0]*L[1])

## part 2
s = [ord(x) for x in S[0]]
add_l = [17, 31, 73, 47, 23]
[s.append(x) for x in add_l]
skp = 0
crnt = 0
L = [i for i in range(256)]
for rnds in range(64):
    for i in range(len(s)): 
        r = s[i]
        if r > 1:
            L = L[crnt:] + L[:crnt]  
            L[0:r] = L[r-1::-1] #step 1
            L = L[-crnt:] + L[:-crnt]  
        mv = (skp + r)%len(L)
        crnt = (crnt + mv)%len(L) #step 2
        skp += 1 #step 3
def bitor_16(l):
    out = l[0]
    for i in range(1,16):
        out ^= l[i]
    return out
reduce = []
for i in range(16):
    Op = 16*(i)
    Cl = 16*(i+1)
    reduce.append(bitor_16(L[Op:Cl]))
hx = [hex(i) for i in reduce]
hx = [x[2:] for x in hx]
print(hx)
hx = [x if len(x)==2 else ''.join(['0',x]) for x in hx]
print('part_2 =',''.join(hx))