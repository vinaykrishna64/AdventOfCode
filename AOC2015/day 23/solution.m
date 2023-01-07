clear all
clc

S = readlines("input.txt").erase(",").replace(["a","b"],["1","2"]);



i = 1; R = [0 0];

R = Prog(S,i,R);

part_1 = R(2)


i = 1; R = [1 0];

R = Prog(S,i,R);

part_2 = R(2)


function [R] = Prog(S,i,R)
    instruc = ["hlf","tpl","inc","jmp","jie","jio"];
    while true
        if i > numel(S) | i <= 0
            break
        end
        s = S(i).split(" ");
        if instruc(1) == s(1)
           I = str2num(s(2));
           R(I) = floor(R(I)/2);
           i = i+1;
        elseif instruc(2) == s(1)
           I = str2num(s(2));
           R(I) = R(I)*3;
           i = i+1;
        elseif instruc(3) == s(1)
           I = str2num(s(2));
           R(I) = R(I) + 1;
           i = i+1;
        elseif instruc(4) == s(1)
           I = str2num(s(2));
           i = i+I;
        elseif instruc(5) == s(1)
           I = str2num(s(2));
           if mod(R(I),2) == 0
               i = i + str2num(s(3));
           else
               i = i+1;
           end
        elseif instruc(6) == s(1)
           I = str2num(s(2));
           if R(I) == 1
               i = i + str2num(s(3));
           else
               i = i+1;
           end     
        end
    end
end