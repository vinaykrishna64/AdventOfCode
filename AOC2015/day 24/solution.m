clear all
clc
S = [1
2
3
4
5
7
8
9
10
11];
S = [1
3
5
11
13
17
19
23
29
31
41
43
47
53
59
61
67
71
73
79
83
89
97
101
103
107
109
113]; %% all primes
S = flip(S);
visits = zeros(size(S));
% fprintf("part_1 = %14d \n",min_quantE(S,3,1e100,0,0,visits,100))
fprintf("part_2 = %14d \n",min_quantE(S,4,1e100,0,0,visits,100))
function [minE,FC] = min_quantE(S,p_no,minE,E,gp,visits,FC)
    if E > minE
        return
    end
    N = sum(S)/p_no;
    if gp == 0 
        if sum(S(visits == 1)) == N
            E = prod(S(visits == 1));
            gp = gp +1;
        elseif sum(S(visits == 1)) > N
            return
        end
    elseif gp > 0 & gp < p_no 
        if sum(S(visits ~= 0)) == (gp+1)*N
            [B,BG] = groupcounts(visits);
            if any(B(3:end) < B(2))
                return
            elseif B(2) > FC
                return
            end
            gp = gp +1;
        elseif sum(S(visits ~= 0)) > (gp+1)*N
            return
        end
    end
    if gp == p_no - 1
        visits(visits == 0) = p_no;
        [B,BG] = groupcounts(visits);
        for jdx = 1:p_no
            E_vals(jdx) = prod(S(visits == jdx));
        end
        BG(B~= min(B)) = [];
        E_vals(B~= min(B)) = [];
        [~,ii] = min(E_vals);
        if minE>E_vals(ii) & B(ii)<= FC
            FC = B(ii);
            minE = E_vals(ii);
        elseif B(ii)< FC
            FC = B(ii);
            minE = E_vals(ii);
        end
        return
    end
    for idx = 1:numel(S)
        if visits(idx) == 0
           dummy = visits;
           dummy(idx) = gp+1;
           [minE,FC] = min_quantE(S,p_no,minE,E,gp,dummy,FC);
        end
    end
end



