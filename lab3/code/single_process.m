function [img_out] = single_process(img_bw)
%UNTITLED7 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    [row,col] = size(img_bw);
    %Ѱ�����������ĸ��߽������
    for i = 1 : row
        flag = 0;
        for j = 1 : col
            %��������ɨ�裬����ĳһ���к�ɫ�����أ����ҵ��ϱ߽�
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
    %�ҵ������������еı߽��ֱ���и��������
    img_out = imcrop(img_bw,[left top (right - left) (down - top)]);
end

