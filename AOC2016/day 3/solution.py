
import re
import copy
with open("input.txt",'r') as f:
    S = f.readlines()
def tricheck(a,b,c):
    if (a < b+c) and (b < a+c) and (c < a+b):
        return 1
    else:
        return 0
part_1 = 0
tri = []
for i in range(len(S)):
    s = re.findall(r'\d+',S[i])
    s = [int(x) for x in s]
    tri.append(s.copy())
    if tricheck(s[0],s[1],s[2]):
        part_1 += 1

   

print('part_1 =',part_1)

def Lind2sub(i,sz):
    #linear index function
    c = int(i/sz[0])
    r = int(i - sz[0]*c - 1)
    if r == -1:
        r = sz[0] - 1
    if sz[0]*c == i:
        c = c - 1
    return r,c


part_2 = 0
sz = [len(S),3]

for i in range(1,len(S)*3,3):
    [r,c] = Lind2sub(i,sz)
    A = tri[r][c]
    [r,c] = Lind2sub(i+1,sz)
    B = tri[r][c]
    [r,c] = Lind2sub(i+2,sz)
    C = tri[r][c]
    if tricheck(A,B,C):
        part_2 += 1

print('part_2 =',part_2)