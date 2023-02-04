import hashlib
import copy
import re
inpt = 'pgflpeqp' #puzzle input


def get_wall(str2hash):
    # str2hash = ''.join([inpt, str(idx)])
    result = hashlib.md5(str2hash.encode())
    hsh_hex = result.hexdigest() 
    wall = [1,1,1,1]
    for i in range(4):
        if hsh_hex[i] in ['b', 'c', 'd','e', 'f']:
            wall[i] = 0

    return wall


def search(loc,goal,sz,dist,min_dist,min_hsh,str2hash):
    if dist > min_dist:
        return min_dist,min_hsh 
    if loc[0] == goal[0] and loc[1] == goal[1]:
        if min_dist > dist:
            return dist,str2hash
        else:
            return min_dist,min_hsh
    wall = get_wall(str2hash)
    dirs = [[-1,0],[1,0],[0,-1],[0,1]] #UDLR
    s = 'UDLR'
    for i in range(4):
        nxt = [loc[0]+dirs[i][0],loc[1]+dirs[i][1]]
        if nxt[0] >= 0 and nxt[1] >= 0 and nxt[0] < sz[0] and nxt[1] < sz[1] :
            if wall[i] == 0:
                [min_dist,min_hsh] = search(nxt,goal,sz,dist+1,min_dist,min_hsh,str2hash+s[i])
    return min_dist,min_hsh
    
   
[min_dst,min_hsh] = search([0,0],[3,3],[4,4],0,1000,inpt,inpt)
print('part_1 = ',min_hsh[len(inpt):])



def search_max(loc,goal,sz,dist,max_dist,max_hsh,str2hash):

    if loc[0] == goal[0] and loc[1] == goal[1]:
        if max_dist < dist:
            return dist,str2hash
        else:
            return max_dist,max_hsh
    wall = get_wall(str2hash)
    dirs = [[-1,0],[1,0],[0,-1],[0,1]] #UDLR
    s = 'UDLR'
    for i in range(4):
        nxt = [loc[0]+dirs[i][0],loc[1]+dirs[i][1]]
        if nxt[0] >= 0 and nxt[1] >= 0 and nxt[0] < sz[0] and nxt[1] < sz[1] :
            if wall[i] == 0:
                [max_dist,max_hsh] = search_max(nxt,goal,sz,dist+1,max_dist,max_hsh,str2hash+s[i])
    return max_dist,max_hsh

[max_dist,max_hsh] = search_max([0,0],[3,3],[4,4],0,0,inpt,inpt)
print('part_2 = ',max_dist)