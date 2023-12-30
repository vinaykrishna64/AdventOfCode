clear all
clc
filename = 'input.txt';
S = readlines(filename);
P1 = 0; P2 = 0;
for idx = 1:numel(S)
    P1 = P1 + str2num(doMath(char(S(idx)),1));
    P2 = P2 + str2num(doMath(char(S(idx)),2));
end
fprintf('part 1 = %14d \n',P1)
fprintf('part 1 = %14d \n',P2)

function out = doMath(S,opt)
    while find(S == '(')
        % get open close pairs
        O = [find(S == '('), numel(S)+1];
        % eval an inner bracket
        for idx = 1:numel(O)
            C = find(S(O(idx)+1:end) == ')',1) + O(idx);
            if O(idx+1) > C
                bkt = L2R_ops(S(O(idx)+1:C-1),opt);
                S = [S(1:O(idx)-1) bkt S(C+1:end)];
                break
            end
        end
    end
    out = L2R_ops(S,opt);
end

function out = L2R_ops(S,opt)
    out = S;
    if opt == 1 %plain left 2 right
        while find(out == ' ')
            I = find(out == ' ');
            if numel(I) == 2
                out = num2str(eval(out));
            else
                out = [num2str(eval(out(1:I(3)-1))) out(I(3):end)];
            end
        end
    else % addition over muliplication
        while find(out == '+' | out == '*')
            I = [0 find(out == '+' | out == '*') numel(out)+1];
            if find(out == '+')
                for idx = 2:numel(I)-1
                    if out(I(idx)) == '+'
                        out = [out(1:I(idx-1)) ' ' num2str(eval(out(I(idx-1)+1:I(idx+1)-1))) ' ' out(I(idx+1):end)];
                        break
                    end
                end
            else
                for idx = 2:numel(I)-1
                    out = [out(1:I(idx-1)) ' ' num2str(eval(out(I(idx-1)+1:I(idx+1)-1))) ' ' out(I(idx+1):end)];
                    break
                end
            end
        end
    end
end