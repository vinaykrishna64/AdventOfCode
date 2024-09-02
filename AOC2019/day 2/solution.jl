S = readlines("input.txt");
S = split(S[1],",");
S = parse.(Int64,S);
S = Dict{Int, Int}(zip(0:length(S)-1, S))

function runProg(S,n=12,v=2)
    S[1],S[2] = n,v
    trk = 0;
    while S[trk] != 99
        if S[trk] == 1
            S[S[trk+3]] = S[S[trk+1]] + S[S[trk+2]];
        elseif S[trk] == 2
            S[S[trk+3]] = S[S[trk+1]] * S[S[trk+2]];
        else
            error("Invalid opcode")
        end
        trk += 4;
    end
    return S[0]
end

using Printf
@printf("part 1 = %d\n",runProg(copy(S)))

for i in 0:99
    for j in 0:99
        if runProg(copy(S),i,j) == 19690720
           @printf("part 2 = %d\n",i*100+j)
        end
    end
end