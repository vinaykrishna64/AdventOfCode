clear all
%% preparation
filename            = 'input.txt';
S                   = readlines(filename);
S = S.split(' -> ');
node_map = struct();
node_name = [""];
for idx = 1:length(S)
    if contains(S(idx,1),"%")
        node_name(idx) = replace(S(idx,1),"%","");
        node_map.(node_name(idx)).type = 1;
        node_map.(node_name(idx)).send_to = S(idx,2).split(", ");
        node_map.(node_name(idx)).state = 0; %on off flag intially set to off
    elseif contains(S(idx,1),"&")
        node_name(idx) = replace(S(idx,1),"&","");
        node_map.(node_name(idx)).type = 2;
        node_map.(node_name(idx)).send_to = S(idx,2).split(", ");
        node_map.(node_name(idx)).inp_from = dictionary(); %input memory
    else
        node_name(idx) = S(idx,1);
        node_map.(node_name(idx)).type = 0;
        node_map.(node_name(idx)).send_to = S(idx,2).split(", ");
    end
end
% Conjunction module input memory initialization
for idx = 1:numel(node_name)
    sending_to = node_map.(node_name(idx)).send_to;
    for jdx = 1:numel(sending_to)
        if ~isfield(node_map,sending_to)
            continue
        end
        if node_map.(sending_to(jdx)).type == 2
            node_map.(sending_to(jdx)).inp_from(node_name(idx)) = 0; % initial input all low
        end
    end
end
%% solving
part_1(node_map) %P1
part_2(node_map) %p2

%% button push simulation

function [] = part_2(node_map)
    %% &xn -> rx rx gets low from xn
    %% xn needs all high to send a low
    %% keys(node_map.xn.inp_from) need to be low at the same time
    k = keys(node_map.xn.inp_from);
    seen_high = zeros(4,2);
    idx = 0;
    while true
        idx = idx + 1;
        [node_map,~,~,flgs] = push_once(node_map,k,"xn");
        for jdx = 1:4
            if flgs(jdx) == 1 & any(seen_high(jdx,:) == 0)
                if seen_high(jdx,1)
                    seen_high(jdx,2) = idx;
                else
                    seen_high(jdx,1) = idx;
                end
            end
        end
        if all(seen_high)
            break
        end
    end
    cyclelengths = diff(seen_high,1,2);
    fprintf('part 2 = %14d \n',lcm(sym(cyclelengths')))
end




function [] = part_1(node_map)
    for idx = 1:1000
        idx = idx + 1;
        [node_map,low_count(idx),high_count(idx)] = push_once(node_map,[],[]);
    end
    fprintf('part 1 = %14d \n',sum(low_count)*sum(high_count))
end

function [node_map,low_count,high_count,flgs] = push_once(node_map,k,tgt)
    pulses = ["broadcaster","0"]; %low pulse to broadcaster
    low_count = 1;
    high_count = 0;
    flgs = zeros(1,4);
    while numel(pulses)
        current = pulses(1:2);
        pulses = pulses(3:end);
        if ~isfield(node_map,current(1))
            continue
        end
        %% part 2 stuff
        if numel(k)
           for jdx = 1:4
               if node_map.(tgt).inp_from(k(jdx))
                   flgs(jdx) = 1;
               end
           end
        end
        %% handle current
        sending_to = node_map.(current(1)).send_to;
        if node_map.(current(1)).type == 1
            if str2double(current(2)) == 1
                continue
            else
                if node_map.(current(1)).state == 0
                    node_map.(current(1)).state = 1;
                    for jdx = 1:numel(sending_to)
                        if ~isfield(node_map,sending_to)
                            high_count = high_count + 1;
                            continue
                        end
                        pulses = [pulses, sending_to(jdx), "1"];
                        high_count = high_count + 1;
                        if node_map.(sending_to(jdx)).type == 2
                            node_map.(sending_to(jdx)).inp_from(current(1)) = str2double("1");
                        end
                    end
                else
                    node_map.(current(1)).state = 0;
                    for jdx = 1:numel(sending_to)
                        if ~isfield(node_map,sending_to)
                            high_count = high_count + 1;
                            continue
                        end
                        pulses = [pulses, sending_to(jdx), "0"];
                        low_count = low_count + 1;
                        if node_map.(sending_to(jdx)).type == 2
                            node_map.(sending_to(jdx)).inp_from(current(1)) = str2double("0");
                        end
                    end
                end
            end
        elseif node_map.(current(1)).type == 2
            if all(values(node_map.(current(1)).inp_from))
                for jdx = 1:numel(sending_to)
                    if ~isfield(node_map,sending_to)
                        low_count = low_count + 1;
                        continue
                    end
                    pulses = [pulses, sending_to(jdx), "0"];
                    low_count = low_count + 1;
                    if node_map.(sending_to(jdx)).type == 2
                        node_map.(sending_to(jdx)).inp_from(current(1)) = str2double("0");
                    end
                end
            else
                for jdx = 1:numel(sending_to)
                    if ~isfield(node_map,sending_to)
                        high_count = high_count + 1;
                        continue
                    end
                    pulses = [pulses, sending_to(jdx), "1"];
                    high_count = high_count + 1;
                    if node_map.(sending_to(jdx)).type == 2
                        node_map.(sending_to(jdx)).inp_from(current(1)) = str2double("1");
                    end
                end
            end
        else
            for jdx = 1:numel(sending_to)
                if node_map.(sending_to(jdx)).type == 1
                    pulses = [pulses, sending_to(jdx), current(2)];
                    low_count = low_count + 1;
                elseif node_map.(sending_to(jdx)).type == 2
                    node_map.(sending_to(jdx)).inp_from(current(1)) = str2double(current(2));
                    low_count = low_count + 1;
                end
            end
        end
    end
end

