
import copy
from collections import deque
import numpy as np

inpt = 289326

def Circular_IDX2dist(I):
    i = 1
    while i**2 <= I:
        i += 2
    i -= 2
    lvl = i//2
    if i**2 == I:
        d = 2*lvl
        r = lvl
        c = lvl
        return d,r,c
    else:
        d = 2*(lvl+1)+1
        q = []
        for i in range(lvl+2):
            d -= 1
            q.append(d)
        for i in range(lvl):
            d += 1
            q.append(d)
        q = deque(q)
        I = I - (2*lvl+1)**2
        r = lvl+1 
        c = lvl+1
        for i in range(I):
            q.rotate(-1)
            if i < 2*(lvl+1):
                r -= 1
            elif i >= 2*(lvl+1) and i < 4*(lvl+1):
                c -= 1
            elif i >= 4*(lvl+1) and i < 6*(lvl+1):
                r += 1
            elif i >= 6*(lvl+1) and i < 8*(lvl+1):   
                c += 1 
        return q[0],r,c

p1,r1,c1 = Circular_IDX2dist(inpt)
print('part_1 = ',p1)


data = np.zeros((50,50)) #store data at n,n offset to make life easy
p,r,c = Circular_IDX2dist(1)
n = 6
data[r+n,c+n] = 1
current_val = 1
IDX = 1
while current_val < inpt:
    IDX += 1
    p,r,c = Circular_IDX2dist(IDX)
    current_val = sum(sum(data[r+(n-1):r+(n+2),c+(n-1):c+(n+2)]))
    data[r+n,c+n] = current_val
    
print('part_2 = ',int(current_val))


