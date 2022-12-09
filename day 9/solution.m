clear all
clc

S = readlines("input.txt").replace(["U","D","L","R"],string(1:4)).split(" ").double();
S = repelem(S(:,1),S(:,2),1);
directions = [0 1; 0 -1; -1 0;1 0];
head_move = cumsum([[1 1];directions(S,:)]); % head trajectory


%% part 1
tail_visit = simulation(2,head_move);
min_val = - min(tail_visit,[],"all") + 1; %make vectors positive for indexing

part_1 = numel(unique( sub2ind(1000*[1 1],tail_visit(end,1:2:end)+min_val,tail_visit(end,2:2:end)+min_val)))

figure
subplot(2,1,1)
plot(head_move(:,1),head_move(:,2),'b*')
hold on
plot(tail_visit(end,1:2:end),tail_visit(end,2:2:end),'r*')
grid on
legend({'head','tail'})
title('tail & head path part 1')


%% part 2
tail_visit = simulation(10,head_move);
min_val = - min(tail_visit,[],"all") + 1; %make vectors positive for indexing

part_2 = numel(unique( sub2ind(1000*[1 1],tail_visit(end,1:2:end)+min_val,tail_visit(end,2:2:end)+min_val)))

subplot(2,1,2)
plot(head_move(:,1),head_move(:,2),'b*')
hold on
plot(tail_visit(end,1:2:end),tail_visit(end,2:2:end),'r*')
grid on
legend({'head','tail'})
title('tail & head path part 2')
exportgraphics(gcf,'path_plot.jpeg','Resolution',1200)
%% functions
function [tail_visit] = simulation(n_heads,head_move)
    tail_visit = [];
    tails = ones(n_heads-1,2);
    tail_visit = [tail_visit tails];
    for j = 1:size(head_move,1)
        head = head_move(j,:);
        for i = 1:n_heads-1
            tails(i,:) = move_tail(head,tails(i,:));
            head = tails(i,:);
        end
        tail_visit = [tail_visit tails];
    end
end
function [tail] = move_tail(head,tail)
    xy =  head - tail;
    if ~(all(abs(xy)<= 1)) %if not move
        tail = tail + sign(xy);
    end
end

