function [output] = my_digit(input_image)
%in this function, you should finish the digit recognition task.
%the input parameter is a matrix of an image which contains a digit.
%the output parameter represents which digit it is.

%getsamples();
[x,y] = size(input_image);
sum = 0;
for i = 1 : x
    for j = 1 : y
        if input_image(i,j) == 1 || input_image(i,j) == 0
            sum = sum + 1;
        end
    end
end
if sum ~= x * y
    input_image = im2bw(input_image);
end
output_image = single_process(input_image);
diff = 100;
output = '';
%读取所有的样本图片
file_inpath = 'digit_sample/';
img_path_list = dir(strcat(file_inpath,'*.png'));
img_num = length(img_path_list);
%遍历所有的样本图片
for k = 1 : img_num
    img_name = img_path_list(k).name;
    img_bw = imread(strcat(file_inpath,img_name));
    %进行相似度计算，得到方差
    different = similarity(output_image,img_bw);
    %比较方差，取最小的方差为最终识别出来的数字
    if different < diff
        diff = different;
        name = strsplit(img_name,'.');
        output = char(name(1));
    end
end
end