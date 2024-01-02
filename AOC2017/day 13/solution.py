
import copy
import numpy as np

with open("input.txt",'r') as f:
    S = f.readlines()

S = [x.replace(':','').replace('\n', '') for x in S]

DR = dict()
for i in range(len(S)):
    s = S[i].split()
    s = [int(x) for x in s]
    DR[s[0]] = s[1]


def scanner(r, t):
    p = t % ((r - 1) * 2)
    return 2 * (r - 1) - p if p > r - 1 else p

def scanner_travel(delay,part12):
    severity = 0
    caughts = 0
    for i in range(max(DR.keys())+1):
        if i in DR.keys():
            if scanner(DR[i], delay+i) == 0:
                severity += i * DR[i]
                caughts += 1
    if part12 == 1:
        return severity
    else:
        return caughts

print('part_1 = ',scanner_travel(0,1))
delay = 1
while scanner_travel(delay,2):
    delay += 1
print('part_2 = ',delay)



