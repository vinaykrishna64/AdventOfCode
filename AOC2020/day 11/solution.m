clear all
clc
filename = 'input.txt';
S = readlines(filename).replace(["L","."],["2","0"]).split('');
S = str2double(S(:,2:end-1));
S = padarray(S,[1,1],0);
%floor - 0 seat - 1 occupied seat -2 unoccupied
S_inp = S;
while true
    S_n = next_round(S);
    if all(S_n == S)
        break
    end
    S = S_n;
end
disp(sprintf('part_1 = %d',sum(S == 1 ,'all')))

S = S_inp;

while true
    S_n = next_round2(S);
    if all(S_n == S)
        break
    end
    S = S_n;
end
disp(sprintf('part_2 = %d',sum(S == 1 ,'all')))



function S_n = next_round(S)
    S_n = S;
    for i = 2:size(S,1)-1
        for j = 2:size(S,2)-1
            x = sum(S(i-1:i+1,j-1:j+1)==1,'all') - (S(i,j)==1);
            if S(i,j) == 2
                if  x == 0
                    S_n(i,j) = 1;
                end
            elseif S(i,j) == 1
                if  x >= 4
                    S_n(i,j) = 2;
                end
            end
        end
    end
end



function S_n = next_round2(S)
    S_n = S;
    for i = 2:size(S,1)-1
        for j = 2:size(S,2)-1
            x = seats(S,i,j);
            if S(i,j) == 2
                if  x == 0
                    S_n(i,j) = 1;
                end
            elseif S(i,j) == 1
                if  x >= 5
                    S_n(i,j) = 2;
                end
            end
        end
    end
    function x = seats(S,i,j)
        x = 0;
        % each direction hard code:(
        for I = i-1:-1:1 %North
            if S(I,j) == 1 | S(I,j) == 2
                x = x + (S(I,j) == 1);
                break
            end
        end
        for I = i+1:size(S,1) %south
            if S(I,j) == 1 | S(I,j) == 2
                x = x + (S(I,j) == 1);
                break
            end
        end
        for I = j-1:-1:1 %west
            if S(i,I) == 1 | S(i,I) == 2
                x = x + (S(i,I) == 1);
                break
            end
        end
        for I = j+1:size(S,2) %east
            if S(i,I) == 1 | S(i,I) == 2
                x = x + (S(i,I) == 1);
                break
            end
        end
        for I = 1:(min(i,j)-1) %northwest
            if S(i-I,j-I) == 1 | S(i-I,j-I) == 2
                x = x + (S(i-I,j-I) == 1);
                break
            end
        end
        for I = 1:(min(size(S,1)-i,j)-1) %southwest
            if S(i+I,j-I) == 1 | S(i+I,j-I) == 2
                x = x + (S(i+I,j-I) == 1);
                break
            end
        end
        for I = 1:(min(i,size(S,2)-j)-1) %northeast
            if S(i-I,j+I) == 1 | S(i-I,j+I) == 2
                x = x + (S(i-I,j+I) == 1);
                break
            end
        end
        for I = 1:(min(size(S,1)-i,size(S,2)-j)-1) %southeast
            if S(i+I,j+I) == 1 | S(i+I,j+I) == 2
                x = x + (S(i+I,j+I) == 1);
                break
            end
        end
    end
        
end