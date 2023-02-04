import copy

inpt = "11101000110010100" #puzzle input

def dragon_curve(a):
    b = a[::-1]
    b = b.replace("1","a")
    b = b.replace("0","1")
    b = b.replace("a","0")
    return a + "0" + b

def chk_sum(inpt,dsk_sz):
    while len(inpt) < dsk_sz:
        inpt = dragon_curve(inpt)
    inpt = inpt[:dsk_sz]
    while len(inpt)%2 == 0:
        new_inpt = []
        for i in range(len(inpt)):
            if i%2 == 0:
                if inpt[i] == inpt[i+1]:
                    new_inpt.append('1')
                else:
                    new_inpt.append('0')
        inpt = ''.join(new_inpt)
    return inpt


print('part_1 = ',chk_sum(inpt,272))

print('part_1 = ',chk_sum(inpt,35651584))

