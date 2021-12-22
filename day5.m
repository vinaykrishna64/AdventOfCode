clc
clear all

fid = fopen('day5.txt');
n = 1;
while n <= 500
    line_1 = fgetl(fid);
    S = split(line_1,' -> ');
    S1 = split(S{1},',');
    S2 = split(S{2},',');
    P(n,1:2) = [str2num(S1{1}) , str2num(S1{2})];
    P(n,3:4) = [str2num(S2{1}) , str2num(S2{2})];
    n = n + 1;
end

%% only h/v lines 
I = find((P(:,1) == P(:,3)) | (P(:,2) == P(:,4)) | (abs(P(:,1) - P(:,3)) == abs(P(:,2) - P(:,4))));
p = P(I,:);
n = 1000;
N = zeros(n);
for i = 1:n
    for j = 1:n
       N(i,j) = overlaps(j-1,i-1,p);
    end
end
N = N';
sum(N >= 2,'all')
%% function
function n = overlaps(I,J,P)
dist = @(x,y) sqrt((x(:,1)-x(:,2)).^2 + (y(:,1)-y(:,2)).^2);
sz = size(P);
x = I*ones(sz(1),1);
y = J*ones(sz(1),1);
cb = dist([x,P(:,3)],[y,P(:,4)]);
ac = dist([P(:,1),x],[P(:,2),y]);
ab = dist([P(:,1),P(:,3)],[P(:,2),P(:,4)]);
n = sum( abs(ab -(ac+cb)) <= 10^-5);
end