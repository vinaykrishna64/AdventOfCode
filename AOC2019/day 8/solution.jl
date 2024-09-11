S = readlines("input.txt");
px = parse.(Int64,split(S[1],""));

function  P1(px,imsize = [6,25])
    push!(imsize,length(px)/(imsize[1]*imsize[2]))
    p1 = 0
    nzeros = 1000000;
    inds = 1:(imsize[1]*imsize[2])
    for idx in 1:imsize[3]
        layer = px[inds .+ (idx-1)*inds[end]]
        counts = [count(==(i), layer) for i in 0:2]
        if nzeros > counts[1]
            nzeros = counts[1]
            p1 = counts[2]*counts[3]
        end
    end
    return p1
end


using Printf
@printf("part 1 = %d\n", P1(px))


function  P2(px,imsize = [6,25])
    push!(imsize,length(px)/(imsize[1]*imsize[2]))
    p1 = 0
    final =  ones((imsize[1]*imsize[2])) .* 2;
    inds = 1:(imsize[1]*imsize[2])
    for idx in 1:imsize[3]
        layer = px[inds .+ (idx-1)*inds[end]]
        for jdx in 1:(imsize[1]*imsize[2])
            if final[jdx] == 2
                final[jdx]  =  layer[jdx]
            end
        end
    end
    inds = 1:imsize[2]
    f(x) = x==1 ? ':' : ' '
    println("<============part 2==============>")
    for idx in 1:imsize[1]
        println(join(f.(final[inds .+ (idx-1)*inds[end]])))
    end
    println("<=================================>")
end

P2(px)