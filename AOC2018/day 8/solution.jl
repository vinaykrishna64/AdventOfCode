S = readlines("input.txt");
S = split.(S[1]," ");
S = parse.(Int64,S)

function Maneuver(S,tot = 0)
    N = popfirst!(S)
    M = popfirst!(S)
    for idx in 1:N
        tot += Maneuver(S) 
    end 
    return tot + sum([popfirst!(S) for idx in 1:M])
end
using Printf
@printf("part 1 = %d\n", Maneuver(copy(S)))


function Maneuver2(S,vals = [])
    N = popfirst!(S)
    M = popfirst!(S)
    for idx in 1:N
        push!(vals, Maneuver2(S))
    end 
    metas = [popfirst!(S) for idx in 1:M]
    if N == 0
        return sum(metas)
    end
    out = 0
    for i in metas
        if i in 1:N
            out += vals[i]
        end
    end
    return out
end
@printf("part 2 = %d\n", Maneuver2(copy(S)))