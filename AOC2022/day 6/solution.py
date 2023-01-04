import copy
import string

keys = list(string.ascii_letters)
values = range(1,53)
dict_map = dict(zip(keys, values))

file_name = 'input.txt'

file = open(file_name, 'r')
Lines = file.readlines()
file.close

line = list(Lines[0])
S = [dict_map[x] for x in line]

def find_start(S,n):
	for i in range(0,len(S)-n+1):
		if(len(set( S[(i+0):(i+n)])) == len( S[(i+0):(i+n)])):
			return i+n

print(find_start(Lines[0],4))

print(find_start(Lines[0],14))