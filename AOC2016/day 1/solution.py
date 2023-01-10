
from collections import deque
import copy
with open("input.txt",'r') as f:
    S = f.readlines()
S = S[0].split(',')

pos = [0, 0];
d = deque([[0,1],[1,0],[0,-1],[-1,0]])
cache = []
seen = 0
for i in range(0,len(S)):
    s = S[i].strip()
    if s[0] == "R":
        d.rotate(-1) 
    else:
        d.rotate(1)  
    if not seen:
        P = pos.copy();
        for k in range(int(s[1:])):
            for j in range(2):
                P[j] += d[0][j]
            cache.append(P.copy())
            if not seen:
                for kk in range(len(cache)-1):
                    if cache[kk] == cache[-1]:
                        print('part_2 =',abs(cache[kk][0])+abs(cache[kk][1]))
                        seen = 1
                        break
    for j in range(0,2):
        pos[j] += d[0][j]* int(s[1:])
    
print('part_1 =',abs(pos[0])+abs(pos[1]))

