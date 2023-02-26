clear all
filename = 'input.txt';
S = readlines(filename).replace(["nop","jmp","acc"],["0","1","2"]);
S = str2double(S.split(' '));
i = 1;
I = 1;
acc = 0;
while i <= size(S,1)
    if S(i,1) == 2
        acc = acc + S(i,2);
    elseif S(i,1) == 1
        i = i + S(i,2) - 1;
    end
    i = i+1;
    if sum(I == i) == 1
        disp(sprintf('part_1 = %d',acc))
        break
    end
    I = [I i];
end
%%
ops = find(S(:,1) == 1 | S(:,1) == 0);
for j = 1:numel(ops)
    flg = 1;
    S2 = S;
    S2(ops(j),1) = 1 - S2(ops(j),1);
    i = 1;
    I = 1;
    acc = 0;
    while i <= size(S,1)
        if S2(i,1) == 2
            acc = acc + S(i,2);
        elseif S2(i,1) == 1
            i = i + S2(i,2) - 1;
        end
        i = i+1;
        if  100*size(S,1) < numel(I)
            flg = 0;
            break
        end
        I = [I i];
    end
    if flg == 1
        disp(sprintf('part_2 = %d',acc))
        break
    end
end


