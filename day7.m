clc
clear all
tic
fid = fopen('day7.txt');

line_1 = fgetl(fid);
S = split(line_1,',');


for i = 1:length(S)
    start(i) = str2num(S{i});
end
END = max(start);
tab = repmat([1:END], length(start),1);
move = abs(tab - start');
%% part 1
fuel = move;
[f,x] = min(sum(fuel))

%% part 2
fuel = move.*(move+1)/2;
[f,x] = min(sum(fuel))