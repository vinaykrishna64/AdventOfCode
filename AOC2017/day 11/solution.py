
import copy
import numpy as np

with open("input.txt",'r') as f:
    S = f.readlines()

s = S[0].split(',')
def dist(Loc):
    Loc = [abs(x) for x in Loc]
    d = Loc[0]/2 + Loc[1]/2
    return d
Loc = [0,0]
max_d = 0
for i in range(len(s)):
    if s[i] == 'nw':
        Loc[0] += -1
        Loc[1] += -1
    elif s[i] == 'n':
        Loc[0] += -2
        Loc[1] += 0
    elif s[i] == 'ne':
        Loc[0] += -1
        Loc[1] += 1
    elif s[i] == 'sw':
        Loc[0] += 1
        Loc[1] += -1
    elif s[i] == 's':
        Loc[0] += 2
        Loc[1] += 0
    elif s[i] == 'se':
        Loc[0] += 1
        Loc[1] += 1 
    if dist(Loc) > max_d:
        max_d = dist(Loc)

print('part_1 = ',dist(Loc))
print('part_2 = ',max_d)


