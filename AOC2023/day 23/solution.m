clear all
%% preparation
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split('');
S = S(:,2:end-1);

start =  1+(2-1)*size(S,1);
dest = size(S,1)+(size(S,2)-2)*size(S,1);
%%
paths = find_paths(S,1,start,dest);
fprintf('part 1 = %14d \n',search_max(paths,start,0,start,dest,start,0))

paths = find_paths(S,2,start,dest);
fprintf('part 2 = %14d \n',search_max(paths,start,0,start,dest,start,0))

%%
function [max_dist] = search_max(paths,visits,max_dist,start,dest,pos,d)
     if pos == dest
         if d > max_dist
             max_dist = d;
             return
         end
     end
     if ismember(pos,keys(paths))
         nxt = paths{pos};
         for idx = 1:size(nxt,1)
            if ~ismember(nxt(idx,1),visits)
                [max_dist] = search_max(paths,[visits nxt(idx,1)],max_dist,start,dest,nxt(idx,1),d+nxt(idx,2));
            end
         end
     end
end
function [paths] = find_paths(S,part,start,dest)
    edges = [0 0];
    dir = [0 1;1 0;0 -1;-1 0];
    down_slope = ['>';'v';'<';'^'];
    for idx = 1:size(S,1)
        for jdx = 1:size(S,2)
            loc = idx+(jdx-1)*size(S,1);
            if part == 1
                if (strcmp(S(loc),'.') |...
                        any(strcmp(S(loc),down_slope)))
                    for ddx = 1:4
                        try
                            I = idx + dir(ddx,1);
                            J = jdx + dir(ddx,2);
                            nxt = I+(J-1)*size(S,1);
                            if (strcmp(S(nxt),'.') | ...
                                    strcmp(S(nxt),down_slope(ddx)))
                                edge = [loc nxt];
                                if ~(ismember(edge,edges,'rows'))
                                    edges = [edges; edge];
                                end
                            end
                        end
                    end
                end
            else
                if ~(strcmp(S(loc),'#'))
                    for ddx = 1:4
                        try
                            I = idx + dir(ddx,1);
                            J = jdx + dir(ddx,2);
                            nxt = I+(J-1)*size(S,1);
                            if ~(strcmp(S(nxt),'#'))
                                edge = [loc nxt];
                                if ~(ismember(edge,edges,'rows')) 
                                    edges = [edges; edge];
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    edges = edges(2:end,:);
    edges = unique(edges, 'rows');
    [reduced_edges] = reduce_edges(edges,start,dest,part);
    paths = dictionary();paths{0} = 0;
    for idx = 1:size(reduced_edges,1)
        if ~ismember(reduced_edges(idx,1),keys(paths))
            paths{reduced_edges(idx,1)} = [reduced_edges(idx,2) reduced_edges(idx,3)];
        else
            paths{reduced_edges(idx,1)} = unique([paths{reduced_edges(idx,1)};...
                                           [reduced_edges(idx,2) reduced_edges(idx,3)]], 'rows');
        end
    end
end


function [reduced_edges] = reduce_edges(edges,start,dest,part) 
     % reduce nodes with degrees 2 to large edges
     % upon inspection the start and end stick out while most interior
     % nodes are of degree 2
    links_to = dictionary(); links_to{0} = 0;
    links_from = dictionary(); links_from{0} = 0;
    for idx = 1:size(edges,1)
        if ismember(edges(idx,1),keys(links_to))
            links_to{edges(idx,1)} = unique([links_to{edges(idx,1)} edges(idx,2)]);
        else
            links_to{edges(idx,1)} =  edges(idx,2);
        end 

        if ismember(edges(idx,2),keys(links_from))
            links_from{edges(idx,2)} = unique([links_from{edges(idx,2)} edges(idx,1)]);
        else
            links_from{edges(idx,2)} =  edges(idx,1);
        end 
    end
    %% reduce to master nodes 
    master_nodes = [];
    for idx = 1:max(edges,[],'all')
        try
            count = numel(unique([links_to{idx},links_from{idx}]));
            if count > 2
                master_nodes = [master_nodes,idx];
            end
        end
    end
    master_nodes = [master_nodes, start, dest];
    reduced_edges = [];
    for idx = 1:numel(master_nodes)
        nxt = links_to{master_nodes(idx)};
        for jdx = 1:numel(nxt)
            path_to_nxt_master = [master_nodes(idx) nxt(jdx)];
            while ~ismember(path_to_nxt_master(end),master_nodes) 
                nxt_node = links_to{path_to_nxt_master(end)};
                nxt_node = nxt_node(~ismember(nxt_node,path_to_nxt_master));
                path_to_nxt_master = [path_to_nxt_master nxt_node];
                if ~numel(nxt_node) 
                    break
                end
            end         
           reduced_edges = [reduced_edges; master_nodes(idx) path_to_nxt_master(end) numel(path_to_nxt_master)-1];
        end
    end
end
