S = readlines("input.txt");
using Printf
using ProgressBars

function findcarts(S)
    carts = []
    CID = 1
    for idx in 1:length(S)
       for jdx in 1:length(S[idx])
            if S[idx][jdx] == '^'
                push!(carts,[[idx,jdx],[-1,0],0,true,CID])
                CID += 1
            elseif S[idx][jdx] == 'v'
                push!(carts,[[idx,jdx],[1,0],0,true,CID])
                CID += 1
            elseif S[idx][jdx] == '>'
                push!(carts,[[idx,jdx],[0,1],0,true,CID])
                CID += 1
            elseif S[idx][jdx] == '<'
                push!(carts,[[idx,jdx],[0,-1],0,true,CID])
                CID += 1
            end
       end
    end
    return carts
end                   

function tick(S,carts,directionsPlus,directionsBS,directionsFS)
    for cart in carts
        cart[1] += cart[2]
        piece = S[cart[1][1]][cart[1][2]]
        #turn 
        if any(piece .== ['\\','/','+'])
            if piece == '\\' 
               cart[2] = directionsBS[cart[2]]
            elseif  piece == '/' 
               cart[2] = directionsFS[cart[2]]
            else
                if cart[3] == 0
                    cart[2] = directionsPlus[cart[2]][1]                 
                elseif cart[3] == 2
                    cart[2] = directionsPlus[cart[2]][2]
                end   
                cart[3] = (cart[3]+1) %3       
            end
        end
    end
    return carts
end
function sortcarts(carts)
    sortval = []
    for cart in carts
        push!(sortval,cart[1][2])
    end
    carts = carts[sortperm(sortval)]
    sortval = []
    for cart in carts
        push!(sortval,cart[1][1])
    end
    return carts[sortperm(sortval)]
end
# function checkcrash(carts,firstcrash)
#     to_remove = []
#     for idx in 1:length(carts)
#         for jdx in idx+1:length(carts)
#             if all(carts[idx][1] .== carts[jdx][1]) 
#                 push!(to_remove,idx) 
#                 push!(to_remove,jdx) 
#                 if firstcrash
#                     @printf("part 1 = %d,%d\n",carts[idx][1][2]-1,carts[idx][1][1]-1)
#                     firstcrash = false
#                 end
#                 @printf("-- %d,%d\n",carts[idx][1][2]-1,carts[idx][1][1]-1)
#             end
#         end
#     end 
#     return deleteat!(copy(carts),sort(unique(to_remove))),firstcrash
# end
# function run_carts(S)
#     carts = findcarts(S);
#     ##   base logic new
#     # cart won't turn unless it encounters an obstacle i.e \\ / +
#     directionsPlus = Dict([[1,0] => [[0,1],[0,-1]],
#     [-1,0] => [[0,-1],[0,1]],
#     [0,1] => [[-1,0],[1,0]],
#     [0,-1] => [[1,0],[-1,0]] ]) #left right pairs for each direction for +
#     directionsBS = Dict([[-1,0] => [0,-1],
#     [1,0] => [0,1] ,
#     [0,-1] => [-1,0],
#     [0,1] => [1,0]]) # direction for \\
#     directionsFS = Dict([[-1,0] => [0,1],
#     [1,0] => [0,-1],
#     [0,-1] => [1,0],
#     [0,1] => [-1,0]]) # direction for /
#     firstcrash = true
#     while (length(carts) > 1) 
#         carts = sortcarts(carts)
#         carts = tick(S,carts,directionsPlus,directionsBS,directionsFS)
#         carts,firstcrash = checkcrash(carts,firstcrash)
#     end
#     @printf("part 2 = %d,%d\n",carts[1][1][2]-1,carts[1][1][1]-1)
# end
# run_carts(S)

function run_carts2(S)
    carts = findcarts(S);
    ##   base logic new
    # cart won't turn unless it encounters an obstacle i.e \\ / +
    directionsPlus = Dict([[1,0] => [[0,1],[0,-1]],
    [-1,0] => [[0,-1],[0,1]],
    [0,1] => [[-1,0],[1,0]],
    [0,-1] => [[1,0],[-1,0]] ]) #left right pairs for each direction for +
    directionsBS = Dict([[-1,0] => [0,-1],
    [1,0] => [0,1] ,
    [0,-1] => [-1,0],
    [0,1] => [1,0]]) # direction for \\
    directionsFS = Dict([[-1,0] => [0,1],
    [1,0] => [0,-1],
    [0,-1] => [1,0],
    [0,1] => [-1,0]]) # direction for /
    firstcrash = true
    rem_carts = length(carts)
  
    while (rem_carts > 1) 
        carts = sortcarts(carts)
        for cart in carts
            if !cart[4]
                continue
            end
            cart[1] += cart[2]
            for cart2 in carts
                if all(cart[1] .== cart2[1])  & (cart[5] != cart2[5]) & (cart2[4])
                    cart[4] = false
                    cart2[4] = false
                    rem_carts += -2
                    if firstcrash
                        @printf("part 1 = %d,%d\n",cart[1][2]-1,cart[1][1]-1)
                        firstcrash = false
                    end
                    @printf("-- %d,%d\n",cart[1][2]-1,cart[1][1]-1)
                end
            end
            piece = S[cart[1][1]][cart[1][2]]
            #turn 
            if any(piece .== ['\\','/','+'])
                if piece == '\\' 
                cart[2] = directionsBS[cart[2]]
                elseif  piece == '/' 
                cart[2] = directionsFS[cart[2]]
                else
                    if cart[3] == 0
                        cart[2] = directionsPlus[cart[2]][1]                 
                    elseif cart[3] == 2
                        cart[2] = directionsPlus[cart[2]][2]
                    end   
                    cart[3] = (cart[3]+1) %3       
                end
            end
        end
    end
    for cart in carts
        if cart[4]
            @printf("part 2 = %d,%d\n",cart[1][2]-1,cart[1][1]-1)
            return 
        end
    end
end
run_carts2(S)
#############################################################################################################
## p1 works and p2 works for example

# S =  " " .* S .* " ";
# push!(S," ".^length(S[1]))
# push!(S," ".^length(S[1]))
# circshift!(S,1)
# function makeconns(tracks)
#     Lv = length(tracks)
#     Lh = length(tracks[1])
#     conns = Dict()
#     carts = []
#     piece = Dict()
#     cart_orientation = Dict(['^' => 0,'>' => 1,'v' => 2,'<' => 3])
#     # dirs -> 0,1,2,3 <=> u,r,d,l
#     for idx in 2:Lv-1
#         for jdx in 2:Lh-1
#             ind = Lv*(jdx-1) + idx;
#             piece[ind] = tracks[idx][jdx]
#             indu = ind-1;
#             indd = ind+1;
#             indl = ind - Lv;
#             indr = ind + Lv;
#             if tracks[idx][jdx] == '-'
#                 conns[ind] = [indr,indl,1,3]
#             elseif tracks[idx][jdx] == '|'
#                 conns[ind] = [indu,indd,0,2]
#             elseif tracks[idx][jdx] == '\\'
#                 #check vertical connection at top
#                 if (tracks[idx-1][jdx]  == '|') |(tracks[idx-1][jdx]  == '+') |(tracks[idx-1][jdx]  == '^') |(tracks[idx-1][jdx]  == 'v') 
#                     conns[ind] = [indu,indr,0,1]
#                 else
#                     conns[ind] = [indl,indd,3,2]
#                 end
#             elseif tracks[idx][jdx] == '/'
#                 #check vertical connection at top
#                 if (tracks[idx-1][jdx]  == '|') |(tracks[idx-1][jdx]  == '+') |(tracks[idx-1][jdx]  == '^') |(tracks[idx-1][jdx]  == 'v')
#                     conns[ind] = [indu,indl,0,3]
#                 else
#                     conns[ind] = [indd,indr,2,1]
#                 end
#             elseif tracks[idx][jdx] == '+'
#                 conns[ind] = [indu,indr,indd,indl,0,1,2,3]
#             elseif tracks[idx][jdx] != ' '  
#                 push!(carts,[ind,cart_orientation[tracks[idx][jdx]],[3,-1,1]])
#                 if (cart_orientation[tracks[idx][jdx]] == 1) | (cart_orientation[tracks[idx][jdx]] == 3)
#                     conns[ind] = [indr,indl,1,3]
#                 else
#                     conns[ind] = [indu,indd,0,2]
#                 end
#             end
#         end
#     end
#     return conns,carts,piece
# end

# function tick(conns,carts,piece)
#     new_carts = []
#     dirs = [0,1,2,3]
#     for cart in carts
#         new_cart = []
#         options = conns[cart[1]]
#         while dirs[1] != cart[2]
#             circshift!(dirs,1)
#         end
#         # in any case movement is straight or left/right
#         if length(options) == 4 
#             # no curve
#             turns = false # if same direction is available doesn't turn
#             if (options[3] != cart[2]) & (options[4] != cart[2])  #bends make the cart turn
#                 turns = true
#             end
#             for idx in 1:2
#                 if options[idx+2] != dirs[3]
#                     if turns #if turns turn left/right 
#                         push!(new_cart,options[idx])
#                         push!(new_cart,options[idx+2])
#                         push!(new_cart,cart[3])
#                         break
#                     else #if doesn't turn preseve direction
#                         if options[idx+2] == cart[2]
#                             push!(new_cart,options[idx])
#                             push!(new_cart,cart[2])
#                             push!(new_cart,cart[3])
#                             break
#                         end
#                     end
#                 end
#             end
#         else #connection +
#             for idx in 1:4
#                 if cart[3][1] == -1 #going straight
#                     if options[idx+4] == dirs[1]
#                         push!(new_cart,options[idx])
#                         push!(new_cart,dirs[1])
#                         break
#                     end
#                 elseif cart[3][1] == 1 #turning right
#                     if options[idx+4] == dirs[2]
#                         push!(new_cart,options[idx])
#                         push!(new_cart,dirs[2])
#                         break
#                     end
#                 else #turning left
#                     if options[idx+4] == dirs[4]
#                         push!(new_cart,options[idx])
#                         push!(new_cart,dirs[4])
#                         break
#                     end
#                 end
#             end
#             push!(new_cart,circshift(cart[3],-1)) # cycle to next junction move
#         end
#         push!(new_carts ,new_cart)
#     end
#     return new_carts
# end

# function checkcrash(carts)
#     for idx in 1:length(carts)
#         for jdx in idx+1:length(carts)
#             if carts[idx][1] == carts[jdx][1]
#                 return true, carts[idx][1] 
#             end
#         end
#     end
#     return false, 0
# end
# function run_carts(conns,carts,piece,tracks)
#     crashed = false
#     loc = 0
#     while !crashed
#         carts = tick(conns,carts,piece)
#         crashed,loc = checkcrash(carts)
#     end
#     Lv = length(tracks)
#     return floor(loc/Lv)-1, loc - floor(loc/Lv)*Lv -2
# end

# function remove_crashed(carts)
#     to_remove = []
#     for idx in 1:length(carts)
#         for jdx in idx+1:length(carts)
#             if carts[idx][1] == carts[jdx][1]
#                 push!(to_remove,idx) 
#                 push!(to_remove,jdx) 
#             end
#         end
#     end  
#     return deleteat!(carts,sort(unique(to_remove)))
# end

# function run_carts_last(conns,carts,piece,tracks)
#     while length(carts) > 1
#         carts = tick(conns,carts,piece)
#         carts = remove_crashed(carts)
#     end
#     loc = carts[1][1]
#     Lv = length(tracks)
#     return floor(loc/Lv)-1, loc - floor(loc/Lv)*Lv -2
# end


# conns,carts,piece = makeconns(S)

# I,J = run_carts(conns,copy(carts),piece,S)
# @printf("part 1 = %d,%d\n",I,J)

# I,J = run_carts_last(conns,copy(carts),piece,S)
# @printf("part 2 = %d,%d\n",I,J)
