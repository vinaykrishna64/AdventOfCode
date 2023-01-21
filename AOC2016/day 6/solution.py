
import copy
with open("input.txt",'r') as f:
    S = f.readlines()

letters = ['a','b','c','d','e','f','g','h','i','j','k','l',
               'm','n','o','p','q','r','s','t','u','v','w','x','y','z']
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 
17, 18, 19, 20, 21, 22, 23, 24, 25, 26]
dr = {k:v-1 for k,v in zip(letters,numbers)}
d = {k-1:v for k,v in zip(numbers,letters)}
def counts(S):
    letters = ['a','b','c','d','e','f','g','h','i','j','k','l',
               'm','n','o','p','q','r','s','t','u','v','w','x','y','z']
    count = []
    for i in range(len(letters)):
        count.append(S.count(letters[i]))
    return count
err = []
err2 = []
for c in range(len(S[0])-1):
    col = []
    for i in range(len(S)):
        col.append(S[i][c])
    col = ''.join(col)
    count = counts(str(col))
    keys =  sorted(range(len(count)), key=lambda k: count[k], reverse=True)
    count.sort(reverse=True)
    err.append(d[keys[0]])
    err2.append(d[keys[-1]])

print('part_1 =',''.join(err))
print('part_2 =',''.join(err2))
