clear all
clc

S = readlines("input.txt");


hasher = System.Security.Cryptography.HashAlgorithm.Create('MD5');
%% part 1
n = 100000;
while true
    N = strcat(S,string(num2str(n)));
    hash_hex = makeMD5(hasher,N);
    if check_hex(hash_hex,'00000')
        break
    end
    n = n+1;
end
part_1 = n;

%% part 2
n = 1000000;
while true
    N = strcat(S,string(num2str(n)));
    hash_hex = makeMD5(hasher,N);
    if check_hex(hash_hex,'000000')
        break
    end
    n = n+1;
end
part_2 = n;
%% functions
function [W] = one_less(W)
    for i = numel(W):-1:1
        W(i) = W(i) - 1;
        if W(i) < 0 
           W(i) = 9;
        else
           break
        end
    end
end
function [hash_hex] = makeMD5(hasher,str)
% link for the stackoverflow page
%https://stackoverflow.com/questions/49613043/convert-a-string-into-hash-value-in-matlab
    % GENERATING THE HASH:
    hash_byte = hasher.ComputeHash(uint8(char(str)));  % System.Byte class
    hash_uint8 = uint8( hash_byte );               % Array of uint8
    hash_hex = dec2hex(hash_uint8);  
    hash_hex = strjoin(string(hash_hex),"");
end
function [out] = check_hex(hash_hex,n)
    out = 0;
    hash_hex = char(hash_hex);
    if hash_hex(1:numel(n)) == n
        out = 1;
    end
end
