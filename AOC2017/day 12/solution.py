
import copy
import numpy as np

with open("input.txt",'r') as f:
    S = f.readlines()

S = [x.replace('<->','').replace('\n', '').replace(',', ' ') for x in S]

M = dict()
for i in range(len(S)):
    s = S[i].split()
    M[int(s[0])] = [int(x) for x in s[1:]]

def find_group(gp): #populate a group from selected node by accumulating each connection
    progs = [gp]
    def append_prog(p,progs):
        if p not in progs:
            return progs.append(p)
        else:
            return progs

    while True:
        L = len(progs)
        for x in progs:
            for p in M[x]:
                append_prog(p,progs)
        if L == len(progs):
            break
    progs.sort() #sort is required for part 2
    return progs

groups = {0 : find_group(0)}
for key in M.keys():
    G = find_group(key)
    if G not in groups.values():
        groups[key] = G

print('part_1 = ',len(groups[0]))

print('part_2 = ',len(groups.keys()))


