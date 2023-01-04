clear all
clc

S = readlines("input.txt");
vowels = string(['aeiou']');
doublets = strcat(string(['a':'z']'),string(['a':'z']'));
badStr = ["ab", "cd", "pq", "xy"];
%% part 1
count = 0;
for i = 1:numel(S)
    if (check_parts(S(i),vowels,1) >= 3) & check_parts(S(i),doublets,0) & ~check_parts(S(i),badStr,0)
        count = count + 1;
    end
end
part_1 = count

%% part 2
count = 0;
L = string(['a':'z']'); L = strcat(repmat(L,[26,1]),reshape(repmat(L',26,1),[26*26,1]),repmat(L,[26,1]));
L1 = repmat(string(['a':'z']'),[1,26]); L1 = strcat(L1, L1'); L1 = reshape(L1,[1 numel(L1)]);
for i = 1:numel(S)
    if check_r1(S(i),L1) & check_r2(S(i),L)
        count = count + 1; 
    end
end
part_2 = count
%% functions
function [out] = check_r1(s,L)
    out = 0;
    for i = 1:numel(L)
        n =  count(s,L(i));
        if n >= 2
            if numel(split(s,L(i))) == n+1
                out = 1;
            end
        end
    end
end

function [out] = check_r2(s,L)
    out = 0;
    for i = 1:numel(L)
        if contains(s,L(i))
            out = 1;
        end
    end
end
function [count] = check_parts(s,lst,flg)
    count = 0;
    for i = 1:numel(lst)
        if contains(s,lst(i))
            if flg
                count = count + sum(contains(split(s,""),lst(i)));
            else
                count = count + 1;
            end
        end
    end
end