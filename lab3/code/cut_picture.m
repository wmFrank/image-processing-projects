function [output1,output2,output3,output4] = cut_picture(input)
[row,col] = size(input);
row_split = row / 2;
col_split = col / 2;
output1 = imcrop(input,[1 1 col_split - 1 row_split - 1]);
output2 = imcrop(input,[col_split 1 col - col_split - 1 row_split - 1]);
output3 = imcrop(input,[1 row_split col_split - 1 row - row_split - 1]);
output4 = imcrop(input,[col_split - 1 row_split - 1 col - col_split - 1 row - row_split - 1]);
end

