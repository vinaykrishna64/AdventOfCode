clear all
w = warning ('off','all');
%% preparation
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split('   <- ');
bricks = str2double(S(:,1).replace('~',',').split(','));

%settle initial snapshot
[bricks] = simulate_fall(bricks);
%% make brick links
supported_by = dictionary(); supported_by{0} = [];
supports = dictionary(); supports{0} = [];
for idx = 1:size(bricks,1)
    if bricks(idx,3) > 1
        bricks(idx,:) = bricks(idx,:) - [0 0 1 0 0 1];
        I = find(bricks(idx,3) == bricks(:,6));
        for jdx = 1:numel(I)
            if idx ~= I(jdx) & check_intersect(bricks(I(jdx),:),bricks(idx,:))
                if ~isKey(supported_by,idx)
                    supported_by{idx} = I(jdx);
                else
                    supported_by{idx} = [supported_by{idx} I(jdx)];
                end
                if ~isKey(supports,I(jdx))
                    supports{I(jdx)} = idx;
                else
                    supports{I(jdx)} = [supports{I(jdx)} idx];
                end
            end
        end
        bricks(idx,:) = bricks(idx,:) + [0 0 1 0 0 1];
    end
end
%% part 1

%find blocks supported by single supports
single_supps = [];
for idx = 1:size(bricks,1)
    % if any brick is just supported by one brick record it
    if isKey(supported_by,idx) & numel(supported_by{idx}) == 1 
        single_supps = [single_supps;supported_by{idx}];
    end
end
p1 = size(bricks,1) - numel(unique(single_supps));
fprintf('part 1 = %14d \n',p1)
%% part 2
p2 = 0;
for idx = 1:size(bricks,1)
    falls = [idx];
    falls = reaction(falls,supports,supported_by);
    p2 = p2 + numel(falls)-1;
end
fprintf('part 2 = %14d \n',p2)
%%
function [falls] = reaction(falls,supports,supported_by)
    reacting = 1;
    while reacting
        reacting = 0;
        for jdx = 1:numel(falls)
            try %isKey fails for some reason
                nxt_layer = supports{falls(jdx)};
                for kdx = 1:numel(nxt_layer)
                    if ~ismember(nxt_layer(kdx),falls) & all(ismember(supported_by{nxt_layer(kdx)},falls))  
                        falls = [falls nxt_layer(kdx)];
                        reacting = 1;
                    end
                end
            end
        end
    end
end

function [bricks] = simulate_fall(bricks)
    % sort brick on levels
    [~,I] = sort(bricks(:,3));
    bricks = bricks(I,:);
   for idx = 1:size(bricks,1)
        if bricks(idx,3) >1
            falling = 1;
            while falling
                bricks(idx,:) = bricks(idx,:) - [0 0 1 0 0 1];
                I = find(bricks(idx,3) == bricks(:,6));
                for jdx = 1:numel(I)
                    if idx ~= I(jdx) & check_intersect(bricks(I(jdx),:),bricks(idx,:))
                        bricks(idx,:) = bricks(idx,:) + [0 0 1 0 0 1];
                        falling = 0;
                        break
                    end
                end
                if bricks(idx,3) == 1
                   falling = 0;
                end
            end
        end
   end
end

function [out] = check_intersect(brick1,brick2)
    out = 0;
    [xi,yi] = polyxpoly(brick1([1,4]),brick1([2,5]),brick2([1,4]),brick2([2,5]));
    if numel(xi)
        out = 1;
    end
end