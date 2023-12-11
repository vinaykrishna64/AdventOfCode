clear all
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split("").replace(".","");
S = [repmat("",1,size(S,2));S;repmat("",1,size(S,2))];
expand_row = zeros(size(S,1),1);
for idx = 1:size(S,1)
    if all(strcmp(S(idx,:),''))
        expand_row(idx) = 1;
    end
end
expand_col = zeros(size(S,2),1);
for jdx = 1:size(S,2)
    if all(strcmp(S(:,jdx),''))
        expand_col(jdx) = 1;
    end
end

G = find(strcmp(S,'#'));
[rows,cols] = ind2sub(size(S),G);
P = [rows,cols];
%% part 1
d1 = 0; d2 = 0; age = 1000000;
for idx = 1:numel(G)
    for jdx = idx:numel(G)
        if idx~=jdx
            d1 = d1 + sum(abs(P(idx,:)-P(jdx,:)));
            d1 = d1 + sum(expand_row(min(P(idx,1),P(jdx,1)):max(P(idx,1),P(jdx,1))));
            d1 = d1 + sum(expand_col(min(P(idx,2),P(jdx,2)):max(P(idx,2),P(jdx,2))));

            d2 = d2 + sum(abs(P(idx,:)-P(jdx,:)));
            d2 = d2 + (age-1)*sum(expand_row(min(P(idx,1),P(jdx,1)):max(P(idx,1),P(jdx,1))));
            d2 = d2 + (age-1)*sum(expand_col(min(P(idx,2),P(jdx,2)):max(P(idx,2),P(jdx,2))));
        end
    end
end
fprintf('part 1 = %14d \n',d1)
fprintf('part 2 = %14d \n',d2)



