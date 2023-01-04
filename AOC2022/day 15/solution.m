clear all
clc

S = str2double(readlines("input.txt").replace(["Sensor at x="," y=",": closest beacon is at x="],[" "," ",","]).split(","));

mandist = @(P1,P2) abs(P1(:,1) - P2(:,1)) + abs(P1(:,2) - P2(:,2));

Db = mandist(S(:,1:2),S(:,3:4)); %sensor beacondistance



y = 2000000;
B = []; 
for i = 1:size(S,1)
   D(i) = Db(i) - abs(y - S(i,2));
   if D(i) >= 0
        B = [B; S(i,1) + [-1 1]*D(i)];
   end
end
Bmin = min(B(:,1));
Bmax = max(B(:,2));
x = Bmin:Bmax;
b = zeros(size(x));
for i = 1:size(B,1)
    b(x >= B(i,1) & x <= B(i,2)) = 1;
end
part_1 = sum(b) - 1


%%

xmin = min(S(:,1),[],"all");
xmax = max(S(:,1),[],"all");
ymin = min(S(:,2),[],"all");
ymax = max(S(:,2),[],"all");
flg = 0;

for j = ymin:ymax
    BB = [];
    for i = 1:size(S,1)
        D(i) = Db(i) - abs(j - S(i,2));
        if D(i) >= 0
             B =  S(i,1) + [-1 1]*D(i);
             BB = [BB; B];
        end
    end    
    BB(BB < xmin) = xmin;
    BB(BB > xmax) = xmax;
    [~,I] = sort(BB(:,2));
    BB = BB(I,:);
    % find the gap in interval approach
    for k = 1:size(BB,1)-1
        b = BB(k+1:end,1);
        I =  BB(k+1,2) > BB(k,2);
        if sum(b <= BB(k,2)) == 0
            X = BB(k,2)+1;
            Y = j;
            flg = 1;
            break
        end
    end
    if flg
        break
    end
end

part_2 = 4000000*X + Y
