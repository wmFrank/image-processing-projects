%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary 
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores  

function [output] = my_edgelinking(binary_image, row, col)
    %���ַ�����ѡ��
    %output = my_edgelinking_m1(binary_image, row, col);
    output = my_edgelinking_m2(binary_image, row, col);
end

%����һ�����Դ����ϱ�Ե
function [output] = my_edgelinking_m1(binary_image, row, col)
output = [row col];
if(binary_image(row, col) == 0)
    return;
end
[m,n] = size(binary_image);
sign_image = zeros(m,n);
sign_image(row,col) = 2;
row_tmp = row;
col_tmp = col;
[row_tmp,col_tmp] = find_next_m1(binary_image,row_tmp,col_tmp,sign_image);
while(~((row_tmp == row && col_tmp == col) || (row_tmp == -1 && col_tmp == -1)))
    output = cat(1,output,[row_tmp col_tmp]);
    sign_image(row_tmp,col_tmp) = 1;
    [row_tmp,col_tmp] = find_next_m1(binary_image,row_tmp,col_tmp,sign_image);
end
output = cat(1,output,[row col]);
end

function [row_tmp, col_tmp] = find_next_m1(binary_image,row,col,sign_image)
[m,n] = size(binary_image);
find = 0;
ending = 0;
dis = 0;
while(ending == 0 && find == 0)
    %�뾶ÿ�μ�1
    dis = dis + 1;
    getpath = [];
    %�õ���ΧһȦ��·��������getpath��
    for j = col - dis : col + dis
        if row - dis >= 1 && row - dis <= m && j >= 1 && j <= n && sign_image(row - dis, j) ~= 1
            getpath = cat(1,getpath,[row - dis j]);
        end
    end
    for i = row - dis + 1 : row + dis - 1
        if i >= 1 && i <= m && col + dis >= 1 && col + dis <= n && sign_image(i, col + dis) ~= 1
            getpath = cat(1,getpath,[i col + dis]);
        end
    end
    for j = col + dis : -1 : col - dis
        if row + dis >= 1 && row + dis <= m && j >= 1 && j <= n && sign_image(row + dis, j) ~= 1
            getpath = cat(1,getpath,[row + dis j]);
        end
    end
    for i = row + dis - 1 : -1 : row - dis + 1
        if i >= 1 && i <= m && col - dis >= 1 && col - dis <= n && sign_image(i, col - dis) ~= 1
            getpath = cat(1,getpath,[i col - dis]);
        end
    end
    if size(getpath) == [0,0]
        ending = 1;
        break;
    end
    [len,wid] = size(getpath);
    %�����������ΧһȦ·���ϵĵ㣬���лҶ�Ϊ1�ĵ�����Ϊ��һ����ʼ�㣬��û�������������뾶
    for i = 1 : len
        x = getpath(i,1);
        y = getpath(i,2);
        if(sign_image(x,y) == 2)
            ending = 1;
            break;
        end
        if(binary_image(x,y) == 1)
            row_tmp = x;
            col_tmp = y;
            find = 1;
            break;
        end
    end
end
if ending == 1
    row_tmp = -1;
    col_tmp = -1;
end
end

%�����������Դ����ظ����Ե
function [output] = my_edgelinking_m2(binary_image, row, col)
output = [row col];
if(binary_image(row, col) == 0)
    return;
end
[m,n] = size(binary_image);
sign_image = zeros(m,n);
sign_image(row,col) = 2;
dir = 7;
row_tmp = row;
col_tmp = col;
[row_tmp,col_tmp,dir] = find_next_m2(binary_image,row_tmp,col_tmp,sign_image,dir);
while(~((row_tmp == row && col_tmp == col) || (row_tmp == -1 && col_tmp == -1)))
    output = cat(1,output,[row_tmp col_tmp]);
    sign_image(row_tmp,col_tmp) = 1;
    [row_tmp,col_tmp,dir] = find_next_m2(binary_image,row_tmp,col_tmp,sign_image,dir);
end
output = cat(1,output,[row col]);
end

function [row_tmp, col_tmp, dir_tmp] = find_next_m2(binary_image,row,col,sign_image,dir)
find = 0;
ending = 0;
%���շ���dir�õ���ΧһȦ�ķ���˳��
path = [0 1; -1 1; -1 0; -1 -1; 0 -1; 1 -1; 1 0; 1 1];
getpath = [];
for i = dir + 1 : 8
    x = path(i,1);
    y = path(i,2);
    if(sign_image(row + x, col + y) ~= 1)
        getpath = cat(1,getpath,[x y]);
    end
end
if dir > 0
    for j = 1 : dir
        x = path(j,1);
        y = path(j,2);
        if(sign_image(row + x, col + y) ~= 1)
            getpath = cat(1,getpath,[x y]);
        end
    end
end 
if size(getpath) == [0,0]
    ending = 1;
end
[len,wid] = size(getpath);
%ȡ��һ�����ʵ��ĵ�Ϊ��һ���㣬���Ҹ��·���
for i = 1 : len
    x = row + getpath(i,1);
    y = col + getpath(i,2);
    if(sign_image(x,y) == 2)
        ending = 1;
        break;
    end
    if(binary_image(x,y) == 1)
        row_tmp = x;
        col_tmp = y;
        dir = mod(dir + i - 1, 8);
        if mod(dir,2) == 0
            dir_tmp = mod(dir + 7, 8);
        else
            dir_tmp = mod(dir + 6, 8);
        end
        find = 1;
        break;
    end
end
if ending == 1
    row_tmp = -1;
    col_tmp = -1;
end
if find == 0
    row_tmp = -1;
    col_tmp = -1;
    dir_tmp = 7;
end
end