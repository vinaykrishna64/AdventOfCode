import copy
import numpy as np
import math
import string
from collections import deque


rot = 349 #input
d = deque([0])

for iter in range(1,50000000):
    d.rotate(rot)
    d.appendleft(iter)
    if iter ==2017:
        print('part_1 = ',d[-1])
idx = d.index(0)
print('part_2 = ',d[idx-1])

