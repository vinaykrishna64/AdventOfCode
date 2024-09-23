function solveprob()
   S = readlines("input.txt");
    S = split.(S,",")
    f = X -> parse.(Int64,X)
    S = f.(S)
    N = length(S)
    counts = zeros(N)
    S = reduce(hcat, S)

    ranges = [minimum(S[1,1:end]), maximum(S[1,1:end]), minimum(S[2,1:end]), maximum(S[2,1:end])]

    zone_sz = 1.5*maximum([(ranges[2]-ranges[1]),(ranges[4]-ranges[3])])
    total_max = 10000;
    p2 = 0;
    for idx in (ranges[1]-zone_sz):(ranges[2]+zone_sz)
        for jdx in (ranges[3]-zone_sz):(ranges[4]+zone_sz)
            dist = abs.(S[1,1:end] .- idx) + abs.(S[2,1:end] .- jdx)
            if sum(dist) < total_max
                p2 += 1
            end
            points = findall(x -> x .== minimum(dist),dist);
            if length(points) == 1
                counts[points[1]] += 1
                # if any close point touches edges it's an infinte zone
                if (idx == (ranges[1]-zone_sz)) | (idx == (ranges[2]+zone_sz)) | (jdx == (ranges[3]-zone_sz)) | (jdx == (ranges[4]+zone_sz)) 
                    counts[points[1]] -= 10000000
                end
            end
        end
    end
    for idx in 1:N
        if counts[idx] > (ranges[2]-ranges[1]) * (ranges[4]-ranges[3])
            counts[idx] = 0
        end
    end
    println("part 1= $(maximum(counts))")
    println("part 2 = $(p2)")
end

solveprob()
