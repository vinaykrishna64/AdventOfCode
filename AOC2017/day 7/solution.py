
import copy
import numpy as np
import statistics
with open("input.txt",'r') as f:
    S = f.readlines()



Weight = dict()
disc = dict()
Stacks_on_node = dict()
edge_open = []
edge_close = []
for i in range(len(S)):
    s = S[i].replace('->','').replace(',','').replace('\n','').replace('  ',' ').split(' ')
    Weight[s[0]] = int(s[1][1:-1]) #get weights
    Stacks_on_node[s[0]] = []
    for j in range(2,len(s)):
        edge_open.append(s[0])
        edge_close.append(s[j])
        Stacks_on_node[s[0]].append(s[j])

base = [i for i in set(edge_open).difference(set(edge_close))]
print('part_1 = ', base[0])

def stack_weight(key,edge_open,edge_close,Weight): #get stack weight at each node
    stack_nodes = [key]
    stack_flg = 1
    while stack_flg != 0:
        stack_flg = 0
        for i in range(len(edge_open)):
            if edge_open[i] in stack_nodes:
                if edge_close[i] not in stack_nodes:
                    stack_nodes.append(edge_close[i])
                    stack_flg = 1
    stack_weight = 0
    for key in stack_nodes:
        stack_weight += Weight[key]
    return stack_weight

for key in Weight:
    disc[key] = stack_weight(key,edge_open,edge_close,Weight)


Base_disc = base[0]
bad_stack_flg = 1
Base_prev = ''
while bad_stack_flg  != 0: #propagate into each bad stack until the point where all good stacks are found
    bad_stack_flg = 0
    stack_weights = []
    for val in Stacks_on_node[Base_disc]:
        stack_weights.append(disc[val])

    mode = statistics.mode(stack_weights)
    Log_stack = [1 if i != mode else 0 for i in stack_weights]
    if sum(Log_stack) != 0:
        I = Log_stack.index(1)
        Base_prev = Base_disc
        Base_disc = Stacks_on_node[Base_disc][I]
        bad_stack_flg = 1
    else:
        for val in Stacks_on_node[Base_prev]:
            if val != Base_disc:
                print('part 2 = ',Weight[Base_disc] - (disc[Base_disc] - disc[val]))#basically change weight of node final bad stack
                break
        
        
    

