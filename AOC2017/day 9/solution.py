
import copy
import numpy as np

with open("input.txt",'r') as f:
    S = f.readlines()

s = S[0]

def reduce2groups(s):
    garbage_count = 0
    #remove escaped characters
    s_r = []
    i = 0
    while i < len(s):
        if s[i] != '!':
            s_r.append(s[i])
            i += 1
        else:
            i += 2
    s_r = ''.join(s_r)
    #remove garbage
    skp_flg = 0
    s_g = []
    i = 0
    while i < len(s_r):
        if skp_flg == 0:
            if s_r[i] != '<':
                s_g.append(s_r[i])
            else:
                skp_flg = 1
        else:
            if s_r[i] == '>':
                skp_flg = 0
            else:
                garbage_count += 1
        i += 1

    groups = ''.join(s_g)
    groups = groups.replace(',','')
    return groups,garbage_count
    
G,garbage_count = reduce2groups(s)
lvl = 1
score = 0
op = [0]
cl = []
opens = 0
while len(G) > 0:
    for i in range(1,len(G)):
        if G[i] == '{':
            opens += 1
        elif G[i] == '}':
            if opens == 0:
                cl.append(i)
                if i+1 < len(G):
                    op.append(i+1)
                opens = -1
            else:
                opens -= 1
    g = []     
    for j in range(len(op)):
        g += G[op[j]+1:cl[j]]
        score += lvl
    lvl += 1
    op = [0]
    cl = []
    opens = 0
    G = ''.join(g)


print('part_1 =',score)
print('part_2 = ',garbage_count)