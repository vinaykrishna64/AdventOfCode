%% part 1
clear all
clc
S = readlines("input.txt");


head_visit = simulation(2,S);

figure
subplot(2,1,1)
plot(head_visit(1,1:2:end),head_visit(1,2:2:end),'b*')
hold on
plot(head_visit(2,1:2:end),head_visit(2,2:2:end),'r*')
grid on
sz = max(head_visit,[],'all');
visits = zeros(sz);
visits( sub2ind(sz*[1 1],head_visit(2,1:2:end),head_visit(2,2:2:end))) = 1;
legend({'head','tail'})
title('tail & head path part 1')
part_1 = sum(visits,'all')

%% part 2


S = readlines("input.txt");


head_visit = simulation(10,S);



sz = max(head_visit,[],'all');
visits = zeros(sz);
visits( sub2ind(sz*[1 1],head_visit(10,1:2:end),head_visit(10,2:2:end))) = 1;
subplot(2,1,2)
plot(head_visit(1,1:2:end),head_visit(1,2:2:end),'b*')
hold on
plot(head_visit(end,1:2:end),head_visit(end,2:2:end),'r*')
grid on
legend({'head','tail'})
title('tail & head path part 2')
part_2 = sum(visits,'all')
exportgraphics(gcf,'path_plot.jpeg','Resolution',1200)
%% functions
function [head_visit] = simulation(n_heads,S)
    head_visit = [];
    
    head = 300* ones(n_heads,2);
    
    head_visit = [head_visit head];
    
    
    for i = 1:numel(S)
        cmd = S(i).split(" ");
        if cmd{1} == "R" | cmd{1} == "L"
            x = str2double(cmd{2});
            k = 1;
            if cmd{1} == "L"
                k = -1;
            end
            for j = 1:x
                % move head
                head(1,1) = head(1,1) + k;
                % move tails
                for T = 2:n_heads
                    head(T,:) = move_tail(head(T-1,:),head(T,:));
                end
                head_visit = [head_visit head];
            end
        else
            y = str2double(cmd{2});
            k = 1;
            if cmd{1} == "D"
                k = -1;
            end
            for j = 1:y
                % move head
                head(1,2) = head(1,2) + k;
                % move tails
                for T = 2:n_heads
                    head(T,:) = move_tail(head(T-1,:),head(T,:));
                end
                head_visit = [head_visit head];
            end
        end
    end
end
function [tail] = move_tail(head,tail)
    xy =  head - tail;
    if ~(abs(xy(1))<= 1 & abs(xy(2))<= 1) %if not move
        if abs(xy(2))== 2 & abs(xy(1)) == 0
            tail(2) = tail(2) + sign(xy(2));
        elseif  abs(xy(1))== 2 & abs(xy(2)) == 0
            tail(1) = tail(1) + sign(xy(1));
        else
            tail = tail + sign(xy);
        end
    end
end

