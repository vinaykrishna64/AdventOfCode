import copy
import numpy as np
import math
import string
from sympy import *
import re
import collections
# parse inputs
with open("input.txt",'r') as f:
    S = f.readlines()
rules = [s.strip('\n') for s in S]


init = '.#./..#/###'


def str2array(x):
    arr = np.array([y for y in list(x.replace('/', ''))])
    s = int(np.sqrt(len(arr)))
    return arr.reshape((s,s))
def array2str(x):
    s = []
    for idx in range(len(x)):
        s.append(''.join(x[idx]))
    return '/'.join(s)

def check_rule(sub_img,rule_dict):
    return str2array(rule_dict[array2str(sub_img)])


rule_dict = dict()
for idx in range(len(rules)):
    rule = rules[idx].split(' => ')
    rule_mat = str2array(rule[0])
    for k in range(4):
        rot = np.rot90(rule_mat, k=k)
        rule_dict[array2str(rot)] = rule[1]
        rule_dict[array2str(np.flipud(rot))] = rule[1]
        rule_dict[array2str(np.fliplr(rot))] = rule[1]


def iter_img(img):
    if len(img)%2 == 0:
        segs = len(img) // 2
        new_img = np.empty((3*segs, 3*segs), dtype='object')
        for r in range(segs):
            for c in range(segs):
                sub_img = img[2*r:(2*r + 2), 2*c:(2*c + 2)].copy()
                new_sub = check_rule(sub_img, rule_dict)
                new_img[3*r:(3*r + 3), 3*c:(3*c + 3)] = new_sub.copy()
    else:
        segs = len(img) // 3
        new_img = np.empty((4*segs, 4*segs), dtype='object')
        for r in range(segs):
            for c in range(segs):
                sub_img = img[3*r:(3*r + 3), 3*c:(3*c + 3)].copy()
                new_sub = check_rule(sub_img, rule_dict)
                new_img[4*r:(4*r + 4), 4*c:(4*c + 4)] = new_sub.copy()
    return new_img

img = str2array(init)
for idx in range(18):
    img = iter_img(img)
    if idx == 4:
        unique, counts = np.unique(img, return_counts=True)

        print('part_1 = ',counts[0])


unique, counts = np.unique(img, return_counts=True)
print('part_2 = ',counts[0])