import copy
import re

with open("input.txt",'r') as f:
    S = f.readlines()


inpt = 'abcdefgh'
scramble = [i for i in inpt]
for i in range(len(S)):
    s = S[i].split(' ')
    if s[0] == "swap":
        if s[1] == "position":
            I = [int(s[2]), int(s[-1][0])]   
        elif s[1] == "letter":
            I = [scramble.index(s[2]), scramble.index(s[-1][0])]   
        temp = scramble[I[0]]
        scramble[I[0]] = scramble[I[1]]
        scramble[I[1]] = temp
    elif s[0] == "rotate":
        if s[1] == "based":
            I = scramble.index(s[-1][0])
            if I < 4:
                I += 1
            else:
                I += 2
            for i in range(I):
                scramble = scramble[-1:] + scramble[:-1]
        elif s[1] == "left":
            I = int(s[2])  
            scramble = scramble[I:] + scramble[:I]
        elif s[1] == "right":   
            I = int(s[2])
            scramble = scramble[-I:] + scramble[:-I]
    elif s[0] == "reverse":
        I = [int(s[2]), int(s[-1][0])]   
        scramble = scramble[:I[0]] + scramble[I[0]:I[1]+1][::-1] + scramble[I[1]+1:]
    elif s[0] == "move":
        I = [int(s[2]), int(s[-1][0])]   
        temp = scramble[I[0]]
        scramble.pop(I[0])
        scramble = scramble[:I[1]] + [temp] + scramble[I[1]:]
  
print('part_1 = ',''.join(scramble))

## unscramble
inpt = 'fbgdceah'
scramble = [i for i in inpt]
S = S[::-1] #reverse instruction set
for i in range(len(S)):
    s = S[i].split(' ')
    if s[0] == "swap": #swap unscrambles to swap itself
        if s[1] == "position": #swap unscrambles to swap itself
            I = [int(s[2]), int(s[-1][0])]   
        elif s[1] == "letter": #swap unscrambles to swap itself
            I = [scramble.index(s[2]), scramble.index(s[-1][0])]   
        temp = scramble[I[0]]
        scramble[I[0]] = scramble[I[1]]
        scramble[I[1]] = temp
    elif s[0] == "rotate": #---
        if s[1] == "based":
            I = scramble.index(s[-1][0])
            #   I     R      I_n    I   R_back
            #   0     1      1      0   9
            #   1     2      3      1   1  
            #   2     3      5      2   6
            #   3     4      7      3   2
            #   4     6      2      4   7
            #   5     7      4      5   3
            #   6     8      6      6   8
            #   7     9      0      7   4
            Rback = [9,1,6,2,7,3,8,4]
            for i in range(Rback[I]):
                scramble = scramble[1:] + scramble[:1]
        elif s[1] == "left": #left unscrambles to right
            I = int(s[2])  
            scramble = scramble[-I:] + scramble[:-I] 
        elif s[1] == "right":   #right unscrambles to left
            I = int(s[2])
            scramble = scramble[I:] + scramble[:I] 
    elif s[0] == "reverse": #reverse unscrambles to reverse itself
        I = [int(s[2]), int(s[-1][0])]   
        scramble = scramble[:I[0]] + scramble[I[0]:I[1]+1][::-1] + scramble[I[1]+1:]
    elif s[0] == "move": #reverse unscrambles to reverse move
        I = [int(s[-1][0]), int(s[2])]   #reverse move
        temp = scramble[I[0]]
        scramble.pop(I[0])
        scramble = scramble[:I[1]] + [temp] + scramble[I[1]:]
  
print('part_2 = ',''.join(scramble))