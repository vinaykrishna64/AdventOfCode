clear all
clc
S = readlines('input.txt').split();
RPS = 'RPS';
sets = [['A':'C']' , ['X':'Z']'];

%make rules
rule = struct();
score = repmat([3 0 6]',[1,3]); %win score
rule_f = [];
for i = 1:3
    rule_f = [rule_f; string(strcat(RPS', circshift(RPS',i-1)))' ];
    score(i,:) = score(i,:) + circshift([1 2 3],i-1);%choice score
end
for i = 1:numel(score)
    rule.(rule_f(i)) = score(i); %rule structure
end

%% part 1
S1 = S;
for i = 1:3
    S1(S == sets(i,1) | S == sets(i,2)) = RPS(i); %replace A,X .. RPS
end
S1 = S1.join('');

sum(arrayfun(@(x) rule.(x),S1))

%% part 2
% new rules shift choice with circshift
score = zeros(3);% new score
for i = 1:3
    score(i,:) = score(i,:) + circshift([0 3 6],i-1); % win score 2nd RPS
    score(i,:) = score(i,:) + circshift([3 2 1],-(i-1)); % choice score 1st RPS counter
end
for i = 1:numel(score)
    rule.(rule_f(i)) = score(i); %rule structure
end

sum(arrayfun(@(x) rule.(x),S1))

