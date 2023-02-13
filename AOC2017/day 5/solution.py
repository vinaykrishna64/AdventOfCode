
import copy
with open("input.txt",'r') as f:
    S = f.readlines()
I= []
for i in range(len(S)):
    s = S[i].replace('\n','').split(' ')
    I.append(int(s[0]))
def P1(I):
    i = 0
    #first step
    i_o = i
    i += I[i]
    I[i_o] += 1
    stps = 1
    while i < len(I):
        i_o = i
        i += I[i]
        I[i_o] += 1
        stps += 1
    return stps
print('part_1 = ',P1(I.copy()))

def P2(I):
    i = 0
    #first step
    i_o = i
    i += I[i]
    if I[i_o] >= 3:
        I[i_o] -= 1
    else:
        I[i_o] += 1
    stps = 1
    while i < len(I):
        i_o = i
        i += I[i]
        if I[i_o] >= 3:
            I[i_o] -= 1
        else:
            I[i_o] += 1
        stps += 1
    return stps
print('part_2 = ',P2(I.copy()))