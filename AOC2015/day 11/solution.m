clear all
clc

S = readlines("input.txt").split("");
S = S(2:end-1);
M = containers.Map(string(['a':'z']'),1:26);
Mr = containers.Map(1:26,string(['a':'z']'));
for i = 1:8
    P(i) = M(S(i));
end


P = make_pass(P);
for i = 1:8
    part_1(i) =  Mr(P(i));
end
part_1 

P = make_pass(P);
for i = 1:8
    part_2(i) =  Mr(P(i));
end
part_2
%% functions
function [P] = make_pass(P)
    while true
        P = next_P(P);
        Pd = diff(P);
        rules = zeros(1,3);
        rules(2) = 1; %taken care when generating
        %rule 1
        I = find(Pd == 1);
        if any(diff(I) == 1)
            rules(1) = 1;
        end
        %rule 3
        I = find(Pd == 0);
        if sum(diff(I) > 1) >= 1
            rules(3) = 1;
        elseif all(diff(I) == 1) & numel(diff(I)) > 2
            rules(3) = 1;
        end
        if all(rules == 1)
            break
        end
    end
end
function [P] = next_P(P)
    for i = 8:-1:1
        P(i) = P(i) + 1;
        if any(P(i) == [9,15,12]) % skip i o l %rule 2
            P(i) = P(i) + 1;
            break
        elseif P(i) == 27
            P(i) = 1;
        else
            break
        end
    end
end