clear all
clc

S = readlines("input.txt").erase(["would ","happiness units by sitting next to ","gain "]...
    ).replace(["lose "],["-"]).split(" ");

guys = unique(S(:,1));
S = str2double(S.replace(guys,string([1:numel(guys)]')));
happy_mat = zeros(numel(guys));
happy_mat(sub2ind(size(happy_mat),S(:,1),S(:,3))) = S(:,2);
%% part 1
seats = perms(1:numel(guys));
seats = [seats(:,end) seats seats(:,1)];
for i = 1:size(seats,1)
    r = [seats(i,2:end-1) seats(i,2:end-1)];
    c = [seats(i,1:end-2) seats(i,3:end)];
    hap(i) = sum(happy_mat(sub2ind(size(happy_mat),r,c)));
end
[part_1, idx] = max(hap);

part_1
figure
subplot(1,2,1)
G = graph(guys( seats(idx,1:end-2)),guys( seats(idx,2:end-1)));
plot(G)
title("seats for part 1")

%% part 2
guys(end+1) = "ME";
happy_mat(end+1,:) = 0;
happy_mat(:,end+1) = 0;
seats = perms(1:numel(guys));
seats = [seats(:,end) seats seats(:,1)];
for i = 1:size(seats,1)
    r = [seats(i,2:end-1) seats(i,2:end-1)];
    c = [seats(i,1:end-2) seats(i,3:end)];
    hap(i) = sum(happy_mat(sub2ind(size(happy_mat),r,c)));
end
[part_2, idx] = max(hap);

part_2

subplot(1,2,2)
G = graph(guys( seats(idx,1:end-2)),guys( seats(idx,2:end-1)));
plot(G)
title("seats for part 2")
exportgraphics(gcf,'seating arrangements.jpeg','Resolution',1200)