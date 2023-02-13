
import copy
with open("input.txt",'r') as f:
    S = f.readlines()



def check_reps(s):
    for i in range(len(s)):
        for j in range(i+1,len(s)):
            if s[i] == s[j]:
                return False
    return True

def check_reps2(s):
    for i in range(len(s)):
        for j in range(i+1,len(s)):
            if ''.join(sorted(s[i])) == ''.join(sorted(s[j])):
                return False
    return True

c = 0
c2 = 0
for i in range(len(S)):
    s = S[i].replace('\n','').split(' ')
    if check_reps(s):
        c += 1
    if check_reps2(s):
        c2 += 1
print('part_1 = ',c)
print('part_2 = ',c2)

