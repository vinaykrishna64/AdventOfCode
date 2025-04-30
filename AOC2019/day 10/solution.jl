S = readlines("input.txt");
S = split.(S,"");
using Printf
function get_XY(S)
    X = []
    Y = []
    for idx in 1:length(S)
        for jdx in 1:length(S[1])
            if S[idx][jdx] != "."
                push!(X,jdx)
                push!(Y,idx)
            end
        end
    end
    return X,Y
end


function AsteroidChecker(S)
    X,Y = get_XY(S)
    max = -100
    x = 1
    y = 1
    angles = []
    bearings_store = []
    distances = []
    alive = []
    for idx in 1:length(X)
        bearing = atand.(( Y[idx] .- Y ) , (X[idx] .- X))
        visible = length(unique(bearing))
        if max < visible
            max = visible
            x = X[idx]
            y = Y[idx]
            alive = ones(length(X))
            alive[idx] = 0
            bearings_store = Int.(bearing .< 0)*360 .+ bearing
            # bearings_store = bearing
            angles = sort!(unique(bearings_store))
            distances = sqrt.((Y .- Y[idx]).^2 .+ (X .- X[idx]).^2)
        end
    end
    @printf("part 1 =  %d\n",max)
    kills = 0
    circshift!(angles,-(findall(x->x==90.0, angles))[1]+1)
    x200 = 0
    y200 = 0
    while kills < 200
        kills += 1
        kill = 0
        distance = 100000
        for idx in 1:length(X)
            if (alive[idx] == 1) & (bearings_store[idx] == angles[1] )
                if distance > distances[idx]
                    kill = idx
                    distance = distances[idx]
                end
            end
        end
        if kill != 0
            x200 = X[kill]-1
            y200 = Y[kill]-1
            alive[kill] = 0
        end
        circshift!(angles,-1)
    end
    @printf("part 1 =  %d\n",x200*100 + y200)
    
end


AsteroidChecker(S)
