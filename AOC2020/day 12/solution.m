clear all
clc
filename = 'input.txt';
S = char(readlines(filename));
Dir = string(S(:,1)); Dist = str2double(string(S(:,2:end)));
face = {[0;1],[1;0],[0;-1],[-1;0]}; %E S W N
f = ["E", "S", "W", "N"];
M = containers.Map(f,face);
Loc = [0;0]; 
WP = [-1;10]; % WP rel to ship
shp = [0;0]; % absolute location of ship
for i = 1:numel(Dir)
    if Dir(i) == "F"
        Loc = Loc + Dist(i)*M(f(1));
        shp = shp + WP*Dist(i);
    elseif Dir(i) == "R"
        f = circshift(f,-Dist(i)/90);
        R = rotx(-Dist(i));
        WP = R(2:3,2:3)*WP;
    elseif Dir(i) == "L"
        R = rotx(Dist(i));
        f = circshift(f,Dist(i)/90);
        WP = R(2:3,2:3)*WP;
    else
        Loc = Loc + Dist(i)*M(Dir(i));
        WP = WP + Dist(i)*M(Dir(i));
    end
end

disp(sprintf('part_1 = %d',sum(abs(Loc))))

disp(sprintf('part_2 = %d',sum(abs(shp))))


