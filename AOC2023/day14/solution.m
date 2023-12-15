clear all
filename            = 'input.txt';
S                   = readlines(filename);
S = str2double(S.replace(["O","."],["1","0"]).split('')); S = S(:,2:end-1);

fprintf('part 1 = %14d \n',load_val(load_dir(S,"N")))
loads = [];
while true
    S = cycle(S);
    loads = [loads; load_val(S)];
    if numel(loads) > 1000
        break
    end
end
figure
plot(loads)

steady_state = 109; cycle_sz = 42;
tgt = 1000000000;
tgt = tgt - steady_state;
fprintf('part 2 = %14d \n',loads(steady_state + mod(tgt,42)))

%% functions
function [load] = load_val(S)
    % Get the load
    S = flipud(S);
    [r,c] = find(S == 1);
    load = sum(r);
end
function [S] = cycle(S)
    dirs = ["","N","W","S","E"];
    for idx = 1:4
        dirs = circshift(dirs,-1);
        S = load_dir(S,dirs(1));
    end
end
function [S_new] = load_dir(S,dir)
    sz =size(S);
    S_new = zeros(sz);
    %% change perspective so target dir is "N"
        if dir == "S"
            S = flipud(S);
            S_new = flipud(S_new);
        end
        if dir == "W"
            S = S';
            S_new = S_new';
            sz =size(S);
        end
         if dir == "E"
            S = fliplr(S);
            S_new = fliplr(S_new); 
            S = S';
            S_new = S_new';
            sz =size(S);
         end
         %% loop just loads north
        for idx = 1:sz(2) 
            s = S(:,idx);
            I = [0; find(isnan(s)); sz(1)+1];
            S_new(find(isnan(s)),idx) = nan;
            for jdx = 1:numel(I)-1
                part = s(I(jdx)+1:I(jdx+1)-1);
                if any(part)
                    S_new((I(jdx)+1):(I(jdx)+sum(part)),idx) = 1;
                end
            end
        end
        %% Get back to old perspective
        if dir == "S"
            S = flipud(S);
            S_new = flipud(S_new);
        end
        if dir == "W"
            S = S';
            S_new = S_new';
        end
        if dir == "E"
            S = S';
            S_new = S_new';
            S = fliplr(S);
            S_new = fliplr(S_new);
        end
end

