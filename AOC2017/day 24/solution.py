import copy
import numpy as np
import math
import string
import re

# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = [s.strip('\n') for s in S]
S = [s.split('/') for s in S]

def serach_max_strength(bridge,S,nodes,max_strength,strength,last):
    for idx in range(len(S)):
        if len(nodes):
            if idx not in nodes:
                if last == S[idx][0]:
                    max_strength = serach_max_strength(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][1])
                elif last == S[idx][1]:
                    max_strength = serach_max_strength(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][0])
        else:
            if 0 == int(S[idx][0]):
                max_strength = serach_max_strength(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][1])
            elif 0 == int(S[idx][1]):
                max_strength = serach_max_strength(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][0])
    if strength > max_strength:
        return strength
    else:
        return max_strength


print('part_1 = ',serach_max_strength([],S,[],0,0,0))

def serach_max_strength_longest(bridge,S,nodes,max_strength,strength,last,max_length):
    for idx in range(len(S)):
        if len(nodes):
            if idx not in nodes:
                if last == S[idx][0]:
                    max_strength,max_length = serach_max_strength_longest(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][1],max_length)
                elif last == S[idx][1]:
                    max_strength,max_length = serach_max_strength_longest(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][0],max_length)
        else:
            if 0 == int(S[idx][0]):
                max_strength,max_length = serach_max_strength_longest(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][1],max_length)
            elif 0 == int(S[idx][1]):
                max_strength,max_length = serach_max_strength_longest(bridge+S[idx],S,nodes+[idx],max_strength,strength+int(S[idx][0])+int(S[idx][1]),S[idx][0],max_length)

    if len(nodes) > max_length:
        max_strength = strength
        max_length = len(nodes)
    elif len(nodes) == max_length:
        if strength > max_strength:
            max_strength = strength
    return max_strength,max_length
p2,_ = serach_max_strength_longest([],S,[],0,0,0,0)
print('part_2 = ',p2)