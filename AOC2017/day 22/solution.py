import copy
import numpy as np
import math
import string
from collections import deque

# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = [s.strip('\n') for s in S]




def part_1(S):
    infected = []
    for r in range(len(S)):
        for c in range(len(S[0])):
            if S[r][c] == '#':
                infected.append((r,c))
    p1 = 0
    R = len(S)//2
    C = len(S[0])//2
    d = deque([(-1,0),(0,-1),(1,0),(0,1)]) #directions cycle left of right to simulate turns
    for iter in range(10000):
        if (R,C) in infected:
            d.rotate(1)
            infected.remove((R,C))
        else:
            d.rotate(-1)
            infected.append((R,C))
            p1 += 1
        r,c = d[0]
        R += r
        C += c
    
    print('part_1 = ',p1)


part_1(S)


def part_2(S):
    infected = []
    weakend = []
    flagged = []
    for r in range(len(S)):
        for c in range(len(S[0])):
            if S[r][c] == '#':
                infected.append((r,c))
    p2 = 0
    R = len(S)//2
    C = len(S[0])//2
    d = deque([(-1,0),(0,-1),(1,0),(0,1)]) #directions cycle left of right to simulate turns
    for iter in range(10000000):
        if (R,C) in flagged:
            d.rotate(2)
            flagged.remove((R,C))
        elif (R,C) in infected:
            d.rotate(1)
            infected.remove((R,C))
            flagged.append((R,C))
        elif (R,C) in weakend:
            weakend.remove((R,C))
            infected.append((R,C))
            p2 += 1
        else:
            d.rotate(-1)
            weakend.append((R,C))
        r,c = d[0]
        R += r
        C += c
    
    print('part_2 = ',p2)


part_2(S)