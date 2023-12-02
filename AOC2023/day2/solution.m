clear all
filename  = 'input.txt';
S         = readlines(filename);
S         = S.split(': ');
Games     = S(:,2);

Bag       = [12,13,14]; % RGB cubes

Game_vals = arrayfun(@(x) isPossibleGame(x,Bag),Games,'UniformOutput',false);
Game_vals = cell2mat(Game_vals);

fprintf('part 1 = %d \n',sum(find(Game_vals(:,1) == 1)))
fprintf('part 2 = %d \n',sum(Game_vals(:,2)))


function [out] = isPossibleGame(game,Bag) % check if a games is possible by going through all draws and estimates the required cube power
    Bag_req    = [0,0,0];
    draws      = strtrim(game.split(";"));
    for jdx = 1:numel(draws)
        Bag_req = Checkcubes(draws(jdx),Bag_req); %set max cubes required for the game based of each draw
    end
    % game possible if max cubes are in the bag
    % Cube power is product of max cubes
    out = [double(all(Bag >= Bag_req)) prod(Bag_req)];
    function [Bag] = Checkcubes(draw,Bag) % set the max cube required for the whole game based on this draw
        draw       = strtrim(draw.join(',').split(','));
        color_str  = ["red";"green";"blue"];
        draws_num  = str2double(draw.replace(color_str,string(num2str([1:3]'))).split(' '));
        if iscolumn(draws_num) % adjust row column transformation for single color draws
            draws_num = draws_num';
        end 
        for idx = 1:size(draws_num,1)
            if Bag(draws_num(idx,2)) < draws_num(idx,1) % if the Bag has deficiency set max cubes accordingly
                Bag(draws_num(idx,2)) = draws_num(idx,1);
            end
        end
    end
end


