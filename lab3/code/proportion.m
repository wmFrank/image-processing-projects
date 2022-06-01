function [output] = proportion(image)
num_black = 0;
[row,col] = size(image);
%遍历整个图片，统计黑色像素的数目
for i = 1 : row
    for j = 1 : col
        if image(i,j) == 0
            num_black = num_black + 1;
        end
    end
end
%用黑色像素的数目除以总个数即得到比例
output = num_black * 1.0 / (row * col);
end

