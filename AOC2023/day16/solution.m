clear all
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split('').replace([".","|","-","/","\"],["0","1","2","3","4"]);
S = padarray(str2double(S(:,2:end-1)),[1 1],0,'both');


fprintf('part 1 = %14d \n',search(S,[2,1,0,1]))
sz = size(S);
% gather all entrances and search
starts = [[2:sz(1)-1]' ones(sz(1)-2,1) zeros(sz(1)-2,1) ones(sz(1)-2,1)];
starts = [starts ; [[2:sz(1)-1]' sz(2)*ones(sz(1)-2,1) zeros(sz(1)-2,1) -ones(sz(1)-2,1)]];
starts = [starts ; [ones(sz(2)-2,1) [2:sz(2)-1]' ones(sz(1)-2,1) zeros(sz(1)-2,1)]];
starts = [starts ; [sz(1)*ones(sz(2)-2,1) [2:sz(2)-1]' -ones(sz(1)-2,1) zeros(sz(1)-2,1)]];
N = 0;
for idx = 1:size(starts,1)
        N = max(N,search(S,starts(idx,:)));
end
fprintf('part 2 = %14d \n',N)

function N = search(S,beam)
    beams = beam;
    sz = size(S);
    E = zeros(sz);
    visits = beams;
    flg = 0;
    while size(beams,1)
        new_beams = [];
        for idx = 1:size(beams,1) 
            if (beams(idx,1) == 1 | beams(idx,1) == sz(2)) & flg %one beam goes in can check for exits row bounds
                continue
            elseif (beams(idx,2) == 1 | beams(idx,2) == sz(1)) & flg  %one beam goes in can check for exits col bounds
                continue
            else
                if beams(idx,3) % move up down
                    cond = S(beams(idx,1)+beams(idx,3),beams(idx,2));
                    if ~cond | cond == 1 % 0 or | ignore
                        new_beams(end+1,:) = [beams(idx,1)+beams(idx,3),beams(idx,2),beams(idx,3),0];
                        E(beams(idx,1)+beams(idx,3),beams(idx,2)) = 1;
                    elseif cond == 2  % - split
                        E(beams(idx,1)+beams(idx,3),beams(idx,2)) = 1;
                        new_beams(end+1,:) = [beams(idx,1)+beams(idx,3),beams(idx,2),0,1];
                        new_beams(end+1,:) = [beams(idx,1)+beams(idx,3),beams(idx,2),0,-1];
                    elseif cond == 3 % / divert
                        E(beams(idx,1)+beams(idx,3),beams(idx,2)) = 1;
                        if beams(idx,3) == -1 %upward moves left
                            new_beams(end+1,:) = [beams(idx,1)+beams(idx,3),beams(idx,2),0,1];
                        else %downward moves right
                            new_beams(end+1,:) = [beams(idx,1)+beams(idx,3),beams(idx,2),0,-1];
                        end
                    elseif cond == 4 % \ divert
                        E(beams(idx,1)+beams(idx,3),beams(idx,2)) = 1;
                        if beams(idx,3) == -1 %upward moves right
                            new_beams(end+1,:) = [beams(idx,1)+beams(idx,3),beams(idx,2),0,-1];
                        else %downward moves left
                            new_beams(end+1,:) = [beams(idx,1)+beams(idx,3),beams(idx,2),0,+1];
                        end
                    end
                else % moves right or left
                    cond = S(beams(idx,1),beams(idx,2)+beams(idx,4));
                    if ~cond | cond == 2 % 0 or - ignore
                        new_beams(end+1,:) = [beams(idx,1),beams(idx,2)+beams(idx,4),0,beams(idx,4)];
                        E(beams(idx,1),beams(idx,2)+beams(idx,4)) = 1;
                    elseif cond == 1  % | split
                        E(beams(idx,1),beams(idx,2)+beams(idx,4)) = 1;
                        new_beams(end+1,:) = [beams(idx,1),beams(idx,2)+beams(idx,4),1,0];
                        new_beams(end+1,:) = [beams(idx,1),beams(idx,2)+beams(idx,4),-1,0];
                    elseif cond == 3 % / divert
                        E(beams(idx,1),beams(idx,2)+beams(idx,4)) = 1;
                        if beams(idx,4) == -1 % left ward moves down
                            new_beams(end+1,:) = [beams(idx,1),beams(idx,2)+beams(idx,4),1,0];
                        else % rightward ward moves up
                            new_beams(end+1,:) = [beams(idx,1),beams(idx,2)+beams(idx,4),-1,0];
                        end
                    elseif cond == 4 % \ divert
                        E(beams(idx,1),beams(idx,2)+beams(idx,4)) = 1;
                        if beams(idx,4) == -1 % left ward moves up
                            new_beams(end+1,:) = [beams(idx,1),beams(idx,2)+beams(idx,4),-1,0];
                        else % rightward ward moves down
                            new_beams(end+1,:) = [beams(idx,1),beams(idx,2)+beams(idx,4),1,0];
                        end
                    end
                end
            end
            flg = 1; %one beam goes in can check for exits
            if any(ismember(visits,new_beams(end,:),'rows'))
                   new_beams(end,:) = [];
            end
        end
        beams = new_beams;
        visits = [visits;beams];
        N = sum(E(2:end-1,2:end-1),"all");
    end
end