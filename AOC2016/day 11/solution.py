from copy import deepcopy
import re
from itertools import permutations
from itertools import combinations
from heapq import heappush, heappop
# -ve x = machine and +ve x = generator
# testcase
# floors = [[-1,-2],[1],[2],[]] #from inputs
# Nitems = 4
#input
floors = [[-1,1],[2,3,4,5],[-2,-3,-4,-5],[]] #from inputs
Nitems = 10

floor = 0
def checkSpace(flr): # checks if any machine is left it that space with an incompatible generator
    if not flr:
        return True
    flr = sorted(flr)
    if flr[-1] >0 and flr[0] < 0: #if machines are with generators
        for x in flr:
            if x < 0: # for each machine
                if -x not in flr: # if that machine doesn't have the corresponding generator it will explode
                    return False
    return True
def checkFloors(floors,floor):#don't bother moving things down if all the floors below is empty there is not merit in doing that
    for flr in range(floor):
        if len(floors[flr]):
            return True
    return False
def sortFloors(floors):
    return [sorted(flr) for flr in floors]

## items are interchangebale 
# check if similar configuration exists when the elevetor is on that floor
def FLoorStateKey(floors,Nitems): 
    key = [0 for x in range(Nitems)]  
    for flr in range(4):
        for x in floors[flr]:
            if x > 0:
                key[x-1] = flr+1
            else:
                key[-x+int(Nitems/2)-1] = (flr+1) *10   
    key.sort()       
    return key

def moveStuff(floors,Nitems):
    cases = [(0,floors,0)]
    while cases:
        costNow,floors,floor = heappop(cases)
        if len(floors[-1]) == Nitems:
            return costNow
        if (FLoorStateKey(floors,Nitems),floor) in seen:
            continue
        seen.append((FLoorStateKey(floors,Nitems),floor))
        toMove = []
        # considerations
        # don't bother moving things down if all the floors below is empty there is not merit in doing that
        # moves should be considered in this pecendence
        # try moving two items up
        # try moving one item up
        # try moving one item dow
        # try moving two items down
        # bring item / items upstairs
        if floor < 3:
            # bring two items upstairs
            for perm in permutations(floors[floor], 2):
                if checkSpace(list(perm)): # if elevator is safe
                    if checkSpace(floors[floor+1] + list(perm)): # if the move is safe to the next level
                        floors_cp = deepcopy(floors)
                        # remove itmes
                        for x in perm:
                            floors_cp[floor].remove(x)
                        if checkSpace(floors_cp[floor]): # check if the current floor is table after removal
                            floors_cp[floor+1] += list(perm) # complete move
                            toMove.append((costNow+1,floors_cp,floor+1))
            # bring one item upstairs
            for perm in floors[floor]:
                if checkSpace(floors[floor+1] + [perm]): # if the move is safe to the next level
                    floors_cp = deepcopy(floors)
                    # remove itmes
                    floors_cp[floor].remove(perm)
                    if checkSpace(floors_cp[floor]): # check if the current floor is table after removal
                        floors_cp[floor+1] += [perm] # complete move
                        toMove.append((costNow+1,floors_cp,floor+1))
        # bring item / items downstairs
        if floor > 0:
            if checkFloors(floors,floor): #don't bother moving things down if all the floors below is empty there is not merit in doing that
                # bring one item downstairs
                for perm in floors[floor]:
                    if checkSpace(floors[floor-1] + [perm]): # if the move is safe to the next level
                        floors_cp = deepcopy(floors)
                        # remove itmes
                        floors_cp[floor].remove(perm)
                        if checkSpace(floors_cp[floor]): # check if the current floor is table after removal
                            floors_cp[floor-1] += [perm] # complete move
                            toMove.append((costNow+1,floors_cp,floor-1))
                            # bring two items downstairs
                for perm in permutations(floors[floor], 2):
                    if checkSpace(list(perm)): # if elevator is safe
                        if checkSpace(floors[floor-1] + list(perm)): # if the move is safe to the next level
                            floors_cp = deepcopy(floors)
                            # remove itmes
                            for x in perm:
                                floors_cp[floor].remove(x)
                            if checkSpace(floors_cp[floor]): # check if the current floor is table after removal
                                floors_cp[floor-1] += list(perm) # complete move
                                toMove.append((costNow+1,floors_cp,floor-1))
        for x in toMove:
            heappush(cases,x)

seen = []
floors = sortFloors(floors)
print('part_1 = ',moveStuff(floors,Nitems)) 
seen = []
floors[0] += [-6,-7,6,7]
floors = sortFloors(floors)
Nitems += 4
print('part_2 = ',moveStuff(floors,Nitems)) 
