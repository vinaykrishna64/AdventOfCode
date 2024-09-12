S = readlines("input.txt");

S = replace.(S,"Step " => "");
S = replace.(S,"step " => "");
S = replace.(S," must be finished before" => "");
S = replace.(S," can begin." => "");
S = split.(S," ");

function makedict(S)
    Sd = Dict()
    Sdr = Dict()
    for idx in 1:length(S)
        if haskey(Sd,S[idx][1])
            push!(Sd[S[idx][1]],S[idx][2]);
        else
            Sd[S[idx][1]] = [S[idx][2]];
        end
        if haskey(Sdr,S[idx][2])
            push!(Sdr[S[idx][2]],S[idx][1]);
        else
            Sdr[S[idx][2]] = [S[idx][1]];  
        end
           
    end
    return Sd,Sdr
end
Sd,Sdr = makedict(S);
available = collect(setdiff(keys(Sd), keys(Sdr)))


function findsequence(Sdr,available)
    sequence = []
    push!(sequence,popfirst!(sort!(available)))
    while true
        for k in keys(Sdr)
            if all([x in sequence  for x = Sdr[k]])
                if !(k in sequence) & !(k in available)
                    push!(available,k)
                end
            end
        end
        if length(available) >= 1
            push!(sequence,popfirst!(sort!(available)))
        else
            break
        end
    end
    return sequence
end
using Printf
@printf("part 1 = %s\n",join(findsequence(Sdr,copy(available))))




function fill_available(completed,Sdr,available,working =[])
    for k in keys(Sdr)
        if all([x in completed  for x = Sdr[k]])
            if !(k in completed) & !(k in available) & !(k in working)
                push!(available,k)
            end
        end
    end
    sort!(available)   
    return available
end

function work_nodes(Sdr,available,workers = 2)
    time_taken = Dict{Char,Int}(zip('A':'Z', 1:26))
    working = []
    completed = []
    timers = []
    for idx in 1:workers
        if length(available)>= 1
            push!(working,popfirst!(sort!(available)))
            push!(timers, time_taken[only(working[idx])] + 60)
        end
    end
    TotalTime = 0
    while any(timers .> 0)
        TotalTime += 1
        timers .-= 1
        finshed = []
        for idx in 1:length(working)
            if timers[idx] == 0
                push!(finshed,idx)
                push!(completed,working[idx])
            end
        end
        if length(finshed) >= 1
            deleteat!(working,finshed)
            deleteat!(timers,finshed)
            available = fill_available(completed,Sdr,available,working)
            for idx in (length(working)+1):workers
                if length(available)>= 1
                    push!(working,popfirst!(sort!(available)))
                    push!(timers,time_taken[only(working[idx])] + 60)
                end
            end
        end
    end
    return TotalTime
end

@printf("part 2 = %d\n",work_nodes(Sdr,available,5))