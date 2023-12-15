clear all
filename            = 'input.txt';
S                   = readlines(filename);
p = zeros([numel(S),2]);
tic
for idx = 1:numel(S)
    sq = char(S(idx).extractBefore(' '));
    code = str2double(S(idx).extractAfter(' ').split(','));
    p(idx,1) = Count_possibilites(sq,code);
    
    sq2 = [sq '?' sq '?' sq '?' sq '?' sq];
    code2 = [code; code; code; code; code];
    p(idx,2) = Count_possibilites(sq2,code2);
end
disp(toc)
fprintf('part 1 = %14d \n',sum(p(:,1)))
fprintf('part 2 = %14d \n',sum(p(:,2)))

function [count] = Count_possibilites(sq,code) %% needs further optimization
    %% https://www.youtube.com/watch?v=g3Ms5e7Jdqo
    %% method from here ^^
    % sq - springs
    % code - code given for blocks
    %% Cache
    persistent Cache
    if isempty(Cache)
        Cache = dictionary('1',0);
    end
    ck = [sq char(code')];
    if isKey(Cache,ck)
        count = Cache(ck);
        return
    end
    %% Validation block
    count = 0;

    if sum(code) > numel(sq) % springs are not enough to complete 
        Cache(ck) = count;
        return
    end
    
    if numel(sq) == 0 % all springs processed
        if numel(code) == 0
            count = 1;
        end
    elseif numel(code) == 0 % all blocks processed
        if all(sq ~= '#') % no springs left
           count = 1;
        end
    else
        if sq(1) == '.' | sq(1) == '?'
            count = count + Count_possibilites(sq(2:end),code); %reduce sequence size
        end
        if sq(1) == '#' | sq(1) == '?'
            if code(1) <= numel(sq) & ~any(sq(1:code(1)) == '.') & (code(1) == numel(sq) | sq(code(1)+1) ~= '#')
                count = count + Count_possibilites(sq(code(1)+2:end),code(2:end));
            end
        end
    end
    Cache(ck) = count;
end
