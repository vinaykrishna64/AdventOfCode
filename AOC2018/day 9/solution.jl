S = readlines("input.txt");
S = replace.(S,"players; last marble is worth " => "");
S = replace.(S," points" => "");
S = split.(S," ");
S = parse.(Int64,S[1])
using Printf
using ProgressBars
function playgame(S)
    players = collect(1:S[1])
    scores = zeros(S[1])
    circle = [0]
    for marble in ProgressBar(1:S[2]*100)
        if marble%23 == 0 
            scores[players[1]] += marble 
            circshift!(circle,8)
            scores[players[1]] += pop!(circle)
            circshift!(circle,-2)
        else
            push!(circle,marble)
            circshift!(circle,-1)
        end
        circshift!(players,-1)
        if marble == S[2]
            p1 = maximum(scores)
        end
    end
    @printf("part 1 = %d\n", p1)
    @printf("part 2 = %d\n", maximum(scores))
end 
scores_list = playgame(S);



