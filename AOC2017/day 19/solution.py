import copy
import numpy as np
import string
from collections import deque
# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = [s.strip('\n') for s in S]
def rcINs(S,r,c):
    return r >=0 and r <len(S) and c >=0 and c <len(S[0])
direcs = ([1,0],[0,1],[0,-1],[-1,0])
symbols = {'|':([1,0],[-1,0]),'-':([0,1],[0,-1])}
symbols_comp = {'-':'|','|':'-'}

def move(S,r,c,pointing,nxt,steps):
    rn,cn = [x+y for x,y in zip(nxt,[r,c])]
    if rcINs(S,rn,cn):
        if S[rn][cn] == pointing or S[rn][cn].isalpha() or S[rn][cn] == symbols_comp[pointing]:
            return rn,cn,pointing,nxt,1,steps+1
        elif S[rn][cn] == '+':
            pointing = symbols_comp[pointing]
            for d in symbols[pointing]:
                rnn,cnn = [x+y for x,y in zip(d,[rn,cn])]
                if rcINs(S,rnn,cnn) and (S[rnn][cnn] == pointing or S[rnn][cnn].isalpha()):
                    nxt = d
                    return rnn,cnn,pointing,nxt,1,steps+2
    return r,c,pointing,nxt,0,steps

r = 0
c = S[0].index('|')
nxt = [1,0]
pointing = '|'
moving = 1
nodes = []
steps = 1
while moving:
    r,c,pointing,nxt,moving,steps = move(S,r,c,pointing,nxt,steps)
    if S[r][c].isalpha() and moving:
        nodes.append(S[r][c])
print('part_1 = ',''.join(nodes))

print('part_2 = ',steps)