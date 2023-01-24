
import copy
import numpy as np
from matplotlib import pyplot as plt

with open("input.txt",'r') as f:
    S = f.readlines()



Screen = np.zeros((6,50), dtype=int)


for i in range(len(S)):
    s = S[i].split()
    if s[0] == 'rect':
        [r, c]= s[1].split('x')
        Screen[0:int(c),0:int(r)] = 1
    else:
        [xy,A] = s[2].split('=')
        B = s[4]
        if xy == 'y':
            Screen[int(A),:] = np.roll(Screen[int(A), :], int(B))
        elif xy == 'x':
            Screen[:,int(A)] = np.roll(Screen[:,int(A)], int(B))
    
    
print('part_1 = ',np.sum(Screen))


plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True

plt.gray()
plt.imshow(Screen)

plt.show()