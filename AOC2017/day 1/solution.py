
from collections import deque
import copy
with open("input.txt",'r') as f:
    S = f.readlines()
S = S[0]
d = []
for i in range(len(S)):
    d.append(int(S[i]))
d = deque(d)
s = 0
s2 = 0
l = len(S)//2
for i in range(len(S)):
    if d[0] == d[1]:
        s += d[0]
    if d[0] == d[l]:
        s2 += d[0]
    d.rotate(-1)
print('part_1 =',s)
print('part_2 =',s2)

