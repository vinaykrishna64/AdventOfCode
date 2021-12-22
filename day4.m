clc
clear all

fid = fopen('day4.txt');
line_1 = fgetl(fid);  
line_2 = fgetl(fid); 
sq = strcat(line_1, line_2);
sq = split(sq,",");
for i = 1:length(sq)
    draw(i) = str2num(sq{i});
end
board = 1;
LAST = [ 52    55    13    83    78];
stop = 0;
while stop == 0
   i = 1;
   S = fgetl(fid);
   while length(S) > 0 & i <6
       S = split(S," ");
       row = [];
       j = 1;
         for J = 1:length(S)
            if ~strcmp(S{J},'')
                row(j) = str2num(S{J});
                j = j+1;
            end
         end
         B(i,:,board) = row;
         i = i + 1;
         if i == 6
             board = board + 1;
         end
         if LAST == row
                 
             stop = 1;
             break
         end
         S = fgetl(fid);
   end
end
%% problem 1
% sz = size(B);
% score = zeros(sz);
% 
% for i = 1:length(draw)
%     score = score_cards(B,score,draw(i));
%     wins = check_win(score);
%     if any(wins == 1)
%         last_call = draw(i);
%         break
%     end
% end
% 
% I = find(wins == 1);
% 
% card = B(:,:,I);
% score_card = score(:,:,I);
% J = find(score_card == 0);
% ans1 = sum(card(J)) * last_call
%% prob 2
sz = size(B);
score = zeros(sz);
order = zeros(1,sz(3));
O = 1;
for i = 1:length(draw)
    score = score_cards(B,score,draw(i));
    wins = check_win(score);
    
    if any(wins == 1)
        i1 = find(wins == 1);
        flag = 0;
        for j = i1
            if order(j) == 0
                order(j) = O;
                flag = 1;
            end
        end
        if flag == 1
            O = O + 1;
        end
    end
    if sum(order > 0) == sz(3)
        last_call = draw(i);
        break
    end
end

[m,I] = max(order);

card = B(:,:,I);
score_card = score(:,:,I);
J = find(score_card == 0);
ans2 = last_call * sum(card(J))
%% funcs
function score = score_cards(B,score,draw)
sz = size(B);
    for I = 1:sz(3)
        if any(B(:,:,I) == draw,'all')
            [row,col] =  find(B(:,:,I) == draw);
            score(row,col,I) = 1;
        end
    end    
end
function wins = check_win(score)
sz = size(score);
wins = zeros(1,sz(3));
    for I = 1:sz(3)
        card = score(:,:,I);
        if  any(all(card==1,2)) | any(all(card==1,1))
            wins(I) = 1;
        end
    end  

end