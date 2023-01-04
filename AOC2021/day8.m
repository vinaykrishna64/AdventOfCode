clear all
clc
S = readlines("day8.txt");

%% part1
count = 0;
for i = 1:numel(S)
    s = S(i).split("| ");
    s = s(2).split(" ");
    n = arrayfun(@(x) numel(char(x)),s);
    count  = count + sum(n == 2) + sum(n == 4) + sum(n == 3) + sum(n == 7);
end
part_1 = count
%% part 2
for i = 1:numel(S)
    val(i) = decode(S(i));
end
part_2 = sum(val)

function [val] = decode(S)
   s = S.split("| ");
    s = strcat(s(1),s(2)).split(" ");
    s = arrayfun(@(x) string(sort(char(x))),s);
    n = arrayfun(@(x) numel(char(x)),s);
    %    1
    % 2     3
    %    4
    % 5     6
    %    7
    
    S1 = string(char(s(find(n == 2,1)))');% 1 is two elements
    S7 = string(char(s(find(n == 3,1)))');% 7 is three elements
    S4 = string(char(s(find(n == 4,1)))'); % 4 is for 4 elements 
    S8 = string(char(s(find(n == 7,1)))'); % 8 is for all elements 
    % find 3 using 1... 5 has both elements in 1
    for i = 1:numel(n)
        if n(i) == 5
            ss = string(char(s(i))');
            if strjoin(intersect(ss,S1),"") == strjoin(S1,"")
                S3 = ss;
                break
            end
        end
    end
    % find 9 using 4... 9 has all elements in 4
    for i = 1:numel(n)
        if n(i) == 6
            ss = string(char(s(i))');
            if strjoin(intersect(ss,S4),"") == strjoin(S4,"")
                S9 = ss;
                break
            end
        end
    end
    % find 0 using 7&4 ... 0 has all elements in 7 but not 4
    for i = 1:numel(n)
        if n(i) == 6
            ss = string(char(s(i))');
            if strjoin(intersect(ss,S4),"") ~= strjoin(S4,"") &...
                    strjoin(intersect(ss,S7),"") == strjoin(S7,"")
                S0 = ss;
                break
            end
        end
    end
    % find 6 using 0&9 ... 6 is size 6 but not 0/9
    for i = 1:numel(n)
        if n(i) == 6
            ss = string(char(s(i))');
            if strjoin(intersect(ss,S9),"") ~= strjoin(S9,"") &...
                    strjoin(intersect(ss,S0),"") ~= strjoin(S0,"")
                S6 = ss;
                break
            end
        end
    end
    
    % FIND element 1
    pieces = S7.erase(intersect(S1,S7));
    pieces = pieces(pieces ~= ""); 
    % FIND element 4
    temp = S8.erase(intersect(S8,S0));
    pieces(4) = temp(temp ~= ""); 
    % FIND element 2
    pieces(2) = setdiff(S4,[S1;pieces(4)]);
    % FIND element 7
    temp = setdiff(S3,S1);
    pieces(7) = setdiff(temp,[pieces(1);pieces(4)]);
    % find 5 using piece2 ... 5 is size 5 and has piece 2
    for i = 1:numel(n)
        if n(i) == 5
            ss = string(char(s(i))');
            if  sum(contains(ss,pieces(2))) 
                S5 = ss;
                break
            end
        end
    end
    % FIND element 5
    pieces(5) = setdiff(S6,S5);
    % FIND element 6
    pieces(6) = setdiff(S5,[pieces(1);pieces(2);pieces(4);pieces(7)]);
    % FIND element 3
    pieces(3) = setdiff(S1,pieces(6));
    % find 2 using pieces
    S2 = [pieces(1);pieces(3);pieces(4);pieces(5);pieces(7)];
    S2 = string(sort(char(S2)));
    code = [strjoin(S0,"");strjoin(S1,"");strjoin(S2,"");strjoin(S3,"");strjoin(S4,"");...
        strjoin(S5,"");strjoin(S6,"");strjoin(S7,"");strjoin(S8,"");strjoin(S9,"")];
    for i = 11:14
        out(i-10) = find(s(i) == code)-1;
    end 
    val = sum(out .* 10.^(3:-1:0));
end