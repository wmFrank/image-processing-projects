function [out] = getblock(in)
out = in;
[x,y] = size(in);
%设置一个标志位
flag = 0;
%定义一个一维矩阵来记录切割点的坐标
y_points = [];
%遍历每一行，对每一行的黑白像素进行计数
for j = 1 : y
    count_black = 0;
    count_white = 0;
    for i = 1 : x
        if in(i,j) == 0
            count_black = count_black + 1;
        else
            count_white = count_white + 1;
        end
    end
    %黑色像素多于70%，可以认定是刚刚触碰到黑色边界
    if flag == 0 && count_black >= 0.7 * x
        flag = 1;
        y_points = cat(1,y_points,j - 1);
    %白色像素多于50%，可以认定是刚刚越过了黑色边界
    elseif flag == 1 && count_white >= 0.5 * x
        flag = 0;
        y_points = cat(1,y_points,j);
    end
end
flag = 0;
x_points = [];
for i = 1 : x
    count_black = 0;
    count_white = 0;
    for j = 1 : y
        if in(i,j) == 0
            count_black = count_black + 1;
        else
            count_white = count_white + 1;
        end
    end
    if flag == 0 && count_black >= 0.7 * y
        flag = 1;
        x_points = cat(1,x_points,i - 1);
    elseif flag == 1 && count_white >= 0.4 * y
        flag = 0;
        x_points = cat(1,x_points,i);
    end
end
[x1,y1] = size(x_points);
[x2,y2] = size(y_points);
x_points = x_points(2:x1 - 1,:);
y_points = y_points(2:x2 - 1,:);
[x1,y1] = size(x_points);
[x2,y2] = size(y_points);
for i = 1 : 2 : x1
    for j = 1 : 2 : x2
        block = imcrop(in,[y_points(j,1) x_points(i,1) (y_points(j + 1,1) - y_points(j,1)) (x_points(i + 1,1) - x_points(i,1))]);
        [row,col] = size(block);
        %定义标志位以及存储切割点的矩阵
        col_points = [];
        flag = 0;
        %从左到右进行扫描，计算每一列的黑色像素的个数
        for m = 1 : col
            count_black = 0;
            for n = 1 : row
                 if block(n,m) == 0
                     count_black = count_black + 1;
                 end
            end
            %遇到黑色像素，则遇到一个数字或者运算符
            if flag == 0 && count_black > 0
                flag = 1;
                col_points = cat(1,col_points,m - 1);
            %遇到纯白，那么一定是刚刚越过一个数字或者运算符    
            elseif flag == 1 && count_black == 0
                col_points = cat(1,col_points,m);
                flag = 0;
            end
        end
        [x3,y3] = size(col_points);
        digit = [];
        operator = [];
        a = 0;
        %得到切片之后，按照“数字+运算符+数字+等于号”的格式进行识别
        for t = 1 : 2 : x3
            a = a + 1;
            clip = imcrop(block,[col_points(t,1) 1 (col_points(t + 1,1) - col_points(t,1)) row - 1]);
            if mod(a,2) == 1
                digit = cat(1,digit,str2num(my_digit(clip)));
            else
                if my_operator(clip) == "+"
                    operator = cat(1,operator,-1);
                elseif my_operator(clip) == "-"
                    operator = cat(1,operator,-2);
                elseif my_operator(clip) == "-"
                    operator = cat(1,operator,-3);
                end
            end
        end
        result = 0;
        %判断运算符是什么并进行相应的计算得到结果
        if operator(1,1) == -1
            result = digit(1,1) + digit(2,1);
        elseif operator(1,1) == -2
            result = digit(1,1) - digit(2,1);
        end
        %根据得到的结果读取相应的样本图片
        img_num = imread(strcat('digit_sample/',num2str(result),'.png'));
        [x4,y4] = size(img_num);
        %得到左上角的相应坐标
        left_top = [x_points(i,1) + round((row - x4) / 2) - 6 y_points(j,1) + col_points(x3,1) + round((col - col_points(x3,1) - y4) / 2)];
        %利用双层的循环将样本图片的像素值赋值到原来的式子中
        for ii = 1 : x4
            for jj = 1 : y4
                out(left_top(1,1) + ii,left_top(1,2) + jj) = img_num(ii,jj);
            end
        end
    end
end
end

