import copy
import numpy as np
from queue import PriorityQueue
inpt = 1352 #input, to be added to base equation for wall

def wall(loc):
    [x,y] = loc
    func =  bin(x**2 + 3*x + 2*x*y + y + y**2 + 1352)
    if func.count('1')%2 == 1:
        return 1
    else:
        return 0
def man_dist(loc,goal):
    return abs(loc[0]-goal[0]) + abs(loc[1]-goal[1])
def in_maze(loc,sz):
    if loc[0] >= 0 and loc[1] >= 0 and loc[0] < sz[0] and loc[1] < sz[1]:
        return 1
    else:
        return 0
[sx,sy] = [100,100]

maze = np.zeros((sx,sy))


for i in range(sx):
    for j in range(sy):
        maze[i,j] = wall([i,j])

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

start = [1,1]
goal = [31,39]
print('part_1 = ',A_star(start,goal,maze,[sx,sy]))


count = 1 #include start

for i in range(sx):
    for j in range(sy):
        dist = A_star(start,[i,j],maze,[sx,sy])
        if dist > 0 and dist <= 50:
            count += 1

print('part_2 = ',count)






