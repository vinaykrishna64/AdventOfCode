import copy


with open("input.txt",'r') as f:
    S = f.readlines()



def open_reg(reg,S):
    i = 0
    while i < len(S) and i>= 0:
        s = S[i].split()
        if s[0] == "cpy":
            #cpy
            if s[1].replace('-','').isnumeric() and not s[2].replace('-','').isnumeric(): 
                reg[s[2]] = int(s[1])
            elif not s[1].replace('-','').isnumeric() and not s[2].replace('-','').isnumeric():
                reg[s[2]] = reg[s[1]]
        elif s[0] == "jnz":
            #jnz
            if s[1].replace('-','').isnumeric(): 
                if int(s[1]) > 0:
                    if s[2].replace('-','').isnumeric():
                        i += int(s[2])-1
                    else:
                        i += reg[s[2]]-1
            elif not s[1].replace('-','').isnumeric():
                if reg[s[1]] > 0:
                    if s[2].replace('-','').isnumeric():
                        i += int(s[2])-1
                    else:
                        i += reg[s[2]]-1
        elif s[0] == "inc":
            #inc
            reg[s[1]] += 1
        elif s[0] == "dec":
            #dec
            reg[s[1]] -= 1
        elif s[0] == "tgl":
            #tgl
            if s[1].replace('-','').isnumeric(): 
                I_tgl = i + int(s[1])
            elif not s[1].replace('-','').isnumeric():
                I_tgl = i + reg[s[1]]
            if I_tgl >= 0 and I_tgl < len(S):
                s2 = S[I_tgl].split()
                if s2[0] == "cpy":
                    s2[0] = "jnz"
                elif s2[0] == "jnz":
                    s2[0] = "cpy"
                elif s2[0] == "dec":
                    s2[0] = "inc"
                elif s2[0] == "inc":
                    s2[0] = "dec"
                elif s2[0] == "tgl":
                    s2[0] = "inc"
                S[I_tgl] = ' '.join(s2)
        i += 1
    return reg


reg = open_reg({'a':7,'b':0,'c':0,'d':0},S.copy())
print('part_1 = ',reg['a'])

reg = open_reg({'a':12,'b':0,'c':0,'d':0},S.copy())
print('part_2 = ',reg['a'])