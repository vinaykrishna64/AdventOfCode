
using Printf
using ProgressBars
##
function Build_DB(grid)
    characters = []
    charId = 0
    char_counts = [0,0]
    for idx in 1:length(grid)
        for jdx in 1:length(grid[1])
            if (grid[idx][jdx] == "E") | (grid[idx][jdx] == "G")
                push!(characters,[[idx,jdx],grid[idx][jdx],200,charId,true]) # current loc, type, health, ID, alive
                charId += 1
                if (grid[idx][jdx] == "E")
                    char_counts += [1,0]
                else
                    char_counts += [0,1]
                end
            end
        end
    end
    characters = sortCharacters(characters,length(grid[1]))
    return characters,char_counts
end
function printgrid(grid)
    for row in grid
        println(join(row))
    end
    println("")
end
function modifyGrid(grid,loc,charVal)
    row = collect(grid[loc[1]])
    row[loc[2]] = charVal
    grid[loc[1]] = join(row)
    return grid
end
function sortCharacters(characters,cols)
    sortval = []
    for character in characters
        push!(sortval,(character[1][2] + character[1][1]*cols))
    end
    return characters[sortperm(sortval)]
end

function DFS_and_first_move(startPos,EndPos,grid,minDist = 10000,nextPos =[],d = 0,visited = [])
    if d > minDist
        return minDist
    end
    if length(nextPos) == 0
        push!(visited,startPos)
    else
        push!(visited,nextPos)
    end
    dirs = [[-1,0],[0,-1],[0,1],[1,0]]
    if length(nextPos) == 0
        final = [10000,10000,10000,10000]
    end
    for idx in 1:4
        nextPos = visited[end] + dirs[idx]
        if all(nextPos .== EndPos) & ((d+1) < minDist)
            return (d+1)
        end
        if (grid[nextPos[1]][nextPos[2]] == ".") & !(any([all(i .== nextPos) for i in visited]))
            minDist = DFS_and_first_move(startPos,EndPos,grid,minDist,nextPos,d+1,copy(visited))
            if length(visited) == 1
                final[idx] = minDist
            end
        end
    end
    if length(visited) == 1
        if final[argmin(final)] != 10000
            return (startPos+dirs[argmin(final)]),minDist
        else
            return startPos,minDist
        end
    else
        return minDist
    end
end

function checkOpen(EndPos,grid)
    dirs = [[-1,0],[0,-1],[0,1],[1,0]]
    for idx in 1:4
        nextPos = EndPos + dirs[idx]
        if grid[nextPos[1]][nextPos[2]] == "."
            return true
        end
    end
    return false
end
function move_character(grid,characters,character)
    possible_moves = []
    Dist = []
    minDist= 0
    for character2 in characters
        if (character[4] != character2[4]) & (character[2] != character2[2]) & character2[5] # different class and alive
            if checkOpen(character2[1],grid) # check path open to endPos
                if length(Dist) > 0
                    path,minDist = DFS_and_first_move(character[1],character2[1],grid,minimum(Dist)+1) #truncate searches to last min dist
                    push!(possible_moves,path)
                    push!(Dist,minDist)
                else
                    path,minDist = DFS_and_first_move(character[1],character2[1],grid)
                    push!(possible_moves,path)
                    push!(Dist,minDist)
                end
            end
        end
    end
    possible_moves = possible_moves[sortperm(Dist)]
    if length(possible_moves) > 0
        for character2 in characters
            if (character[4] == character2[4])
                grid[character[1][1]][character[1][2]]  = "."
                grid[possible_moves[1][1]][possible_moves[1][2]] = character[2]
                character2[1] = possible_moves[1]
                return grid,characters
            end
        end
    end
    return grid,characters
end
function checkNeighbours(characters,character)
    # check all neighbours
    dirs = [[-1,0],[0,-1],[0,1],[1,0]]
    neighbours = [300,300,300,300]
    charID = [-1,-1,-1,-1]
    for idx in 1:4
        nextPos = character[1] + dirs[idx]
        for character2 in characters
            if all(character2[1] .== nextPos)
                if  (character[2] != character2[2]) & character2[5] #adjacent and different class and alive
                    neighbours[idx] = character2[3]
                    charID[idx]  = character2[4]
                end
            end
        end
    end
    if !any(charID .> -1) #no attackable neighbours
        return false,charID[argmin(neighbours)]
    else
        return true,charID[argmin(neighbours)]
    end
end

function take_turns_inner(grid,characters,dead,char_counts,character)
        attackable,CharID = checkNeighbours(characters,character)
        #  move
        if !attackable #no attackable neighbours
            grid,characters = move_character(copy(grid),copy(characters),character)
            attackable,CharID = checkNeighbours(characters,character)
            if attackable
                for character2 in characters
                    if (character2[4] == CharID)
                        if character2[5] 
                            character2[3] -= 3 #attack if alive
                            if character2[3] <= 0 #character2 died
                                character2[5] = false
                                grid[character2[1][1]][character2[1][2]]  = "."
                                if (character2[2] == "E")
                                    dead += [1,0]
                                else
                                    dead += [0,1]
                                end
                            end
                            break
                        end
                    end
                end
            end
        else
            for character2 in characters
                if (character2[4] == CharID)
                    if character2[5] 
                        character2[3] -= 3 #attack if alive
                        if character2[3] <= 0 #character2 died
                            character2[5] = false
                            grid[character2[1][1]][character2[1][2]]  = "."
                            if (character2[2] == "E")
                                dead += [1,0]
                            else
                                dead += [0,1]
                            end
                        end
                        break
                    end
                end
            end
        end
    return grid,characters,dead
end
function take_turns(grid,characters,dead,char_counts) # simulate 1 round
    iter = ProgressBar(1:length(characters))
    for CIDX in iter
        C = characters[CIDX]
        if C[5]
            grid,characters,dead = take_turns_inner(copy(grid),copy(characters),dead,char_counts,C) 
        end
        if !all(dead .< char_counts) & (CIDX <length(characters)) #check if it's a full round
            return grid,characters,dead,1
        end
    end
    characters = sortCharacters(characters,length(grid[1]))
    return grid,characters,dead,0
end

##

function simulation()
    grid = readlines("input.txt");
    grid = split.(grid,"");
    characters,char_counts = Build_DB(grid)
    dead = [0,0]
    iter = 0
    iterOffset = 0
    while all(dead .< char_counts) 
        iter += 1
        grid,characters,dead,iterOffset = take_turns(grid,characters,dead,char_counts)
        printgrid(grid)
        println(iter)
    end
    iter -= iterOffset # correct iter to number of full rounds
    p1 = 0
    for character in characters
        if character[3] >0
            p1 += character[3]
        end
    end
    @printf("part 1 = %d , %d , %d\n",p1*iter,p1,iter)  
end  

simulation()

