
import copy
with open("input.txt",'r') as f:
    S = f.readlines()



def check_abba(s):
    abba = False
    for i in range(len(s)-3):
        if s[i] == s[i+3] and s[i+1] == s[i+2] and s[i] != s[i+1]:
            abba = True
            break
    return abba

def check_SSL(s):
    aba = []
    bab = []
    for j in range(len(s)):
        if not j%2 : #supernet
            for i in range(len(s[j])-2):
                if s[j][i] == s[j][i+2] and s[j][i] != s[j][i+1]:
                    aba.append(''.join([s[j][i],s[j][i+1],s[j][i+2]]))
        elif j%2 : #hypernet
            for i in range(len(s[j])-2):
                if s[j][i] == s[j][i+2] and s[j][i] != s[j][i+1]:
                    bab.append(''.join([s[j][i+1],s[j][i],s[j][i+1]])) #save aba of bab
    for i in range(len(aba)):
        for j in range(len(bab)):
            if aba[i] == bab[j]:
                return True
    return False  
count = 0
count2 = 0
for i in range(len(S)):
    s = S[i].replace(']', '[')
    s = s.split('[')
    if check_SSL(s):
        count2 += 1
    abba = False
    for j in range(len(s)):
        if not j%2 and check_abba(s[j]):
            abba = True
        elif j%2 and check_abba(s[j]):
            abba = False
            break
    if abba:
        count += 1
        

print('part_1 = ',count)
print('part_2 = ',count2)