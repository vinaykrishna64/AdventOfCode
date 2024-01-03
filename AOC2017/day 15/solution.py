
import copy
import numpy as np

with open("input.txt",'r') as f:
    S = f.readlines()

AB = []
for i in range(len(S)):
    s = S[i].split(' ')
    AB.append(int(s[-1]))
AB2 = AB.copy()
def fa(x, m =16807,d = 2147483647):
    return x*m % d
def fb(x, m =48271,d = 2147483647):
    return x*m % d

def decimalToBinary(n):
    #32-bit binary
    B = bin(n)[2:]
    z = 32 - len(B)
    B = '0'*z + B
    return B

count = 0

for i in range(40*10**6):
    AB[0] = fa(AB[0])
    AB[1] = fb(AB[1])
    if decimalToBinary(AB[0])[-16:] == decimalToBinary(AB[1])[-16:]:
        count += 1

count2 = 0

for i in range(5*10**6):
    while True  :
        AB2[0] = fa(AB2[0])
        if AB2[0]%4 == 0:
            break
    while True  :
        AB2[1] = fb(AB2[1])
        if AB2[1]%8 == 0:
            break        
    if decimalToBinary(AB2[0])[-16:] == decimalToBinary(AB2[1])[-16:]:
        count2 += 1
print('part_1 = ',count)

print('part_2 = ',count2)



