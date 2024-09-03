S = readlines("input.txt");
S = split.(S,",");

function parse2segments(Lstr)
    d2p = Dict('R' => [1,0],'L' =>[-1,0],'U' => [0,1],'D' =>[0,-1])
    point = [0,0]
    points = [point]
    for idx in 1:length(Lstr)
        for jdx in 1:parse(Int64,Lstr[idx][2:end])
            point = point + d2p[Lstr[idx][1]];
            push!(points,point)
        end
    end
    return points
end
global L1,L2
L1 = parse2segments(S[1]);
L2 = parse2segments(S[2]); 
Lint = L2[findall(in(L1),L2)];
D = x-> abs(x[1]) + abs(x[2]);
d = D.(Lint);
order = sortperm(d)
using Printf
@printf("part 1 = %d\n",d[order[2]])

function stepcost(p)
    return findfirst(==(p),L1)+findfirst(==(p),L2)-2
end
cost = sort!(stepcost.(Lint))
@printf("part 2 = %d\n",cost[2])