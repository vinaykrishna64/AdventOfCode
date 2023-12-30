clear all
clc
filename = 'input.txt';
S = readlines(filename);

M = dictionary();
M2 = dictionary();
for idx = 1:numel(S)
    s = S(idx).split(' = ');
    if contains(s(1),"mask")
        mask = char(s(2));
    else
        key = s(1).extractBetween('[',']');
        %% part 1
        Val = dec2bin(str2double(s(2)),36);
        Val(mask ~= 'X') =  mask(mask ~= 'X');
        M(key) = Val;
        %% part 2
        address = dec2bin(str2double(key),36);
        N = sum(mask == 'X'); 
        rplc = dec2bin(0:(2^N-1),N);
        for idx = 1:size(rplc,1)
            sub_addr = address;
            sub_addr(mask == 'X') = rplc(idx,:);
            sub_addr(mask == '1') = '1';
            M2(sub_addr) = str2double(s(2));
        end
    end
end

K = keys(M);
P1 = 0; 
for idx = 1:numel(K)
    P1 = P1 + bin2dec(M(K(idx)));
end
K = keys(M2);
P2 = 0;
for idx = 1:numel(K)
    P2 = P2 + M2(K(idx));
end


fprintf('part 1 = %14d \n',P1)

fprintf('part 2 = %14d \n',P2)

