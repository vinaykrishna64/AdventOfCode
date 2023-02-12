
import copy
with open("input.txt",'r') as f:
    S = f.readlines()

def even_div(r):
    for i in range(len(r)):
        for j in range(i+1,len(r)):
            if r[i]%r[j] == 0:
                return r[i]//r[j]
            elif r[j]%r[i] == 0:
                return r[j]//r[i]
s = 0
s2 = 0
for i in range(len(S)):
    r = S[i].replace('\n','').split('\t')
    r = [int(x) for x in r]
    s += (max(r) - min(r))
    s2 += even_div(r)
print('part_1 =',s)
print('part_2 =',s2)

