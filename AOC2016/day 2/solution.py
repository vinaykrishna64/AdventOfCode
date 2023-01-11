
from collections import deque
import copy
with open("input.txt",'r') as f:
    S = f.readlines()

G = [[1,2,3],[4,5,6],[7,8,9]]
P = []
r = 1
c = 1
for i in range(len(S)):
    for j in range(len(S[i])):
        if S[i][j] == 'U':
            r+= -1
        elif S[i][j] == 'D':
            r+= 1
        elif S[i][j] == 'R':
            c+= 1
        elif S[i][j] == 'L':
            c+= -1
        if c == -1:
            c = 0
        elif r == -1:
            r = 0
        elif r == 3:
            r = 2
        elif c == 3:
            c = 2
    P.append(G[r][c])

print('part_1 =',''.join(str(x) for x in P))





G = [['','','','','','',''],
     ['','','','1','','',''],
     ['','','2','3','4','',''],
     ['','5','6','7','8','9',''],
     ['','','A','B','C','',''],
     ['','','','D','','',''],
     ['','','','','','','']]

P = []
r = 3
c = 1
for i in range(len(S)):
    for j in range(len(S[i])):
        if S[i][j] == 'U':
            if G[r - 1][c] != '':
                r+= -1 
        elif S[i][j] == 'D':
            if G[r + 1][c] != '':
                r+= 1
        elif S[i][j] == 'R':
            if G[r][c + 1] != '':
                c+= 1
        elif S[i][j] == 'L':
            if G[r][c - 1] != '':
                c+= -1
        
    P.append(G[r][c])

print('part_2 =',''.join(str(x) for x in P))