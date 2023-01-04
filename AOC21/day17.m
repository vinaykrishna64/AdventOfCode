% puzzle input
%%% target area: x=117..164, y=-140..-89
clc
clear all

TX = [117 , 164];
TY = [-140 ,-89];
% y_max occurs at  t = V0+1/2  and since that is not possible as steps are
% 1 it's V0 or V0 +1 and both give the same value
% Y_sym = t*V0 - (t*(t-1))/2;
% Y_sym_1 = diff(Y_sym,t);
% s = solve(Y_sym_1 == 0,[t]);%t for y_max

%% part 1

y_max = @(vy)  (vy.*(vy+1))/2;

u = -TX(2)*3:TX(2)*3;
[U,V] = meshgrid(u);
V0  = V;
U0  = U;
x = zeros(size(U));
y = zeros(size(U));
hits = zeros(size(U));

for i = 1:10000
    x = x + U;
    y = y + V;
    U = U - sign(U);
    V = V - 1;
    [I,J] = find ( (TX(1) <= x & x <= TX(2)) & ( TY(1) <= y & y <= TY(2)));
    if length(I)
        hits(I,J) = 1;
    end
end

I = find(hits == 1);
%part 1
ans_1 = max(y_max(unique(V0(I))))
%part 2
ans_2 = sum(hits,'all')










