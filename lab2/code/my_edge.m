%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores  

function [output_matlab,output_sobel,output_robert,output_priwitt,output_log,output_canny] = my_edge(input_image)
[row,col] = size(input_image);

%matlab standard function
output_matlab = edge(input_image);

%高斯降噪
gaussfilter = fspecial('gaussian');
input_image = imfilter(input_image, gaussfilter, 'replicate');
%input_image = gaussian_blur(input_image);

%sobel
output_sobel = zeros(row, col);
%设置阈值
sobel_threshold = 0.8;
%遍历图像的每个像素，用Sobel算子计算梯度
for r = 2 : row - 1
    for c = 2 : col - 1
        sobel_x = - 1 * input_image(r - 1, c - 1) + 1 * input_image(r - 1, c + 1) - 2 * input_image(r, c - 1) + 2 * input_image(r, c + 1) - 1 * input_image(r + 1, c - 1) + 1 * input_image(r + 1, c + 1);
        sobel_y = 1 * input_image(r - 1, c - 1) + 2 * input_image(r - 1, c) + 1 * input_image(r - 1, c + 1) - 1 * input_image(r + 1, c - 1) - 2 * input_image(r + 1, c) - 1 * input_image(r + 1, c + 1);
        sobel_num = sqrt(sobel_x^2 + sobel_y^2);
        %将梯度与阈值进行比较，决定该点是0还是1
        if(sobel_num < sobel_threshold)
            output_sobel(r,c) = 0;
        else
            output_sobel(r,c) = 1;
        end
    end
end

%robert
%设置阈值
output_robert = zeros(row, col);
%遍历图像的每个像素，用Robert算子计算梯度
robert_threshold = 0.15;
for r = 1 : row - 1
    for c = 1 : col - 1
        robert_x = 1 * input_image(r, c) - 1 * input_image(r + 1, c + 1);
        robert_y = 1 * input_image(r, c + 1) - 1 * input_image(r + 1, c);
        robert_num = sqrt(robert_x^2 + robert_y^2);
        %将梯度与阈值进行比较，决定该点是0还是1
        if(robert_num < robert_threshold)
            output_robert(r,c) = 0;
        else
            output_robert(r,c) = 1;
        end
    end
end

%priwitt
%设置阈值
output_priwitt = zeros(row, col);
%遍历图像的每个像素，用Priwitt算子计算梯度
priwitt_threshold = 0.55;
for r = 2 : row - 1
    for c = 2 : col - 1
        priwitt_x = - 1 * input_image(r - 1, c - 1) + 1 * input_image(r - 1, c + 1) - 1 * input_image(r, c - 1) + 1 * input_image(r, c + 1) - 1 * input_image(r + 1, c - 1) + 1 * input_image(r + 1, c + 1);
        priwitt_y = - 1 * input_image(r - 1, c - 1) - 1 * input_image(r - 1, c) - 1 * input_image(r - 1, c + 1) + 1 * input_image(r + 1, c - 1) + 1 * input_image(r + 1, c) + 1 * input_image(r + 1, c + 1);
        priwitt_num = sqrt(priwitt_x^2 + priwitt_y^2);
        %将梯度与阈值进行比较，决定该点是0还是1
        if(priwitt_num < priwitt_threshold)
            output_priwitt(r,c) = 0;
        else
            output_priwitt(r,c) = 1;
        end
    end
end

%log
output_log = zeros(row, col);
%设置阈值
log_threshold = 9;
%生成9*9的LoG算子
log_operator = [0 1 1 2 2 2 1 1 0;
                1 2 4 5 5 5 4 2 1;
                1 4 5 3 0 3 5 4 1;
                2 5 3 -12 -24 -12 3 5 2;
                2 5 0 -24 -40 -24 0 5 2;
                2 5 3 -12 -24 -12 3 5 2;
                1 4 5 3 0 3 5 4 1;
                1 2 4 5 5 5 4 2 1;
                0 1 1 2 2 2 1 1 0];
%遍历图像用LoG算子求卷积，并根据阈值判定边缘
get_model = conv2(input_image, log_operator, 'same');
for r = 1 : row
    for c = 1 : col
        if(get_model(r, c) < log_threshold)
            output_log(r,c) = 0;
        else
            output_log(r,c) = 1;
        end
    end
end

%canny
output_canny = zeros(row, col);
refined_image = input_image;
%refined_image = imfilter(input_image, gaussfilter, 'replicate');
%用Sobel算子计算梯度
sobel_tmpx = refined_image;
sobel_tmpy = refined_image;
sobel_tmpnum = zeros(row, col);
for r = 2 : row - 1
    for c = 2 : col - 1
        sobel_tmpx(r, c) = - 1 * refined_image(r - 1, c - 1) + 1 * refined_image(r - 1, c + 1) - 2 * refined_image(r, c - 1) + 2 * refined_image(r, c + 1) - 1 * refined_image(r + 1, c - 1) + 1 * refined_image(r + 1, c + 1);
        sobel_tmpy(r, c) = 1 * refined_image(r - 1, c - 1) + 2 * refined_image(r - 1, c) + 1 * refined_image(r - 1, c + 1) - 1 * refined_image(r + 1, c - 1) - 2 * refined_image(r + 1, c) - 1 * refined_image(r + 1, c + 1);
        sobel_tmpnum(r, c) = sqrt(sobel_tmpx(r, c)^2 + sobel_tmpy(r, c)^2);
    end
end
%利用梯度和方向进行非极大值抑制，去掉非极大值的不是边缘的点
for r = 2 : row - 1
    for c = 2 : col - 1
        sobel_x = sobel_tmpx(r, c);
        sobel_y = sobel_tmpy(r, c);
        %计算方向
        if (sobel_y ~= 0)
            angle = atan(sobel_y / sobel_x);
        elseif (sobel_y == 0 && sobel_x > 0)
            angle = pi / 2;
        else
            angle = - pi / 2;
        end
        %根据方向得到邻居的坐标
        if ((mod(angle,pi * 2) >= 15 * pi / 8 && mod(angle,pi * 2) <= 2 * pi) || (mod(angle,pi * 2) >= 0 && mod(angle,pi * 2) < pi / 8) || (mod(angle,pi * 2) >= 7 * pi / 8 && mod(angle,pi * 2) < 9 * pi / 8))
            r1 = r; c1 = c - 1; r2 = r; c2 = c + 1;
        elseif ((mod(angle,pi * 2) >= pi / 8 && mod(angle,pi * 2) < 3 * pi / 8) || (mod(angle,pi * 2) >= 9 * pi / 8 && mod(angle,pi * 2) < 11 * pi / 8))
            r1 = r - 1; c1 = c + 1; r2 = r + 1; c2 = c - 1;
        elseif ((mod(angle,pi * 2) >= 3 * pi / 8 && mod(angle,pi * 2) < 5 * pi / 8) || (mod(angle,pi * 2) >= 11 * pi / 8 && mod(angle,pi * 2) < 13 * pi / 8))
            r1 = r - 1; c1 = c; r2 = r + 1; c2 = c;
        else
            r1 = r - 1; c1 = c - 1; r2 = r + 1; c2 = c + 1;
        end
        %比较其与邻居的梯度，若不是极大值则抑制
        if (sobel_tmpnum(r, c) > sobel_tmpnum(r1, c1) && sobel_tmpnum(r, c) > sobel_tmpnum(r2, c2))
            output_canny(r, c) = refined_image(r, c);
        else
            output_canny(r, c) = 0;
        end
    end 
end
%设定高低两个阈值，进行双阈值检测
tmpimage = output_canny;
sortls = sort(tmpimage(:));
number = ceil(0.995 * row * col);
canny_upthreshold = sortls(number);
canny_downthreshold = 1.0 * canny_upthreshold;
%canny_upthreshold = 0.77;
%canny_downthreshold = 0.4 * canny_upthreshold;
for r = 1 : row
    for c = 1 : col
        if(output_canny(r,c) ~= 0)
            %根据阈值情况判定是边缘、不是边缘、待定边缘
            if(sobel_tmpnum(r,c) > canny_upthreshold)
                output_canny(r,c) = 1;
            elseif(sobel_tmpnum(r,c) < canny_downthreshold)
                output_canny(r,c) = 0;
            end
        end
    end
end
%滞后边界跟踪，对待定的点进行判定
tmp_image = output_canny;
near = [-1 -1; -1 0; -1 1; 0 -1; 0 1; 1 -1; 1 0; 1 1];
for r = 1 : row
    for c = 1: col
        if(tmp_image(r,c) ~= 0 && tmp_image(r,c) ~= 1)
            %8邻域内有边缘点则认定该点也为边缘
            for pos = 1 : 8
                x1 = r + near(pos, 1);
                y1 = c + near(pos, 2);
                if(tmp_image(x1,y1) == 1)
                    output_canny(r, c) = 1;
                    break;
                end
            end
        end
    end
end
for r = 1 : row
    for c = 1: col
        if(output_canny(r,c) ~= 1)
            output_canny(r,c) = 0;
        end
    end
end
end

%高斯平滑处理
function [output_image] = gaussian_blur(input_image)
[row,col] = size(input_image);
guassian_operator = [1 4 7 4 1;
                     4 16 26 16 4;
                     7 26 41 26 7;
                     4 16 26 16 4;
                     1 4 7 4 1];
%用高斯算子进行卷积
output_image = conv2(input_image, guassian_operator, 'same') / 273;
for r = 1 : row
    for c = 1 : col
        if(output_image > 1)
            output_image = 1;
        end
    end
end
end
