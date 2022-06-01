function [img_out] = single_process(img_bw)
%UNTITLED7 此处显示有关此函数的摘要
%   此处显示详细说明
    [row,col] = size(img_bw);
    %寻找上下左右四个边界的坐标
    for i = 1 : row
        flag = 0;
        for j = 1 : col
            %从上往下扫描，遇到某一行有黑色的像素，则找到上边界
            if img_bw(i,j) == 0
                top = i;
                flag = 1;
                break;
            end
        end
        if flag == 1
            break;
        end
    end
    for i = row : -1 : 1
        flag = 0;
        for j = 1 : col
            if img_bw(i,j) == 0
                down = i;
                flag = 1;
                break;
            end
        end
        if flag == 1
            break;
        end
    end
    for j = 1 : col
        flag = 0;
        for i = 1 : row
            if img_bw(i,j) == 0
                left = j;
                flag = 1;
                break;
            end
        end
        if flag == 1
            break;
        end
    end
    for j = col : -1 : 1
        flag = 0;
        for i = 1 : row
            if img_bw(i,j) == 0
                right = j;
                flag = 1;
                break;
            end
        end
        if flag == 1
            break;
        end
    end
    %找到上下左右所有的边界后，直接切割出来即可
    img_out = imcrop(img_bw,[left top (right - left) (down - top)]);
end

