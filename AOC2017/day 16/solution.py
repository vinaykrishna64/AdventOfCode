
import copy
import numpy as np
import string
from collections import deque
# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = S[0].split(",")

P = deque(string.ascii_lowercase[:16]) 
P_start = deque(string.ascii_lowercase[:16]) 


def part_1(P,S):
    for s in S:    
        if s[0] == 's':
            P.rotate(int(s[1:]))
        elif s[0] == 'x':
            a,b =  list(map(int,s[1:].split("/")))
            P[a],P[b] = P[b],P[a]
        elif s[0] == 'p':
            a = P.index(s[1])
            b = P.index(s[3])
            P[a],P[b] = P[b],P[a]
    return P

part_1(P,S)
print('part_1 = ',''.join(P))
i = 1
while ''.join(P) != ''.join(P_start):
    part_1(P,S)
    i += 1

n = 1000000000
n_effective = n%i
for idx in range(n_effective):
    part_1(P,S)
print('part_2 = ',''.join(P))



