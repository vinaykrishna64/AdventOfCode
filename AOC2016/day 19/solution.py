import copy


with open("input.txt",'r') as f:
    S = f.readlines()

N = int(''.join(S))
## pattern matlab code for finding the pattern
# for idx = 1:1000
#     Lt(idx) = last(idx);
# end
# plot(Lt)
# function n = last(N)
#     n = 1:N;
#     while numel(n) > 1
#         if mod(numel(n),2)
#             n = n(3:2:end);
#         else
#             n = n(1:2:end);
#         end
#     end
# end
# pattern is that it is always 1 at the powers of 2 and then increase by 2
for i in range(0,100):
    if 2**i <= N and 2**(i+1) > N:
        print('part_1 = ',2*(N- 2**i ) + 1)
        break

## part 2 is a double sloped pattern based on powers of 3
# at 3 powers it's exactly powers of 3
# from 3 power +1 to 2 time 3 power i.e. 10 to 18 it starts from 1 and increases by 1
# from 2 time 3 power +1 to next 3 power ie.e 19 to 27 it increases by 2
# for idx = 1:81
# Lt(idx) = last(idx);
# end
# figure
# plot(Lt)

# function n = last(N)
#     n = 1:N;
#     while numel(n) > 1
#         if mod(numel(n),2)
#             n = [n(1:floor(numel(n)/2)) n(ceil(numel(n)/2)+1:end)];
#         else
#             n = [n(1:floor(numel(n)/2)) n(ceil(numel(n)/2)+2:end)];
#         end
#         n = circshift(n,-1);
#     end
# end

for i in range(0,100):
    if 3**i <= N and 3**(i+1) > N:
        if N == 3**i:
            print('part_2 = ',3**i)
        elif N <= 2*3**i:
            print('part_2 = ',N - 3**i)
        else:
            print('part_2 = ',3**i + 2*(N- 2*3**i ) + 1)
        break
        


