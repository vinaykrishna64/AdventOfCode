import copy


with open("input.txt",'r') as f:
    S = f.readlines()



def open_reg(reg,S):
    i = 0
    out = []
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
        elif s[0] == "out":
            #out
            if not s[1].replace('-','').isnumeric():
                out.append(str(reg[s[1]]))
            else:
                out.append(s[1])
        if len(out) >= 100:
            return ''.join(out)
        i += 1
    

def chk_oscillation(out):
    for i in range(1,len(out)-1):
        if out[i-1] != out[i+1] and out[i-1] != out[i]:
            return False
    return True

i = 0
while True:
    out = open_reg({'a':i,'b':0,'c':0,'d':0},S.copy())
    if chk_oscillation(out):
        print('part_1 = ',i)
        break
    else:
        i += 1
