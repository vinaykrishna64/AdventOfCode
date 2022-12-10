clear all
clc

S = readlines("input.txt").replace(["noop","addx"],["1 0","2"]).split(" ").double();

signal = [1];
for i = 1:size(S,1)
    signal =[signal; 0];
    if S(i,1) == 2   
        signal = [signal; S(i,2)];
    end
end

signal = cumsum(signal); %signal

%% part 1
end_L = floor((numel(signal)-20)/40);
locs = 20 + [0, 40*(1:end_L)]';
part_1 = sum(signal(locs).*locs)

%% part 2
screen = zeros(6,40);
for i = 1:numel(signal)
    row = floor(i/40);
    col = i - row*40;
    if abs(signal(i)+1 - col) <= 1
        screen(row+1,col) = 1;
    end
end

figure
imshow(imresize(1 - screen,10))
title('part 2 - CRT display')
exportgraphics(gcf,'CRT.jpeg','Resolution',1200)


%% Linear index idea to make it loopless

signal2 =  reshape(signal(1:end-1)+1, [40,6])';
IDX = repmat([1:40],6,1);
screen2 = abs(IDX - signal2) <= 1; %make drawing
screen2(end,end) = abs(40 - signal(end)) <= 1; %account for first operation
figure
imshow(imresize(1 - screen2,10))
title('part 2 - CRT display-loopless')



