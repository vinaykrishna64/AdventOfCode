
from collections import deque
import copy
with open("input.txt",'r') as f:
    S = f.readlines()

letters = ['a','b','c','d','e','f','g','h','i','j','k','l',
               'm','n','o','p','q','r','s','t','u','v','w','x','y','z']
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 
17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
q = deque(letters)
dr = {k:v-1 for k,v in zip(letters,numbers)}
d = {k-1:v for k,v in zip(numbers,letters)}
def counts(S):
    letters = ['a','b','c','d','e','f','g','h','i','j','k','l',
               'm','n','o','p','q','r','s','t','u','v','w','x','y','z']
    count = []
    for i in range(len(letters)):
        count.append(S.count(letters[i]))
    return count
def mk_chksum(count,keys,d):
    chksum = []
    for i in range(5):
        chksum.append(d[keys[i]])
    return ''.join(chksum)

checks = []

for i in range(len(S)):
    s = S[i].split('[')
    temp = s[1].split(']')
    chksum = temp[0]
    count = counts(s[0])
    keys =  sorted(range(len(count)), key=lambda k: count[k], reverse=True)
    count.sort(reverse=True)
    if mk_chksum(count,keys,d) == chksum:
        temp = s[0].split('-')
        checks.append(int(temp[-1]))

print('part_1 = ', sum(checks))

def decrypt_room(s,dr,q):
    key = int(s[-3:])
    real_name = []
    for i in range(len(s)-4):
        if s[i] == '-':
            real_name.append('-')
        else:
            q2 = q.copy()
            I = dr[s[i]]
            q2.rotate(- I - key)
            real_name.append(q2[0])

    return ''.join(real_name)

for i in range(len(S)):
    s = S[i].split('[')
    if decrypt_room(s[0],dr,q) == 'northpole-object-storage': #looked at list first
        print('part_2 =',s[0][-3:])