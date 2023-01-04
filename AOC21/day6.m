clc
clear all
tic
fid = fopen('day6.txt');

line_1 = fgetl(fid);
S = split(line_1,',');


for i = 1:length(S)
    start(i) = str2num(S{i});
end

for j = 1:9
    T(j) = sum(start == (j-1)); 
end
days = 256;
for i = 1:days
    T = day(T)
end

sprintf('%020d',sum(T))
function T = day(T)
T = circshift(T,-1);
T(7) = T(7) + T(9);
end

