
import copy
import numpy as np
with open("input.txt",'r') as f:
    S = f.readlines()

n_test = 100000
data = np.zeros((16,n_test))
s = S[0].replace('\n','').split('\t')
for i in range(16):
    data[i,0] = int(s[i])

def shape_check(data):
    s1 = np.unique(data, axis=1).shape 
    s2 = data.shape
    if s1[1] != s2[1]:
        return 1
    return 0
for i in range(n_test-1):
    r = np.where(data[:,i] == np.amax(data[:,i], axis=0))
    r = r[0][0]
    val = data[r,i]
    data[:,i+1] = data[:,i]
    data[r,i+1] = 0
    while val != 0:
        r += 1
        if r == 16:
            r = 0
        data[r,i+1] += 1
        val -= 1
    if shape_check(data[:,0:i+2]):
        print('part_1 = ',i+1)
        target_col = data[:,i+1]
        Second = i+1
        while not np.all(target_col == data[:,i-1]):
            i -= 1
        First = i
        print('part_2 = ',Second - First + 1)
        break

