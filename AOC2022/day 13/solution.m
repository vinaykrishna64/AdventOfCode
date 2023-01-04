clear all
clc
S = readlines("input.txt");

n = (numel(S)+1)/3;
%% part 1
for i = 1:n
    [C1,C2] = get_cells(S(1 +3*(i-1)),S(2 +3*(i-1)));
    l(i) = compare(C1,C2,1);
end

part_1 = sum(find(l == 1)) 

%% part 2
S2 = S(S ~= "");
S2 = [S2; "[[2]]" ; "[[6]]"];
order = 0;
while order < numel(S2)-1
    for i = 1:numel(S2)-1
        [C1,C2] = get_cells(S2(i),S2(i+1));
        L = compare(C1,C2,1);
        if ~L
            temp = S2(i);
            S2(i) = S2(i+1);
            S2(i+1) = temp;
        end
    end
    for i = 1:numel(S2)-1
        [C1,C2] = get_cells(S2(i),S2(i+1));
        l(i) = compare(C1,C2,1);
    end
    order = sum(l);
end
part_2 = sum(find(S2 == "[[2]]") * find(S2 == "[[6]]"))
%% function
function [L,flg] = compare(C1,C2,flg)
    n1 = numel(C1);
    n2 = numel(C2);
    if flg %execution flag to stop recursion
        L = 0;
        if n1 <= n2
            if n1
                for i = 1:n1
                    if iscell(C1{i}) + iscell(C2{i})  == 0
                        if C1{i} < C2{i}
                            L = 1;
                            disp('Left side is smaller')
                            flg = 0;
                            return
                        elseif C1{i} > C2{i}
                            disp('Right side is smaller')
                            flg = 0;
                            return
                        else
                            continue
                        end
                    elseif iscell(C1{i}) + iscell(C2{i})  == 1
                        if ~iscell(C1{i})
                            [L,flg] = compare({C1{i}},C2{i},flg);
                            if ~flg
                                flg = 0;
                                return
                            end
                        else
                            [L,flg] = compare(C1{i},{C2{i}},flg);
                            if ~flg
                                flg = 0;
                                return
                            end
                        end
                    else
                      [L,flg] = compare(C1{i},C2{i},flg);
                      if ~flg
                            flg = 0;
                            return
                      end
                    end
                end
                if n1 < n2
                    L = 1;
                    disp('left side ran out')
                    flg = 0;
                    return
                end
            else
                if n1 == 0 & n2 == 0
                    return
                else
                    L = 1;
                    disp('left side ran out')
                    flg = 0;
                    return
                end
            end
        else
            if n2
                for i = 1:n2
                    if iscell(C1{i}) + iscell(C2{i})  == 0
                        if C1{i} < C2{i}
                            L = 1;
                            disp('Left side is smaller')
                            flg = 0;
                            return
                        elseif C1{i} > C2{i}
                            disp('Right side is smaller')
                            flg = 0;
                            return
                        else
                            continue
                        end       
                    elseif iscell(C1{i}) + iscell(C2{i})  == 1
                        if ~iscell(C1{i}) 
                            [L,flg] = compare({C1{i}},C2{i},flg);
                            if ~flg
                                flg = 0;
                                return
                            end
                        else
                            [L,flg] = compare(C1{i},{C2{i}},flg);
                            if ~flg
                                flg = 0;
                                return
                            end
                        end
                    else
                        [L,flg] = compare(C1{i},C2{i},flg);
                        if ~flg
                            flg = 0;
                            return
                        end
                    end
                end
                disp('right side ran out')
                flg = 0;
                return
            else
                if n1 == 0 & n2 == 0
                    return
                else
                    disp('right side ran out')
                    flg = 0;
                    return
                end
            end
        end
    else
        flg = 0;
        return
    end
end


function [C1,C2] = get_cells(S1,S2)
s1 = S1.replace(["[","]"],["{","}"]);
C1 = eval(s1);
s2 = S2.replace(["[","]"],["{","}"]);
C2 = eval(s2);
end

