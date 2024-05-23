clear all
clc
filename = 'input.txt';
S = readlines(filename);
S = str2double(S);


sub_no = 7;

encryption_key = transform_id(S(2),loop_size(sub_no,S(1)));



fprintf('part 1 = %14d \n',encryption_key)

%%
function [l_sz] = loop_size(sub_no,id)
    l_sz = 1;
    x = sub_no;
    while x ~= id
        x = mod(x*sub_no,20201227);
        l_sz = l_sz+1;
    end
end

function [x] = transform_id(sub_no,l_sz)
    x = 1;
    for idx = 1:l_sz    
        x = mod(x*sub_no,20201227);
    end
end