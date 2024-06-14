import copy
import numpy as np
import math
import string
import re

# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = [s.strip('\n') for s in S]
s = S[1].split()
iters = int(s[-2])


## parse states
state_map = dict()

idx = 3

while idx < len(S):
    key = (S[idx][-2],0)
    if len(S[idx+3]) == 33:
        state_map[key] = (int(S[idx+2][-2]),1,S[idx+4][-2]) #right
    else:
        state_map[key] = (int(S[idx+2][-2]),-1,S[idx+4][-2]) #left
    key = (S[idx][-2],1)
    if len(S[idx+7]) == 33:
        state_map[key] = (int(S[idx+6][-2]),1,S[idx+8][-2]) #right
    else:
        state_map[key] = (int(S[idx+6][-2]),-1,S[idx+8][-2]) #left
    idx += 10

iter = 0
state = S[0][-2]
pos = iters
tape = [0]*pos*2
while iter < iters:
    val = state_map[(state,tape[pos])]
    tape[pos] = val[0]
    pos += val[1]
    state = val[2]
    iter += 1

print('part_1 = ',sum(tape))