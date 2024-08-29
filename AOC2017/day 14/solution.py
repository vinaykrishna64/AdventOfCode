
def knothash_day10(input):
    s = [ord(x) for x in input]
    add_l = [17, 31, 73, 47, 23]
    [s.append(x) for x in add_l]
    skp = 0
    crnt = 0
    L = [i for i in range(256)]
    for rnds in range(64):
        for i in range(len(s)): 
            r = s[i]
            if r > 1:
                L = L[crnt:] + L[:crnt]  
                L[0:r] = L[r-1::-1] #step 1
                L = L[-crnt:] + L[:-crnt]  
            mv = (skp + r)%len(L)
            crnt = (crnt + mv)%len(L) #step 2
            skp += 1 #step 3
    def bitor_16(l):
        out = l[0]
        for i in range(1,16):
            out ^= l[i]
        return out
    reduce = []
    for i in range(16):
        Op = 16*(i)
        Cl = 16*(i+1)
        reduce.append(bitor_16(L[Op:Cl]))
    return ''.join('%02x'%x for x in reduce)

# 
def knotchar2bin(x):
    b = bin(int(x,16))[2:] 
    b = (4-len(b))*'0' + b
    return b
import numpy as np
from scipy.ndimage import label
input = 'xlqgujun'
rows = []
C = 0
for idx in range(128):
    s = knothash_day10(f'{input}-{idx}')
    s = (32-len(s))*'0' + s
    st = ''.join(knotchar2bin(x) for x in s)
    st += (128-len(st))*'0'
    rows.append([int(x) for x in st])
    C += st.count('1')
print('part_1 = ',C)

# #
img =  np.zeros((128,128))
for idx in range(128):
    for jdx in range(128):
        img[idx][jdx] = rows[idx][jdx]
print('part_2 = ',label(img)[1])
np.savetxt('test.txt',img, delimiter='',fmt='%d')







