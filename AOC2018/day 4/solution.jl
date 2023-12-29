S = readlines("input.txt");
using Dates
## part 1
function EntType(s) # just setting types for shift, fall ,wake entries
    if occursin("Guard", s)
        return 1
    elseif occursin("falls", s)
        return 2
    elseif occursin("wakes", s)
        return 3
    end
end


## sort the log entries
T = [round(Dates.datetime2unix(Dates.DateTime(S[idx][2:17], "yyyy-mm-dd HH:MM"))) for idx in 1:length(S)]; # vector of unix times
T .-= T[1];
T  = T./60; # converted to minutes after shifting to first chronological entry
sort_idx = sortperm(T);
S = S[sort_idx];
T = T[sort_idx];
m = [parse(Int,S[idx][16:17])+1 for idx in 1:length(S)] # minute marks for finding minutes asleep

## part 1
guards_max = Dict() # max slept by that guard
guards_tot = Dict() # total sleep by that guard
guards_mins = Dict() # times slept at each minute
entryType = [EntType(S[idx])  for idx in 1:length(S)]; # entry type marker for conditional statement
for idx = 1:length(S)
    local sub = split(S[idx])
    if length(sub) == 6 #if starts
        global key = parse(Int64,sub[4][2:length(sub[4])]) # maek key with guard no
        if !haskey(guards_max,key) # initiate entries
            global guards_max[key] = 0
            global guards_tot[key] = 0
            global guards_mins[key] = Array{Int64}(undef, 60,1)
            fill!(guards_mins[key], 0);
        end
    else
        if entryType[idx] == 3 # if wakes up
            local intvl = T[idx] - T[idx-1] #interval slept
            if guards_max[key] < intvl #update max slept interval
                guards_max[key] = intvl
            end
            guards_mins[key][m[idx-1]:m[idx]-1] .+= 1 # add to the minute markers
            guards_tot[key] += intvl # add time to total sleep
        end
    end
end

(T,G) = findmax(guards_tot);
(N,M) = findmax(guards_mins[G])
println("part 1 = $((M[1]-1)*G)")

## part 2
fq = 0
for key in keys(guards_mins)
    (N2,M20) = findmax(guards_mins[key])
    if fq < N2
        global fq = N2
        global G2 = key
        global M2 = M20
    end
end

println("part 2 = $((M2[1]-1)*G2)")