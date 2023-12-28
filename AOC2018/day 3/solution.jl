S = readlines("input.txt");
## parser
function parse_block(s)
    i = Int64[];
    push!(i,findfirst("@",s)[1]);
    push!(i,findfirst(",",s)[1]);
    push!(i,findfirst(":",s)[1]);
    push!(i,findfirst("x",s)[1]);
    push!(i,length(s)+1);
    block = Int64[];
    for idx = 1:4
        push!(block,parse(Int64,s[i[idx]+1:i[idx+1]-1]))
    end
    block[3:4] = block[3:4] + block[1:2].-1;
    return block .+ 1
end
## part 1
blocks = zeros(Int,(size(S)[1],4));
for idx = 1:size(S)[1]
    blocks[idx,1:4] = parse_block(S[idx]) ;
end
grid = zeros(Int,(trunc(Int, maximum(blocks[1:size(S)[1],3])),trunc(Int, maximum(blocks[1:size(S)[1],4]))));


for idx = 1:size(S)[1]
    grid[blocks[idx,1]:blocks[idx,3],blocks[idx,2]:blocks[idx,4]] = grid[blocks[idx,1]:blocks[idx,3],blocks[idx,2]:blocks[idx,4]] .+ 1;
end

println("part 1 = $(sum(grid .> 1))")

## part 2
for idx = 1:size(S)[1]
    local subgrid = grid[blocks[idx,1]:blocks[idx,3],blocks[idx,2]:blocks[idx,4]];
    if sum(subgrid .== 1) == length(subgrid)
        println("part 2 = $idx")
        break
    end
end