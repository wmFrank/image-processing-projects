function [output] = proportion(image)
num_black = 0;
[row,col] = size(image);
%��������ͼƬ��ͳ�ƺ�ɫ���ص���Ŀ
for i = 1 : row
    for j = 1 : col
        if image(i,j) == 0
            num_black = num_black + 1;
        end
    end
end
%�ú�ɫ���ص���Ŀ�����ܸ������õ�����
output = num_black * 1.0 / (row * col);
end

