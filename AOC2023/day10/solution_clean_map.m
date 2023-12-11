clear all
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split("");
S = [repmat("",1,size(S,2));S;repmat("",1,size(S,2))];
sz = size(S);
nodemap = cell(1, numel(S));
connections = cell(1, numel(S));
% find possible connections between nodes
for idx = 2:size(S,1)-1
    for jdx = 2:size(S,2)-1
        if strcmp(S(idx,jdx),"|")
            connections{sub2ind(sz,idx,jdx)} = [sub2ind(sz,idx-1,jdx) sub2ind(sz,idx+1,jdx)];
        elseif strcmp(S(idx,jdx),"-")
            connections{sub2ind(sz,idx,jdx)} = [sub2ind(sz,idx,jdx-1) sub2ind(sz,idx,jdx+1)];
        elseif strcmp(S(idx,jdx),"L")   
            connections{sub2ind(sz,idx,jdx)} = [sub2ind(sz,idx-1,jdx) sub2ind(sz,idx,jdx+1)];
        elseif strcmp(S(idx,jdx),"J") 
            connections{sub2ind(sz,idx,jdx)} = [sub2ind(sz,idx-1,jdx) sub2ind(sz,idx,jdx-1)];
        elseif strcmp(S(idx,jdx),"7") 
            connections{sub2ind(sz,idx,jdx)} = [sub2ind(sz,idx,jdx-1) sub2ind(sz,idx+1,jdx)];
        elseif strcmp(S(idx,jdx),"F") 
           connections{sub2ind(sz,idx,jdx)} = [sub2ind(sz,idx,jdx+1)  sub2ind(sz,idx+1,jdx)];
        end
    end
end
% connect start to everything because we don't know what it is anyway
start = find(strcmp(S,"S") );
connections{start} = [start+1 start-1 start+size(S,1) start-size(S,1)];
% make node map :: nodes possible to got to from each node
for idx = 2:size(S,1)-1
    for jdx = 2:size(S,2)-1
        if ismember(sub2ind(sz,idx,jdx),connections{sub2ind(sz,idx-1,jdx)})
            nodemap{sub2ind(sz,idx,jdx)} = [nodemap{sub2ind(sz,idx,jdx)},sub2ind(sz,idx-1,jdx)];
        end
        if ismember(sub2ind(sz,idx,jdx),connections{sub2ind(sz,idx+1,jdx)})
            nodemap{sub2ind(sz,idx,jdx)} = [nodemap{sub2ind(sz,idx,jdx)},sub2ind(sz,idx+1,jdx)];
        end
        if ismember(sub2ind(sz,idx,jdx),connections{sub2ind(sz,idx,jdx-1)})
            nodemap{sub2ind(sz,idx,jdx)} = [nodemap{sub2ind(sz,idx,jdx)},sub2ind(sz,idx,jdx-1)];
        end
        if ismember(sub2ind(sz,idx,jdx),connections{sub2ind(sz,idx,jdx+1)})
            nodemap{sub2ind(sz,idx,jdx)} = [nodemap{sub2ind(sz,idx,jdx)},sub2ind(sz,idx,jdx+1)];
        end
    end
end

%% part 1

pos = start;
[loop,d] = max_d(start,pos,0,nodemap,pos);
fprintf('part 1 = %10d\n',floor(d/2));
%% part 2
[row,col] = ind2sub(sz,loop);
[rows,cols] = ind2sub(sz,1:numel(S));
[in,on] = inpolygon(rows,cols,row,col);
fprintf('part 2 = %10d\n',sum(in) - sum(on));
%%
img = zeros(size(S));
img(loop) = 1;
img(sub2ind(sz,rows(in & ~on),cols(in & ~on))) = 0.5;
figure
imagesc(img)
colormap(jet)
hold on
plot(col,row,'k-')
%% searching function

function [loop,d] = max_d(start,pos,d,nodemap,loop)
    if numel(pos) == 1
        opts = nodemap{pos(end)};
        for idx = 1:numel(opts)
            [loop,d] = max_d(start,[pos;opts(idx)],d,nodemap,loop);
        end
    else
        if pos(end) == start
           if numel(pos) > d
               d = numel(pos);
               loop = pos;
               return
           end
        else
            opts = nodemap{pos(end)};
            opts(ismember(opts,pos)) = []; % stops going back in the loop
            for idx = 1:numel(opts)
                [loop,d] = max_d(start,[pos;opts(idx)],d,nodemap,loop);
            end
            if numel(opts) == 0 & ismember(start,nodemap{pos(end)}) % if you can't go back or forward check if loop closes
                [loop,d] = max_d(start,[pos;start],d,nodemap,loop);
            end
        end
    end
end