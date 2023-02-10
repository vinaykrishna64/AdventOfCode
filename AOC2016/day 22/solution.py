import copy
import numpy as np
from queue import PriorityQueue

with open("input.txt",'r') as f:
    S = f.readlines()

global Used,Avail,Size
Size = np.zeros((27,37))
Used = np.zeros((27,37))
Avail = np.zeros((27,37))
Use = np.zeros((27,37))
for i in range(2,len(S)):
    s = S[i].split(' ')
    s = [x for x in s if x != '']
    s1 = s[0].split('-')
    Size[int(s1[2][1:]),int(s1[1][1:])] = int(s[1][0:s[1].index('T')])
    Used[int(s1[2][1:]),int(s1[1][1:])] = int(s[2][0:s[2].index('T')])
    Avail[int(s1[2][1:]),int(s1[1][1:])] = int(s[3][0:s[3].index('T')])
    Use[int(s1[2][1:]),int(s1[1][1:])] = int(s[4][0:s[4].index('%')])





def LIDX2RC(I):
    sz = [27,37]
    r = I//sz[1]
    c = I - sz[1]*r
    return r,c

count = 0
for I in range(999):
    [r1,c1] = LIDX2RC(I)
    for J in range(I+1,999):
        [r2,c2] = LIDX2RC(J)
        if  Used[r1,c1] > 0 and Used[r1,c1] <=  Avail[r2,c2]:
            count += 1
        if Used[r2,c2]>0 and Used[r2,c2] <=  Avail[r1,c1]:
            count += 1

print('part_1 = ',count)



def man_dist(loc,goal):
    return abs(loc[0]-goal[0]) + abs(loc[1]-goal[1])
def in_maze(loc,sz):
    if loc[0] >= 0 and loc[1] >= 0 and loc[0] < sz[0] and loc[1] < sz[1]:
        return 1
    else:
        return 0
def swappable(Loc,nxt_Loc): #Check if next_Lock can be emptied into current Loc
    return Size[Loc[0],Loc[1]] >= Used[nxt_Loc[0],nxt_Loc[1]]
def skip_pkt(Pkt_loc,nxt_Loc): #for A8 to skip packet location
    return nxt_Loc[0] == Pkt_loc[0] and nxt_Loc[1] == Pkt_loc[1]
def A_star(start,goal,sz,Pkt_loc):
    g_cost = np.zeros((sz[0],sz[1]))
    f_cost = np.zeros((sz[0],sz[1]))
    for i in range(sz[0]):
        for j in range(sz[1]):
            g_cost[i,j] = float('inf')
            f_cost[i,j] = float('inf')
    g_cost[start[0],start[1]] = 0
    f_cost[start[0],start[1]] = man_dist(start,goal)
    dirs = [[-1,0],[0,1],[1,0],[0,-1]]
    open = PriorityQueue()
    open.put((f_cost[start[0],start[1]],man_dist(start,goal),start))
    rvs_path = {}
    while not open.empty(): #this checks for no path
        Loc = open.get()[2]
        if Loc[0] == goal[0] and Loc[1] == goal[1]:
            break
        for i in range(4):
            nxt_Loc = [Loc[0]+dirs[i][0],Loc[1]+dirs[i][1]]
            if  in_maze(nxt_Loc,sz) == 1 and swappable(Loc,nxt_Loc) and (not skip_pkt(Pkt_loc,nxt_Loc)):
                temp_gC = g_cost[Loc[0],Loc[1]] + 1
                temp_fC = temp_gC  + man_dist(nxt_Loc,goal)
                if temp_fC < f_cost[nxt_Loc[0],nxt_Loc[1]]:
                    g_cost[nxt_Loc[0],nxt_Loc[1]] = temp_gC
                    f_cost[nxt_Loc[0],nxt_Loc[1]] = temp_fC
                    open.put((temp_fC,man_dist(nxt_Loc,goal),nxt_Loc))
                    rvs_path[tuple(nxt_Loc)] = tuple(Loc)
    fwd_path = {}
    try:
        key = tuple(goal)
        while key!=tuple(start):
            fwd_path[rvs_path[key]] = key
            key = rvs_path[key]
    except:
        pass
    return len(fwd_path)

def Search_min(Loc,Goal,Empty,pkt,steps,min_steps,sz,Track):
    if steps >= min_steps:
        return min_steps
    if Loc[0] == Goal[0] and Loc[1] == Goal[1]:
        if steps < min_steps:
            return steps
        return min_steps
    dirs = [[0,-1],[1,0],[0,1],[-1,0]]
    for i in range(4):
        nxt_Loc = [Loc[0]+dirs[i][0],Loc[1]+dirs[i][1]]
        if  in_maze(nxt_Loc,sz) == 1 and pkt <= Size[nxt_Loc[0],nxt_Loc[1]] and Track[nxt_Loc[0],nxt_Loc[1]] == 0:
            em_step = A_star(Empty,nxt_Loc,sz,Loc)
            if em_step > 0:
                T = Track.copy()
                T[nxt_Loc[0],nxt_Loc[1]] = 1
                min_steps = Search_min(nxt_Loc,Goal,Loc,pkt,steps+1+em_step,min_steps,sz,T)
    return min_steps

#find empty
for I in range(999):
    [r1,c1] = LIDX2RC(I)
    if Used[r1,c1] == 0:
        Empty = [r1,c1]
        break




Start = [0,36]
Goal = [0,0]
pkt = Used[0,36]#packet size
Track = np.zeros((27,37))
Track[0,36] = 1
print('part_2 = ',Search_min(Start,Goal,Empty,pkt,0,10000,[27,37],Track))
