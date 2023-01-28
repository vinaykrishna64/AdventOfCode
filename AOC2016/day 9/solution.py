
with open("input.txt",'r') as f:
    S = f.readlines()

s = S[0]

def decomp(s):
    n = 0
    s_exp = []
    while n < len(s):
        if s[n] == "(":  
            n += 1
            t_sz = []
            while s[n] != ")":
                t_sz.append(s[n])
                n += 1
            t_sz  = ''.join(t_sz)
            t_sz = t_sz.split('x')     
            rep_arr = s[(n+1):(n+int(t_sz[0])+1)]
            n += int(t_sz[0])
            for i in range(int(t_sz[1])):
                for j in range(int(t_sz[0])):
                    s_exp.append(rep_arr[j])
        else:
            s_exp.append(s[n])
        n += 1
    return ''.join(s_exp)


s = decomp(s)

print('part_1 = ',len(s))


def eval_first(s):
    n = 0
    s_exp = []
    s_begin = []
    eval_flg = 0
    trim_flg = -1
    while n < len(s):
        if s[n] == "(":  
            n += 1
            t_sz = []
            while s[n] != ")":
                t_sz.append(s[n])
                n += 1
            t_sz  = ''.join(t_sz)
            t_sz = t_sz.split('x')     
            rep_arr = s[(n+1):(n+int(t_sz[0])+1)]
            n += int(t_sz[0])
            for i in range(int(t_sz[1])):
                for j in range(int(t_sz[0])):
                    s_exp.append(rep_arr[j])
            eval_flg = 1
            trim_flg = 1
        else:
            s_begin.append(s[n])
        n += 1
        if eval_flg:
            break
    s_exp.append(s[n:])   
    return ''.join(s_exp), len(s_begin), trim_flg


Tflg = 1
p2 = 0
while Tflg > 0:
    [s,b,Tflg] = eval_first(s)
    p2 += b

p2 += len(s)
print('part_2 = ',p2)
