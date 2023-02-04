import copy
import re

with open("input.txt",'r') as f:
    S = f.readlines()

gear = []
for i in range(len(S)):
    s = re.findall(r'[0-9]+',S[i])
    gear.append([int(s[1]),int(s[-1])])

def slot(t,N,I):
    if (I + t)%N == 0:
        return True
    else:
        return False

t = 0
while True:
    align = 0
    for i in range(len(gear)):
        if slot(t+i,gear[i][0],gear[i][1]):
            align += 1
    if align == len(gear):
        break

    t += 1

print('part_1 = ',t-1)


gear.append([11,0])
t = 0
while True:
    align = 0
    for i in range(len(gear)):
        if slot(t+i,gear[i][0],gear[i][1]):
            align += 1
    if align == len(gear):
        break

    t += 1

print('part_2 = ',t-1)