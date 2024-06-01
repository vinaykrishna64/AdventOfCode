clear all
part_1()
part_2()
function [] = part_2()
    filename            = 'input.txt';
    S                   = readlines(filename);
    S = S.split('');
    S = str2double(S(:,2:end-1));
    direcs = [0 1;1 0;0 -1;-1 0];
    % implementation of priority queue in matlab
    states = [0 1 1 0 0 0]; % state = loss so far, current r, current col,
    % current dir r, current dir y, how may times current direction is
    % travelled consequectively
    seen_States = [0 0 0 0 0];
    sz = size(S);
    destination = sz;
    while numel(states)
        states = sortrows(states,1);
        current_state = states(1,:);
        states(1,:) = [];
        if all(current_state(2:3) == destination) & current_state(6) > 3 %first find is the optimum in priority queue
            fprintf('part 2 = %14d \n',current_state(1)) 
            break
        end
        if ismember(current_state(2:end),seen_States,"rows")
            continue
        else
           seen_States = [seen_States;current_state(2:end)];
        end
        for idx = 1:4
            new_state = [0 0 0 0 0 0];
            new_state(4:5) = direcs(idx,:);
            if all(direcs(idx,:) == current_state(4:5)) 
                if current_state(6) < 10 %direction count and break cond
                    new_state(6) = current_state(6) +1;
                    new_pos = current_state(2:3) + direcs(idx,:);
                    new_state(2:3) = new_pos;
                    if (new_pos(1) >= 1 & new_pos(1) <= sz(1)) &...
                                (new_pos(2) >= 1 & new_pos(2) <= sz(2))
                        new_state(1) = current_state(1) + S(new_pos(1),new_pos(2));
                        states = [states;new_state];
                    end
                end
            elseif all(current_state(4:5) == 0) | (all(-direcs(idx,:) ~= current_state(4:5)) & current_state(6) > 3)
                new_state(4:5) = direcs(idx,:);
                new_state(6) = 1;
                new_pos = current_state(2:3) + direcs(idx,:);
                new_state(2:3) = new_pos;
                if (new_pos(1) >= 1 & new_pos(1) <= sz(1)) &...
                            (new_pos(2) >= 1 & new_pos(2) <= sz(2))
                    new_state(1) = current_state(1) + S(new_pos(1),new_pos(2));
                    states = [states;new_state];
                end
            end
            
        end
    end
end
function [] = part_1()
    filename            = 'input.txt';
    S                   = readlines(filename);
    S = S.split('');
    S = str2double(S(:,2:end-1));
    direcs = [0 1;1 0;0 -1;-1 0];
    % implementation of priority queue in matlab
    states = [0 1 1 0 0 0]; % state = loss so far, current r, current col,
    % current dir r, current dir y, how may times current direction is
    % travelled consequectively
    seen_States = [0 0 0 0 0];
    sz = size(S);
    destination = sz;
    while numel(states)
        states = sortrows(states,1);
        current_state = states(1,:);
        states(1,:) = [];
        if all(current_state(2:3) == destination) %first find is the optimum in priority queue
            fprintf('part 1 = %14d \n',current_state(1)) 
            break
        end
        if ismember(current_state(2:end),seen_States,"rows")
            continue
        else
           seen_States = [seen_States;current_state(2:end)];
        end
        for idx = 1:4
            new_state = [0 0 0 0 0 0];
            new_state(4:5) = direcs(idx,:);
            if all(direcs(idx,:) == current_state(4:5)) 
                if current_state(6) < 3 %direction count and break cond
                    new_state(6) = current_state(6) +1;
                    new_pos = current_state(2:3) + direcs(idx,:);
                    new_state(2:3) = new_pos;
                    if (new_pos(1) >= 1 & new_pos(1) <= sz(1)) &...
                                (new_pos(2) >= 1 & new_pos(2) <= sz(2))
                        new_state(1) = current_state(1) + S(new_pos(1),new_pos(2));
                        states = [states;new_state];
                    end
                end
            elseif all(-direcs(idx,:) ~= current_state(4:5)) | all(0 == current_state(4:5))
                new_state(4:5) = direcs(idx,:);
                new_state(6) = 1;
                new_pos = current_state(2:3) + direcs(idx,:);
                new_state(2:3) = new_pos;
                if (new_pos(1) >= 1 & new_pos(1) <= sz(1)) &...
                            (new_pos(2) >= 1 & new_pos(2) <= sz(2))
                    new_state(1) = current_state(1) + S(new_pos(1),new_pos(2));
                    states = [states;new_state];
                end
            end
            
        end
    end
end
