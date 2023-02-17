
import copy
import numpy as np

with open("input.txt",'r') as f:
    S = f.readlines()

reg = dict()
max_val = 0

for i in range(len(S)):
    s = S[i].replace('\n','').split(' ')
    #init reg
    if s[0] not in reg.keys():
        reg[s[0]] = 0
    if s[4] not in reg.keys():
        reg[s[4]] = 0
    #get inc
    if s[1] == 'dec':
        inc = -1
    elif s[1] == 'inc':
        inc = 1
    #get val
    val = int(s[2])
    x = reg[s[4]]
    if eval(''.join(['x',s[5],s[6]])):
        reg[s[0]] += val*inc
    r = [reg[key] for key in reg.keys()]
    if max(r) > max_val:
        max_val = max(r)
R = [reg[key] for key in reg.keys()]
print('part_1 = ',max(R))
print('part_1 = ',max_val)