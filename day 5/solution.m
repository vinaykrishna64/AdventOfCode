clear all
clc
S = readlines('input.txt');
I = find(S == "");
crate_char = S(1:I-2).char();
sz = size(crate_char);
for x = 1:ceil(sz(2)/4)
    C{x} =[];
    for y = 1:sz(1)
        if crate_char(y,4*x-2) ~= ' '
            C{x}= [C{x} crate_char(y,4*x-2)];
        end
    end
end

moves_str = S(I+1:end);
for i = 1:numel(moves_str)
    temp = moves_str(i).split(' ');
    move = str2double(temp(2:2:end));
    M_str = flip(C{move(2)}(1:move(1)));
    C{move(3)} = strcat(M_str,C{move(3)});
    C{move(2)} = C{move(2)}(move(1)+1:end);
end

top_str = cellfun(@(x) x(1),C) %part 1

%%
clear all
S = readlines('input.txt');
I = find(S == "");
crate_char = S(1:I-2).char();
sz = size(crate_char);
for x = 1:ceil(sz(2)/4)
    C{x} =[];
    for y = 1:sz(1)
        if crate_char(y,4*x-2) ~= ' '
            C{x}= [C{x} crate_char(y,4*x-2)];
        end
    end
end

moves_str = S(I+1:end);

moves_str = S(I+1:end);
for i = 1:numel(moves_str)
    temp = moves_str(i).split(' ');
    move = str2double(temp(2:2:end));
    M_str = C{move(2)}(1:move(1));
    C{move(3)} = strcat(M_str,C{move(3)});
    C{move(2)} = C{move(2)}(move(1)+1:end);
end

top_str = cellfun(@(x) x(1),C) %part 2
