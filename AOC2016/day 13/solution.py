import copy
import numpy as np
from matplotlib import pyplot as plt
inpt = 1352 #input, to be added to base equation for wall

def wall(loc):
    [x,y] = loc
    func =  bin(x**2 + 3*x + 2*x*y + y + y**2 + 1352)
    if func.count('1')%2 == 1:
        return 0.5
    else:
        return 0

def crawl(loc,visits,dist=0,m_dist=1000):
    dirs = [[1,0],[0,-1],[0,1],[-1,0]]
    visits[loc[0],loc[1]] = 1
    if loc == [31,39]:
        if dist < m_dist:
            plt.rcParams["figure.figsize"] = [7.50, 3.50]
            plt.rcParams["figure.autolayout"] = True
            plt.gray()
            plt.imshow(visits)
            plt.show()
            return dist
    for i in range(4):
        nxt = [loc[0] + dirs[i][0],loc[1] + dirs[i][1]]
        if nxt[0] >= 0 and nxt[0] >= 1 :
            if visits[nxt[0],nxt[1]] == 0:
                m_dist = crawl(nxt,visits,dist+1,m_dist)
    return m_dist


[sx,sy] = [100,100]
visits = np.zeros((sx,sy))
for i in range(sx):
    for j in range(sy):
        visits[i,j] = wall([i,j])

print(crawl([1,1],visits))