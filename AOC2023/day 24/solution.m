clear all
%% preparation
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split(' @ ');
pos = str2double(S(:,1).split(', '));
vel = str2double(S(:,2).split(', '));

p1 = 0;
lims = [200000000000000 400000000000000];

for idx = 1:length(S)
    for jdx = (idx+1):length(S)
        p1 = p1 + part_1_solver(pos(idx,:),pos(jdx,:),vel(idx,:),vel(jdx,:),lims);
    end
end
fprintf('part 1 = %14d \n',p1)

S = part_2_solver(pos,vel);
fprintf('part 2 = %14d \n',S.x + S.y + S.z)
function [out,X] = part_1_solver(p1,p2,v1,v2,lims)
    out = 0;
    % projectile line
    % vy*X - vx*Y + (py*vx -px*vy) = 0
    % vy*X - vx*Y  = (-py*vx  + px*vy)
    A = [v1(2) -v1(1); v2(2) -v2(1)];
    B = [-p1(2)*v1(1)+p1(1)*v1(2); -p2(2)*v2(1)+p2(1)*v2(2)];
    X = A\B;
    t1 = (X(1) - p1(1)) / v1(1); t2 = (X(1) - p2(1)) / v2(1);
    if all( X >= lims(1) & X <= lims(2)) & (t1 >=0 & t2 >= 0)
        out = 1;
    end
end

function [S] = part_2_solver(pos,vel)
    eqn = [];
    syms x y u v 
    for idx = 1:length(pos)
        eqn = [eqn; (x - pos(idx,1))*(v - vel(idx,2)) == (y - pos(idx,2))*(u - vel(idx,1))];
    end
    S = solve(eqn,[x y u v]);
    % solve z stuff with first two point
    t1 = (S.x - pos(1,1))/(S.u - vel(1,1));
    t2 = (S.x - pos(2,1))/(S.u - vel(2,1));
    A = [1 abs(t1); 1 abs(t2)];
    B = [pos(1,3)+abs(t1)*vel(1,3); pos(2,3)+abs(t2)*vel(2,3)];
    X = A\B;
    S.z = X(1); S.w = X(2);
end
