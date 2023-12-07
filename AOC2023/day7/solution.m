clear all
filename            = 'input.txt';
S                   = readlines(filename);
face = [ "T" "J" "Q" "K" "A" ];
nums = string([2:1:9]');
cards = [nums; face'];
card_ranks = string([1:1:13]');
cards_ranks_weak = string([2:10 1 11:13]');

hands = S.extractBefore(' ');
bids = str2double(S.extractAfter(' '));
for idx = 1:numel(hands)
    %% part 1
    hand                = hand2Vec(hands(idx),cards,card_ranks);
    scores_default(idx) = Base_score(hand); %% base score on the card order used for tie breaks
    case_ID(idx)        = score_case(hand); %% case of rank hierarchy
    %% part 2
    %% determine best possible with replacements
    hand              = hand2Vec(hands(idx),cards,cards_ranks_weak);
    scores_weak(idx)  = Base_score(hand); 
    case_best(idx)    = case_ID(idx);
    if any(hand == 1) % if J
        Unq_cards = unique(hand);
        Unq_cards = Unq_cards(Unq_cards ~= 1);
        for jdx = 1:numel(Unq_cards) % try each replacemen and find the best case
            dummy = hand;
            dummy(hand == 1) = Unq_cards(jdx);
            S = score_case(dummy);
            if S > case_best(idx) 
                case_best(idx) = S;
            end
        end
    end
end


[~,I1]  = sort(scores_default + case_ID*10e12,'ascend');

fprintf('part_1 = %10d\n',sum(bids(I1).*[1:numel(bids)]'))

[~,I2]  = sort(scores_weak + case_best*10e12,'ascend');

fprintf('part_2 = %10d\n',sum(bids(I2).*[1:numel(bids)]'))


%% functions
function [Vec] = hand2Vec(hand,cards,ranks)
    Vec = hand.split('').replace(cards,ranks);
    Vec = str2double(Vec(2:end-1));
end
function [out] = Base_score(hand)
    dummy = cell2mat(arrayfun(@(x) digtisConv(x),hand));
    out = str2double(string(dummy).join(''));
    function [x] = digtisConv(x)
        if x<10
            x = string(strcat('0',num2str(x)));
        else 
            x = string(x);
        end
    end
end

function [out] = score_case(hand)
    C = sort(groupcounts(hand),'descend');
    out = 0;
    if C(1) == 5 % 5 of a kind
        out = 6;
    elseif C(1) == 4 % four of a kind 
        out = 5;
    elseif C(1) == 3 & C(2) == 2 %full house
        out = 4;
    elseif C(1) == 3 & C(2) == 1%three of a kind
        out = 3;
    elseif C(1) == 2 & C(2) == 2% two pair 
        out = 2;
    elseif C(1) == 2 %one pair
         out =1;
    end
end





























































