clear all
w = warning ('off','all');
%% preparation
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split(': ');

%% make links
edges = [];
for idx = 1:size(S,1)
    links_to = S(idx,2).split(" ");    
    edges = [edges; [repmat(S(idx,1),size(links_to)) links_to]];
end

D = digraph(edges(:,1),edges(:,2));
figure
subplot(1,2,1)
plot(D) %visual inspection is obivous

remv_edges = ["mvv" "xkz"; "gbc" "hxr";"tmt" "pnz"];
remv_edges = [remv_edges;fliplr(remv_edges)];
edges_new = edges;
for idx = 1:6
    [q, idx] =ismember(remv_edges(idx,:), edges_new, 'rows');
    if q
        edges_new(idx,:) = [];
    end
end


D = digraph(edges_new(:,1),edges_new(:,2));
[weak_bins1, compNumNodes] = conncomp(D,'Type','weak');
fprintf('part 1 = %14d \n',prod(compNumNodes))
subplot(1,2,2)
plot(D) 

