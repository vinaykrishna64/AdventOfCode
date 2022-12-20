clear all
clc

S = str2double(readlines("input.txt"))';
N = numel(S);
%% part 1
I_t = 1:numel(S); %index track

[I_t] = mix_decrypt(S,I_t);
S_decrypt = S(I_t);

I = find(S_decrypt == 0);
for i = 1:3
    temp = circshift(S_decrypt,-mod(i*1000,N));
    coords(i) = temp(I);
end

part_1 = sum(coords)
%% part 2
key = 811589153;
S2 = S*key;
I_t = 1:N; %index track
for mixes = 1:10 %repetitions
   [I_t] = mix_decrypt(S2,I_t);
end
S2_decrypt = S2(I_t);

I = find(S2_decrypt == 0);
for i = 1:3
    temp = circshift(S2_decrypt,-mod(i*1000,N));
    coords(i) = temp(I);
end

part_2 = sum(coords);
fprintf('part 2 =  %14d \n',part_2)


%% function
function [I_t] = mix_decrypt(S,I_t)
    N = numel(S);
    for i = 1:N
       I = find(I_t == i);
       mv = mod(S(i) + I,N-1);
       if mv < 1
           mv = N - mv - 1;
       end
       if S(i) ~= 0 
           if I == 1
               I_t = [I_t(2:mv) I_t(I) I_t(mv+1:end)];
           elseif I == N
               I_t = [I_t(1:mv-1) I_t(I) I_t(mv:end-1)];
           else
               I_temp = I_t(I_t ~= I_t(I));
               I_t = [I_temp(1:mv-1) I_t(I) I_temp(mv:end)];
           end
       end
    end
end


