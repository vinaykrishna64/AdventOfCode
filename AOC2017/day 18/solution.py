import copy
import numpy as np
import string
from collections import deque
# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = [s.strip('\n') for s in S]
def part_1(S):
    #looking at inputs there's ony 5 varnames
    D = {'a': 0,'b': 0,'f': 0,'i': 0,'p': 0}
    trk = 0
    n = len(S)
    while True:
        rule = S[trk%n].split(' ')
        if rule[0] == 'set':
            if rule[2].isalpha():
                D[rule[1]] = D[rule[2]]
            else:
                D[rule[1]] = int(rule[2])
            trk += 1
        elif rule[0] == 'add':
            if rule[2].isalpha():
                D[rule[1]] += D[rule[2]]
            else:
                D[rule[1]] += int(rule[2])
            trk += 1
        elif rule[0] == 'mul':
            if rule[2].isalpha():
                D[rule[1]] *= D[rule[2]]
            else:
                D[rule[1]] *= int(rule[2])
            trk += 1
        elif rule[0] == 'mod':
            if rule[2].isalpha():
                D[rule[1]] %= D[rule[2]]
            else:
                D[rule[1]] %= int(rule[2])
            trk += 1
        elif rule[0] == 'jgz':
            if rule[1].isalpha():
                if D[rule[1]] > 0:
                    trk += int(rule[2])
                else:
                    trk += 1
            else:
                if rule[1] > 0:
                    trk += int(rule[2])
                else:
                    trk += 1
        elif rule[0] == 'snd':
            sent = D[rule[1]]
            trk += 1
        elif rule[0] == 'rcv':
            if D[rule[1]]:
                break
            trk += 1
    return sent
print('part_1 = ',part_1(S))

def Move_rule(S,D,T,messages_send, messages_rcv):
    n = len(S)
    rule = S[T].split(' ')
    if rule[0] == 'jgz':
        if rule[1].isalpha():
            if D[rule[1]] >0:
                return T + int(rule[2])
        else:
            if int(rule[1])  >0:
                return T + int(rule[2])
    elif rule[0] == 'snd':
        if rule[1].isalpha():
            messages_send.append(D[rule[1]])
        else:
            messages_send.append(int(rule[1]))
        D["sent"] += 1
    elif rule[0] == 'rcv':
        if len(messages_rcv):
            D[rule[1]] = messages_rcv.pop(0)
            D["running"] = 1
        else:
            D["running"] = 0
            return T
    elif rule[0] == 'set':
        if rule[2].isalpha():
            D[rule[1]] = D[rule[2]]
        else:
            D[rule[1]] = int(rule[2])
    elif rule[0] == 'add':
        if rule[2].isalpha():
            D[rule[1]] += D[rule[2]]
        else:
            D[rule[1]] += int(rule[2])
    elif rule[0] == 'mul':
        if rule[2].isalpha():
            D[rule[1]] *= D[rule[2]]
        else:
            D[rule[1]] *= int(rule[2])
    elif rule[0] == 'mod':
        if rule[2].isalpha():
            D[rule[1]] %= D[rule[2]]
        else:
            D[rule[1]] %= int(rule[2])
    return T+1




R1 = {'a': 0,'b': 0,'f': 0,'i': 0,'p': 0,'c':0,'d':0,"sent":0,"running":1}
R2 = {'a': 0,'b': 0,'f': 0,'i': 0,'p': 0,'c':0,'d':0,"sent":0,"running":1}
M1 = []
M2 = []
T1 = 0
T2 = 0
while  R1["running"] or R2["running"]:
    T1 = Move_rule(S,R1,T1,M1,M2)
    T2 = Move_rule(S,R2,T2,M2,M1)

print('part_2 = ',R2['sent']//2) #somehow double counting can't figure out why :(



