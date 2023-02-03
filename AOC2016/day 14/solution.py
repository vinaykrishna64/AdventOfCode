import hashlib
import copy
import re
inpt = 'zpqevtbw' #puzzle input
idx = 0
count = 0
hsh_key = []
store = {}
while True:
    new_store = {}
    str2hash = ''.join([inpt, str(idx)])
    result = hashlib.md5(str2hash.encode())
    hsh_hex = result.hexdigest() 
    match = re.findall(r'(.)\1{2}',hsh_hex) 
    if match != []:
        try:
            store[match[0]].append(idx) 
        except:
            store[match[0]] = [idx]
    match = re.findall(r'(.)\1{4}',hsh_hex) 
    if match != []:
        for key in store:
            new_store[key] = []
            for i in range(len(store[key])):
                if key == match[0] and idx - store[key][i] <= 1000 and idx - store[key][i] > 0:
                    count += 1
                    hsh_key.append(store[key][i])
                else:
                    new_store[key].append(store[key][i])
        store = new_store.copy()

    if count >= 64:
        break   
    idx += 1
   
print('part 1 = ',hsh_key[63])



def hshstretch(inpt,idx):
    str2hash = ''.join([inpt, str(idx)])
    result = hashlib.md5(str2hash.encode())
    hsh_hex = result.hexdigest() 
    for i in range(2016):
        str2hash = hsh_hex
        result = hashlib.md5(str2hash.encode())
        hsh_hex = result.hexdigest() 
    return hsh_hex

idx = 0
count = 0
hsh_key = []
store = {}
while True:
    new_store = {}
    hsh_hex = hshstretch(inpt,idx)
    match = re.findall(r'(.)\1{2}',hsh_hex) 
    if match != []:
        try:
            store[match[0]].append(idx) 
        except:
            store[match[0]] = [idx]
    match = re.findall(r'(.)\1{4}',hsh_hex) 
    if match != []:
        for key in store:
            new_store[key] = []
            for i in range(len(store[key])):
                if key == match[0] and idx - store[key][i] <= 1000 and idx - store[key][i] > 0:
                    count += 1
                    hsh_key.append(store[key][i])
                else:
                    new_store[key].append(store[key][i])
        store = new_store.copy()

    if count >= 64:
        break  
    idx += 1
   
print('part 2 = ',hsh_key[63])
