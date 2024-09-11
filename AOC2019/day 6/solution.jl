S = readlines("input.txt");
S = split.(S,")");

function makedict(S)
    Sd = Dict()
    Sdr = Dict()
    for idx in 1:length(S)
        if haskey(Sd,S[idx][1])
            push!(Sd[S[idx][1]],S[idx][2]);
        else
            Sd[S[idx][1]] = [S[idx][2]];
        end
            Sdr[S[idx][2]] = [S[idx][1]];  
    end
    return Sd,Sdr
end
Sd,Sdr = makedict(S);

function getorbits(Sd,k,orbs=0)
    if haskey(Sd,k)
        for v in Sd[k]
            orbs = getorbits(Sd,v,orbs+1);
        end
    end
    return orbs
end
function P1(Sd)
    p1 = 0
    for k in keys(Sd)
        p1 += getorbits(Sd,k)
    end
    return p1
end 
using Printf
@printf("part 1 = %d\n",P1(Sd))


function getpaths(Sdr,k,path2com=[])
    if haskey(Sdr,k)
        for v in Sdr[k]
            path2com = getpaths(Sdr,v,push!(path2com,v));
        end
    end
    return path2com
end


Y2C = getpaths(Sdr,"YOU") 
S2C = getpaths(Sdr,"SAN")
I2C = collect(intersect(Y2C,S2C))
@printf("part 2 = %d\n",length(S2C) + length(Y2C) -2*length(I2C))