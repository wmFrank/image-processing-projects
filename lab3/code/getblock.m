function [out] = getblock(in)
out = in;
[x,y] = size(in);
%����һ����־λ
flag = 0;
%����һ��һά��������¼�и�������
y_points = [];
%����ÿһ�У���ÿһ�еĺڰ����ؽ��м���
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
    %��ɫ���ض���70%�������϶��Ǹոմ�������ɫ�߽�
    if flag == 0 && count_black >= 0.7 * x
        flag = 1;
        y_points = cat(1,y_points,j - 1);
    %��ɫ���ض���50%�������϶��Ǹո�Խ���˺�ɫ�߽�
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
        %�����־λ�Լ��洢�и��ľ���
        col_points = [];
        flag = 0;
        %�����ҽ���ɨ�裬����ÿһ�еĺ�ɫ���صĸ���
        for m = 1 : col
            count_black = 0;
            for n = 1 : row
                 if block(n,m) == 0
                     count_black = count_black + 1;
                 end
            end
            %������ɫ���أ�������һ�����ֻ��������
            if flag == 0 && count_black > 0
                flag = 1;
                col_points = cat(1,col_points,m - 1);
            %�������ף���ôһ���Ǹո�Խ��һ�����ֻ��������    
            elseif flag == 1 && count_black == 0
                col_points = cat(1,col_points,m);
                flag = 0;
            end
        end
        [x3,y3] = size(col_points);
        digit = [];
        operator = [];
        a = 0;
        %�õ���Ƭ֮�󣬰��ա�����+�����+����+���ںš��ĸ�ʽ����ʶ��
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
        %�ж��������ʲô��������Ӧ�ļ���õ����
        if operator(1,1) == -1
            result = digit(1,1) + digit(2,1);
        elseif operator(1,1) == -2
            result = digit(1,1) - digit(2,1);
        end
        %���ݵõ��Ľ����ȡ��Ӧ������ͼƬ
        img_num = imread(strcat('digit_sample/',num2str(result),'.png'));
        [x4,y4] = size(img_num);
        %�õ����Ͻǵ���Ӧ����
        left_top = [x_points(i,1) + round((row - x4) / 2) - 6 y_points(j,1) + col_points(x3,1) + round((col - col_points(x3,1) - y4) / 2)];
        %����˫���ѭ��������ͼƬ������ֵ��ֵ��ԭ����ʽ����
        for ii = 1 : x4
            for jj = 1 : y4
                out(left_top(1,1) + ii,left_top(1,2) + jj) = img_num(ii,jj);
            end
        end
    end
end
end

