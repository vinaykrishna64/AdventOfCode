import copy
import numpy as np
import math
import string
from sympy import *
import re

# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = [s.strip('\n') for s in S]

S = [re.sub(r'(((p)|(v)|(a))=<)|(>)', '', s).split(',') for s in S]

def move(s,n):
    s_new = [0,0,0,0,0,0,0,0,0]
    d = 0
    for idx in range(3):
        s_new[idx]   = s[idx]   + s[idx+3] *n + s[idx+6] *n*(n-1)*0.5
        s_new[idx+3] = s[idx+3] + s[idx+6] *n
        s_new[idx+6] = s[idx+6]
        d += abs(s_new[idx])
    return d,s_new

t = 100000
D = []
for idx in range(len(S)):
    S[idx] = [int(x) for x in S[idx]]
    d,_ = move(S[idx],10000000000)
    D.append(d)


print('part_1 = ',D.index(min(D)))

def collision_check(S1,S2): # find collsion time between particles, if not return -1
    t = symbols('t')
    eq = []
    for idx in range(3):
        eq.append((S1[idx] -S2[idx])  + (S1[idx+3]-S2[idx+3]) *t + (S1[idx+6]-S2[idx+6]) *t*(t+1)*0.5)
    Sol = solve(eq)
    if Sol:
        T = float(Sol[0][t])
        #T = float(Sol[t])
        if T.is_integer() and T > 0:
            return T
    return -1
def remove_collided(T_col,collided): #clean the collsion time matrix
    collided = sorted(collided, reverse=True)
    for p_i in range(len(T_col)): #remove columns
        for c in collided:
            T_col[p_i].pop(c)
    for c in collided: # remove rows
        T_col.pop(c)
    return T_col



T_col = []
for p_i in range(len(S)):
    temp = []
    #the loops are doing duplicate calculations but we can optimize here
    for p_j in range(p_i+1,len(S)): # find distance from current pos to last pos
        temp.append(collision_check(S[p_i],S[p_j]))
    temp.insert(0,-1) #fill current position with -1
    T_col.append(temp)


for p_i in range(len(S)): #fill missing values
    for p_j in sorted(range(p_i),reverse=True):
        T_col[p_i].insert(0,T_col[p_j][p_i])

last = 1
new = 0
while last != new: # kepp ticking collsions off until no new collsions are found
    last = len(T_col)
    collided = [] 
    min_T = 10000000 
    for p_i in range(len(T_col)-1): 
        for p_j in range(p_i+1,len(T_col)):
            if T_col[p_i][p_j]>0 and T_col[p_i][p_j] < min_T:
                collided = []
                min_T = T_col[p_i][p_j]
                collided.append(p_i)
                collided.append(p_j)
            elif min_T == T_col[p_i][p_j]:
                if p_i not in collided:
                    collided.append(p_i)
                if p_j not in collided:
                    collided.append(p_j)
    if collided:
        remove_collided(T_col,collided)  
    new = len(T_col)

print('part_2 = ',len(T_col))