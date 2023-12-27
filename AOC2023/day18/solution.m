clear all
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split(' ');
S1 = S(:,1);
S2 = str2double(S(:,2));
S3 = char(S(:,3).extractBetween('#',')'));
p = [0,0];
visits = p;
for idx = 1:numel(S1)
    if strcmp(S1(idx),"R")
        visits = [visits; visits(end,:) + [0,1].*[1,S2(idx)]'];
    elseif strcmp(S1(idx),"D")
        visits = [visits;visits(end,:) + [1,0].*[1,S2(idx)]'];
    elseif strcmp(S1(idx),"L")
        visits = [visits;visits(end,:) + [0,-1].*[1,S2(idx)]'];
    elseif strcmp(S1(idx),"U")
        visits = [visits;visits(end,:) + [-1,0].*[1,S2(idx)]'];
    end
end
visits = visits + abs(min(visits,[],1)) +1;
x = visits(:,1);
y = visits(:,2);

fprintf('part 1 = %14d \n',1+trapz(x,y) + sum(abs(diff(x)) +abs(diff(y)))/2) % interior area + euclidean perimeter/2 + 1 
% interior area accounts for half the perimeter - 1 + any interior points
% you add the other half to it to complete it 
% perimeter is always even given the gridded nature of the problem
%% part 2
p = [0,0];
visits = p;
for idx = 1:numel(S1)
    D = hex2dec(S3(idx,1:5));
    if strcmp(S3(idx,6),"0")
        visits = [visits; visits(end,:) + [0,1].*[1,D]'];
    elseif strcmp(S3(idx,6),"1")
        visits = [visits;visits(end,:) + [1,0].*[1,D]'];
    elseif strcmp(S3(idx,6),"2")
        visits = [visits;visits(end,:) + [0,-1].*[1,D]'];
    elseif strcmp(S3(idx,6),"3")
        visits = [visits;visits(end,:) + [-1,0].*[1,D]'];
    end
end
visits = visits + abs(min(visits,[],1)) +1;
x = visits(:,1);
y = visits(:,2);

fprintf('part 2 = %14d \n',1+trapz(x,y) + sum(abs(diff(x)) +abs(diff(y)))/2) % interior area + perimeter/2 + 1 


