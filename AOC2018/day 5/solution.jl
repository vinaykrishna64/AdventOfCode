S = readlines("input.txt");
S = S[1]
## map
l = collect('a':'z'); L = collect('A':'Z');
D = Dict('0' => '0'); d = Dict('0' => '0');
for idx = 1:length(l)
    global D[l[idx]] = L[idx]
    global d[L[idx]] = l[idx]
end
## removing 1 element at a time
function reduePolymer(S,d,D)
    s = []
    if haskey(D,S[1])
        if D[S[1]] != S[2]
            push!(s,S[1])
        else
            push!(s,S[3:length(S)])
            return join(s)
        end
    else
        if d[S[1]] != S[2]
            push!(s,S[1])
        else
            push!(s,S[3:length(S)])
            return join(s)
        end
    end
    for idx = 2:length(S)-2
        if haskey(D,S[idx])
            if D[S[idx]] == S[idx+1] 
                push!(s,S[idx+2:length(S)])
                return join(s)
            end
        elseif  d[S[idx]] == S[idx+1]
                push!(s,S[idx+2:length(S)])
                return join(s)
        end
        push!(s,S[idx])
    end
    if haskey(D,S[length(S)])
        if D[S[length(S)]] != S[length(S)-1]
            push!(s,S[length(S)-1:length(S)])
        end
    else
        if d[S[length(S)]] != S[length(S)-1]
            push!(s,S[length(S)-1:length(S)])
        end
    end
    return join(s)
end
## part 1
function final_length(S,D,d)
    while S != reduePolymer(S,d,D)
        S = reduePolymer(S,d,D);
    end
    return length(S)
end
println("part 1= $(final_length(S,D,d))")

## part 2
function part_2(S,l,L,D,d)
    minL = length(S)
    for idx = 1:length(l) # interating through alphabet
        sub = replace(S,l[idx] => "" ,L[idx] => "") # removing instances
        if length(sub) < length(S) # check for difference
            newL = final_length(sub,D,d)
            if newL < minL
                minL = newL
            end
        end
    end
    return minL
end

println("part 2 = $(part_2(S,l,L,D,d))")