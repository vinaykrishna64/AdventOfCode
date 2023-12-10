clear all
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split("");
S = [repmat("",1,size(S,2));S;repmat("",1,size(S,2))];
sz = size(S);
nodemap = cell(1, numel(S));
for idx = 2:size(S,1)-1
    for jdx = 2:size(S,2)-1
        if strcmp(S(idx,jdx),"|")
            set = [sub2ind(sz,idx-1,jdx) sub2ind(sz,idx,jdx) sub2ind(sz,idx+1,jdx)];
            if strcmp(S(set(1)),"|") | strcmp(S(set(1)),"7") | strcmp(S(set(1)),"F") | strcmp(S(set(1)),"S") 
                nodemap{set(1)} = [nodemap{set(1)} set(2)];
                nodemap{set(2)} = [nodemap{set(2)} set(1)];
            end
            if strcmp(S(set(3)),"|") | strcmp(S(set(3)),"J") | strcmp(S(set(3)),"L") | strcmp(S(set(3)),"S")
                nodemap{set(2)} = [nodemap{set(2)} set(3)];
                nodemap{set(3)} = [nodemap{set(3)} set(2)];
            end
        elseif strcmp(S(idx,jdx),"-")
            set = [sub2ind(sz,idx,jdx-1) sub2ind(sz,idx,jdx) sub2ind(sz,idx,jdx+1)];
            if strcmp(S(set(1)),"-") | strcmp(S(set(1)),"L") | strcmp(S(set(1)),"F") | strcmp(S(set(1)),"S") 
                nodemap{set(1)} = [nodemap{set(1)} set(2)];
                nodemap{set(2)} = [nodemap{set(2)} set(1)];
            end
            if strcmp(S(set(3)),"-") | strcmp(S(set(3)),"J") | strcmp(S(set(3)),"7") | strcmp(S(set(3)),"S")
                nodemap{set(2)} = [nodemap{set(2)} set(3)];
                nodemap{set(3)} = [nodemap{set(3)} set(2)];
            end
        elseif strcmp(S(idx,jdx),"L")   
            set = [sub2ind(sz,idx-1,jdx) sub2ind(sz,idx,jdx) sub2ind(sz,idx,jdx+1)];
            if  strcmp(S(set(1)),"7") | strcmp(S(set(1)),"F") | strcmp(S(set(1)),"|") | strcmp(S(set(1)),"S") 
                nodemap{set(1)} = [nodemap{set(1)} set(2)];
                nodemap{set(2)} = [nodemap{set(2)} set(1)];
            end
            if strcmp(S(set(3)),"-") | strcmp(S(set(3)),"J") | strcmp(S(set(3)),"7") | strcmp(S(set(3)),"S")
                nodemap{set(2)} = [nodemap{set(2)} set(3)];
                nodemap{set(3)} = [nodemap{set(3)} set(2)];
            end
        elseif strcmp(S(idx,jdx),"J") 
            set = [sub2ind(sz,idx-1,jdx) sub2ind(sz,idx,jdx) sub2ind(sz,idx,jdx-1)];
            if  strcmp(S(set(1)),"7") | strcmp(S(set(1)),"F") | strcmp(S(set(1)),"|") | strcmp(S(set(1)),"S") 
                nodemap{set(1)} = [nodemap{set(1)} set(2)];
                nodemap{set(2)} = [nodemap{set(2)} set(1)];
            end
            if strcmp(S(set(3)),"-") | strcmp(S(set(3)),"L") | strcmp(S(set(3)),"F") | strcmp(S(set(3)),"S")
                nodemap{set(2)} = [nodemap{set(2)} set(3)];
                nodemap{set(3)} = [nodemap{set(3)} set(2)];
            end
        elseif strcmp(S(idx,jdx),"7") 
            set = [sub2ind(sz,idx,jdx-1) sub2ind(sz,idx,jdx) sub2ind(sz,idx+1,jdx)];
            if  strcmp(S(set(1)),"-") | strcmp(S(set(1)),"F") | strcmp(S(set(1)),"L") | strcmp(S(set(1)),"S") 
                nodemap{set(1)} = [nodemap{set(1)} set(2)];
                nodemap{set(2)} = [nodemap{set(2)} set(1)];
            end
            if strcmp(S(set(3)),"|") | strcmp(S(set(3)),"J") | strcmp(S(set(3)),"L") | strcmp(S(set(3)),"S")
                nodemap{set(2)} = [nodemap{set(2)} set(3)];
                nodemap{set(3)} = [nodemap{set(3)} set(2)];
            end
       elseif strcmp(S(idx,jdx),"F") 
           set = [sub2ind(sz,idx,jdx+1) sub2ind(sz,idx,jdx) sub2ind(sz,idx+1,jdx)];
            if  strcmp(S(set(1)),"-") | strcmp(S(set(1)),"J") | strcmp(S(set(1)),"7") | strcmp(S(set(1)),"S") 
                nodemap{set(1)} = [nodemap{set(1)} set(2)];
                nodemap{set(2)} = [nodemap{set(2)} set(1)];
            end
            if strcmp(S(set(3)),"|") | strcmp(S(set(3)),"J") | strcmp(S(set(3)),"L") | strcmp(S(set(3)),"S") 
                nodemap{set(2)} = [nodemap{set(2)} set(3)];
                nodemap{set(3)} = [nodemap{set(3)} set(2)];
            end
        end
    end
end

for idx = 1:numel(nodemap) %% clean map
    nodemap{idx} = unique(nodemap{idx});
end
%% part 1
start = find(strcmp(S,"S") );
nodemap{start} = [start+1 start-1 start+size(S,1) start-size(S,1)];
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