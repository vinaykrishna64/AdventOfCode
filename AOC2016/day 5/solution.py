import hashlib
import copy
door_Id = 'ojvtpuvg' #puzzle input
idx = 100000
passwd = []
count = 0
count2 = 0
passwd2 = ['','','','','','','','']
fill = [0,0,0,0,0,0,0,0]
while True:
    str2hash = ''.join([door_Id, str(idx)])
    result = hashlib.md5(str2hash.encode())
    hsh_hex = result.hexdigest()
    if hsh_hex[0:5] == '00000':
        if not (count == 8):
            passwd.append(hsh_hex[5])
            count += 1
        for i in range(8):
            if str(i) == hsh_hex[5] and not fill[i]:
                passwd2[i] = hsh_hex[6]
                fill[i] = 1
    if sum(fill) == 8:
        break
    idx += 1

print('password 1 is : ',''.join(passwd))
print('password 2 is : ',''.join(passwd2))