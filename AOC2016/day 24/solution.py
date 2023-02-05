import copy
import numpy as np
from queue import PriorityQueue

with open("input.txt",'r') as f:
    S = f.readlines()


[sx,sy] = [len(S),len(S[-1])]
maze = np.zeros((sx,sy))
P = [[]]*8
track = [0]*8

for i in range(len(S)):
    for j in range(len(S[i])):
        s = S[i][j]
        if s == '.':
            maze[i,j] = 0
        elif s == '#':
            maze[i,j] = 1
        elif s.isnumeric():
            maze[i,j] = 0
            P[int(s)] = [i,j]
def man_dist(loc,goal):
    return abs(loc[0]-goal[0]) + abs(loc[1]-goal[1])
def in_maze(loc,sz):
    if loc[0] >= 0 and loc[1] >= 0 and loc[0] < sz[0] and loc[1] < sz[1]:
        return 1
    else:
        return 0
def A_star(start,goal,maze,sz):
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
            if  in_maze(nxt_Loc,sz) == 1 and maze[nxt_Loc[0],nxt_Loc[1]] == 0 :
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



def search_min(loc,P,maze,track,min_d,d,sz,min_d2):
    if sum(track) == 8:
        d2 = d + A_star(loc,P[0],maze,sz)
        if d < min_d and d2 < min_d2:
            return d,d2
        elif d >= min_d and d2 < min_d2:
            return min_d,d2
        elif d < min_d and d2 >= min_d2:
            return d,min_d2
        else:
            return min_d,min_d2
    for i in range(8):
        if track[i] == 0:
            T = track.copy()
            T[i] = 1
            [min_d,min_d2] = search_min(P[i],P,maze,T,min_d,d + A_star(loc,P[i],maze,sz),sz,min_d2)
    return min_d,min_d2

track[0] = 1
loc = P[0]
[min_d,min_d2] = search_min(loc,P,maze,track,100000,0,[sx,sy],100000)
print('part_1 = ',min_d)
print('part_2 = ',min_d2)