clear all
clc
filename = 'input.txt';
S = readlines(filename);
S = str2double(S.split(","));

M1 = dictionary(S,[1:numel(S)]');
M2 = dictionary(S,NaN(numel(S),1));
C = numel(S);
last = S(end);
while C < 30000000
    C = C+1;
    if ~isnan(M2(last))
         V = M2(last) - M1(last);
         last = V;
         if isKey(M1,V)
            if ~isnan(M2(last)) 
                M1(last) = M2(last);
                M2(last) = C;
            else
                M2(last) = C;
            end
         else
            M1(last) = C;
            M2(last) = nan;
         end
    else
        last = 0;
        if ~isnan(M2(last)) 
            M1(last) = M2(last);
            M2(last) = C;
        else
            M2(last) = C;
        end
    end

    if C == 2020
        fprintf('part 1 = %14d \n',last)
    end
end

fprintf('part 2 = %14d \n',last)

