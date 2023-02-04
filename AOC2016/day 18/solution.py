import copy


with open("input.txt",'r') as f:
    S = f.readlines()

line = []
for i in range(len(S[0])):
    if S[0][i] == '.':
        line.append(0)
    else:
        line.append(1)


def nxt_line(line):
    for i in range(len(line)):
        if i == 0:
            if line[1] == 1:
                new_line = [1]
            else:
                new_line = [0]
        elif i == len(line) - 1:
            if line[-2] == 1:
                new_line.append(1)
            else:
                new_line.append(0)
        else:
            if (line[i-1] == 1 or line[i+1] == 1) and (line[i-1] !=  line[i+1]):
                new_line.append(1)
            else:
                new_line.append(0)
    return new_line

lines = [line]
count = sum(line)
n_rows = 400000
for i in range(1,n_rows):
    lines.append(nxt_line(lines[i-1]))
    count += sum(lines[i])
    if i == 39:
        print('part_1 = ', len(line)*40 - count)
        
count = len(line)*n_rows - count
print('part_2 = ',count)

