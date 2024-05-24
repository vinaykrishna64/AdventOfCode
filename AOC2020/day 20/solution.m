clear all
clc
filename = 'input.txt';
S = readlines(filename);
I = find(S == ''); I = [0; I];
if I(end) == numel(S)
    I = I(1:end-1);
end
tile_data = dictionary();
for idx = 1:numel(I)
    tile_id(idx) = str2double(S(I(idx)+1).erase(["Tile ",":"]));
    tile_dt =  S((I(idx)+2):(I(idx)+2 + I(2)-3)).split('');
    tile_data{tile_id(idx)} = tile_dt(:,2:end-1);
end
grid_sz = sqrt(numel(tile_id));

%% part 1
possible_transform = [0 1;0 2;0 3;0 4; 5 1; 5 2;5 3; 5 4];
for idx = 1:numel(tile_id) % try evey tile for the first corner
    Image_id = zeros(grid_sz);
    taken_tl = zeros(size(tile_id));
    taken_tl(idx) = 1;
    Image_id(1,1) = tile_id(idx);
    for tdx = 1:8 % check every orientation for the tile
        trans_sq = dictionary();
        for jdx = 1:numel(tile_id)
            trans_sq{tile_id(jdx)} = [];
        end
        trans_sq{tile_id(idx)} = possible_transform(tdx,:);
        [Image_id,trans_sq] = reconstruct_image(tile_data,tile_id,Image_id,grid_sz,trans_sq,taken_tl);
        if all(Image_id) % check if all tiles are placed
            break
        end
    end
    if all(Image_id) % check if all tiles are placed
        break
    end
end

fprintf('part 1 = %14d \n',Image_id(1,1)*Image_id(1,end)*Image_id(end,1)*Image_id(end,end))
%% part 2
% remove borders and make full image
image_final = [];
for idx = 1:grid_sz
    row = [];
    for jdx = 1:grid_sz % fill row
        tile_corrected = transform_tile(tile_data{Image_id(idx,jdx)},trans_sq{Image_id(idx,jdx)});
        row = [row tile_corrected(2:end-1,2:end-1)];
    end
    % add row to image
    image_final = [image_final; row];
end
% monster cut out
monster = ['                  # ';
           '#    ##    ##    ###';
           ' #  #  #  #  #  #   '];
[I,J] = find(monster == '#'); I = I-1;,J =J-1;
monsters = 0;
possible_transform = [0 1;0 2;0 3;0 4; 5 1; 5 2;5 3; 5 4];
for tdx = 1:8
    image_final_transformed = transform_tile(image_final,possible_transform(tdx,:));
    for idx = 1:(size(image_final,1)-size(monster,1)+1)
        for jdx = 1:(size(image_final,2)-size(monster,2)+1)
            sub_img = image_final_transformed(idx:(idx+size(monster,1)-1),jdx:(jdx+size(monster,2)-1));
            if all(sub_img(monster == '#') == '#')
                image_final_transformed(sub2ind(size(image_final),idx+I,jdx+J)) = 'O';
                monsters = monsters + 1;
            end
        end
    end
    if monsters
        image_final = image_final_transformed;
        break
    end
end
fprintf('part 2 = %14d \n',sum(image_final == '#',"all"))

%% image
figure
hold on
[I,J] = find(image_final == 'O'); scatter(I,J,10,'r^','filled')
[I,J] = find(image_final == '#'); scatter(I,J,10,'ys','filled')
[I,J] = find(image_final == '.'); scatter(I,J,10,'bO','filled')
%% functions
function [Image_id,trans_sq] = reconstruct_image(tile_data,tile_id,Image_id,grid_sz,trans_sq,taken_tl)
    for idx = 1:grid_sz %rows
        for jdx = 1:grid_sz %columns
            if Image_id(idx,jdx) 
                continue
            else
                for tdx = 1:numel(tile_id)
                    if ~taken_tl(tdx)
                        [out,Image_id,trans_sq] = try_fit(tile_data,Image_id,grid_sz,idx,jdx,tile_id(tdx),trans_sq);
                        if out
                            taken_tl(tdx) = 1;
                            [Image_id,trans_sq] = reconstruct_image(tile_data,tile_id,Image_id,grid_sz,trans_sq,taken_tl);
                            break
                        end
                    end
                end
                return
            end
        end
    end
end
function [out,Image_id,trans_sq] = try_fit(tile_data,Image_id,grid_sz,idx,jdx,fit_id,trans_sq)
    possible_transform = [0 1;0 2;0 3;0 4; 5 1; 5 2;5 3; 5 4];
    out = 0;
    for tdx = 1:8 % check every orientation for the tile
        %transform tile
        [tile_dt] = transform_tile(tile_data{fit_id},possible_transform(tdx,:));
        % see if fits in the current place
        % since fitting is from left to right and top to bottom only two
        % previously fitted tiles need to checked
        score = 0;
        if idx - 1 > 0 % top check
           score = score + check_edges(transform_tile(tile_data{Image_id(idx-1,jdx)},trans_sq{Image_id(idx-1,jdx)}),...
                                       tile_dt,'bot','top');
        else
           score = score + 1;
        end
        if jdx - 1 > 0 % right check
           score = score + check_edges(transform_tile(tile_data{Image_id(idx,jdx-1)},trans_sq{Image_id(idx,jdx-1)}),...
                                       tile_dt,'right','left');
        else
           score = score + 1;
        end
        if score == 2
            Image_id(idx,jdx) = fit_id;
            trans_sq{fit_id} = possible_transform(tdx,:);
            out = 1;
            return
        end
    end
end
function [out] = check_edges(tile1,tile2,edge1,edge2) % check if selected edges match
    out = all(get_edge(tile1,edge1) == get_edge(tile2,edge2));
end

function [edge_data] = get_edge(tile_data,edge_id) % retrieve edge
    if strcmp(edge_id,'top')
        edge_data = tile_data(1,:);
    elseif strcmp(edge_id,'bot')
        edge_data = tile_data(end,:);
    elseif strcmp(edge_id,'left')
        edge_data = tile_data(:,1);
    elseif strcmp(edge_id,'right')
        edge_data = tile_data(:,end);
    end
end
function [tile_data] = transform_tile(tile_data,trans_sq) % rotate/flip tile from the sq
    for idx = 1:numel(trans_sq)
        if trans_sq(idx) == 1
            tile_data = rot90(tile_data,1);
        elseif trans_sq(idx) == 2
            tile_data = rot90(tile_data,2);
        elseif trans_sq(idx) == 3
            tile_data = rot90(tile_data,-1);
        elseif trans_sq(idx) == 4
            tile_data = rot90(tile_data,0);
        elseif trans_sq(idx) == 5
            tile_data = flipud(tile_data);
        elseif trans_sq(idx) == 6
            tile_data = fliplr(tile_data);
        end
    end
end
