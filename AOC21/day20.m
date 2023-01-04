clc
clear all

data = readlines('day20.txt',"EmptyLineRule","skip");
code_end = 1;
pixel_map = containers.Map({'.','#'},[0,1]);
% read the 9 bit code 
code = zeros(1,512);
count = 1;
for i = 1:code_end
    line = char(data(i,:));
    for j = 1:length(line)
        code(count) = pixel_map(line(j));
        count = count + 1;
    end
end

% read the image
count = 1;
for i = code_end+1:length(data)
    line = char(data(i,:));
    for j = 1:length(line)
        grid(count,j) = pixel_map(line(j));
    end
    count = count + 1;
end
imshow(1-grid,'initialMagnification',2500)

%% main
for i = 1:50
    grid = img_enhance(grid,code,1-mod(i,2));
    disp(i)
end
sum(grid,'all')
imshow(1-grid,'initialMagnification',2500)


%% functions

function out1 = img_enhance(grid,code,pad)
grid = padarray(grid,[2,2] ,pad, 'both');
out = zeros(size(grid));
sz = size(out);
for i = 2:sz(1)-1
    for j = 2:sz(2)-1
        out(i,j) =  Decode_pixel(grid(i-1:i+1,j-1:j+1), code);
    end
end
out1 = out(2:sz(1)-1,2:sz(2)-1);
end

function out = Decode_pixel(sub_grid, code)
bin_vec = reshape(sub_grid',1,[]);
out = code(binaryVectorToDecimal(bin_vec)+1);
end
