import copy
import numpy as np
import math
import string
import sympy 
import re

# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
S = [s.strip('\n') for s in S]
S = [s.split(' ') for s in S]



def run_prog(reg):
    trk = 0
    p1 = 0
    def handle_int_str(x):
        if not x.isalpha():
            return int(x)
        else:
            return reg[x]
    while trk >=0  and trk < len(S):
        if S[trk][0] == 'set':
            reg[S[trk][1]] = handle_int_str(S[trk][2])
            trk += 1
        elif S[trk][0] == 'sub':
            reg[S[trk][1]] -= handle_int_str(S[trk][2])
            trk += 1
        elif S[trk][0] == 'mul':
            reg[S[trk][1]] *= handle_int_str(S[trk][2])
            trk += 1
            p1 += 1
        elif S[trk][0] == 'jnz':
            if S[trk][1].isalpha():
                if reg[S[trk][1]]:
                    trk += handle_int_str(S[trk][2])
                else:
                    trk += 1
            else:
                if int(S[trk][1]):
                    trk += handle_int_str(S[trk][2])
                else:
                    trk += 1
    return p1,reg['h']
reg = {'a':0,'b':0,'c':0,'d':0,'e':0,'f':0,'g':0,'h':0}
p1,_ = run_prog(reg)
print('part_1 = ',p1)




# a = -1
# set b 67 => b = 67
# set c b  => b = 67
# jnz a 2  not zero a = -1
# jnz 1 5  skips this
# mul b 100  => b = 6700
# sub b -100000 => b = 106700
# set c b  => c = 106700
# sub c -17000 => c = 123700
#       set f 1 => f = 1
#       set d 2 => d = 2
#          set e 2 => e = 2
#               set g d => g = d
#               mul g e => g = e*g
#               sub g b => g = g - b :: g = e*d - b
#               jnz g 2 => if g set f = 0
#               set f 0
#               sub e -1 => e = e+1
#               set g e  => g = e
#               sub g b  => g = g -b :: g = e - b
#               jnz g -8 => loop back if g : if not g break
#                   sub d -1 => d = d+1
#                   set g d  => g = d 
#                   sub g b  => g = g - b :: g = d -b
#                   jnz g -13 => loop if not g break
#                       jnz f 2  
#                       sub h -1 => h = h+1
#                       set g b => g = b
#                       sub g c => g = g - c :: b -c
#                       jnz g 2
#                       jnz 1 3 
#                       sub b -17 =>  b = b +17
#                       jnz 1 -23

#a = -1

# f = 1
# d = 2
#       e = 2
#           g = e*d - b
#           if g == 0 : f = 0
#           e =  e + 1
#           g = e - b : loop block if g != 0
#       d = d + 1
#       g = d - b : loop block if g != 0
#if f != 0 : h = h+1
#g = b -c
# if f == 0 :: break
# b = b +17 :loop block
# g = 0
# h = 0
# while True:
#     f = 1
#     d = 2
#     while True:
#         e = 2
#         while True:
#             g = e*d - b
#             if g == 0:
#                 f = 0
#             e += 1
#             g = e -b
#             if  g == 0:
#                 break
#         d += 1
#         g = d - b
#         if  g == 0:
#             break
#     if f != 0:
#         h += 1
#     g = b-c
#     if f == 0:
#         break
#     b += 17

# for b in range(106700, c + 1, 17):
#     f = 1
#     for d in range(2, b + 1):
#         for e in range(2, b + 1):
#             if d * e == b:
#                 f = 0
#         if f == 0:
#             h += 1

#optimization online
b = 106700
c = 123700
h = 0
for x in range(b, c + 1, 17):
    if not sympy.isprime(x):
        h += 1
print('part_2 = ',h)
