import copy


with open("input.txt",'r') as f:
    S = f.readlines()

def Run_instruc(reg):
    indx = {'a':0,'b':1,'c':2,'d':3}
    i = 0
    while i < len(S) and i >= 0:
        s = S[i].split()
        if len(s) == 2:
            if s[0] == 'inc':
                reg[indx[s[1]]] += 1
            else:
                reg[indx[s[1]]] -= 1
        elif len(s) == 3:
            if s[0] == 'cpy':
                if s[1].isnumeric():
                    reg[indx[s[2]]] = int(s[1])
                else:
                    reg[indx[s[2]]] = reg[indx[s[1]]]
            else:
                jump = int(s[2])
                if s[1].isnumeric():
                    if int(s[1]) > 0:
                        i += jump - 1 
                else:
                    if reg[indx[s[1]]] > 0:
                        i += jump - 1
        i += 1
    return reg

    
reg = [0,0,0,0] #a b c d
reg = Run_instruc(reg)
print('part_1 = ',reg[0])   



reg = [0,0,1,0] #a b c d
reg = Run_instruc(reg)
print('part_2 = ',reg[0])   