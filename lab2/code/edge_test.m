%DIP16 Assignment 2
%Edge Detection
%In this assignment, you should build your own edge detection and edge linking 
%function to detect the edges of a image.
%Please Note you cannot use the build-in matlab edge and bwtraceboundary function
%We supply four test images, and you can use others to show your results for edge
%detection, but you just need do edge linking for rubberband_cap.png.


clc; clear all;

% Load the test image

imgTest = im2double(imread('rubberband_cap.png'));
imgTestGray = rgb2gray(imgTest);
%disp(size(imgTestGray)); 
%disp(imgTestGray(1:2,1:20));
%figure; clf;
%imshow(imgTestGray);

%now call your function my_edge, you can use matlab edge function to see
%the last result as a reference first

%img_edge = edge(imgTestGray);
[output_matlab,output_sobel,output_robert,output_priwitt,output_log,output_canny] = my_edge(imgTestGray);
figure;clf;
subplot(3,3,1);
imshow(output_matlab);
title("Matlab edge");
subplot(3,3,2);
imshow(output_sobel);
title("Sobel");
subplot(3,3,3);
imshow(output_robert);
title("Robert");
subplot(3,3,4);
imshow(output_priwitt);
title("Priwitt");
subplot(3,3,5);
imshow(output_log);
title("Log");
subplot(3,3,6);
imshow(output_canny);
title("Canny");

% imwrite(output_matlab,'rubberband_cap_matlab.png');
% imwrite(output_sobel,'rubberband_cap_sobel.png');
% imwrite(output_robert,'rubberband_cap_robert.png');
% imwrite(output_priwitt,'rubberband_cap_priwitt.png');
% imwrite(output_log,'rubberband_cap_log.png');
% imwrite(output_canny,'rubberband_cap_canny.png');

figure;clf;
imshow(output_canny);
title("Canny±ﬂ‘µºÏ≤‚Õº")

background = im2bw(imgTest, 1);
figure;clf;
imshow(background);
title("Canny±ﬂ‘µ¡¥Ω”Õº")

%using imtool, you select a object boundary to trace, and choose
%an appropriate edge point as the start point 

imtool(output_canny);

%now call your function my_edgelinking, you can use matlab bwtraceboundary 
%function to see the last result as a reference first. please trace as many 
%different object boundaries as you can, and choose different start edge points.

% Bxpc = bwtraceboundary(output_sobel, [171,153], 'N');
% Bxpc0 = my_edgelinking(output_matlab, 130, 177);
% Bxpc1 = my_edgelinking(output_matlab, 100, 146);
% Bxpc2 = my_edgelinking(output_matlab, 62, 252);
% Bxpc3 = my_edgelinking(output_matlab, 222, 65);
% Bxpc4 = my_edgelinking(output_matlab, 306, 212);
Bxpc0 = my_edgelinking(output_canny, 131, 170);
Bxpc1 = my_edgelinking(output_canny, 199, 89);
Bxpc2 = my_edgelinking(output_canny, 93, 302);
Bxpc3 = my_edgelinking(output_canny, 149, 74);
Bxpc4 = my_edgelinking(output_canny, 306, 212);
%disp(Bxpc3);
hold on
plot(Bxpc0(:,2), Bxpc0(:,1), 'white', 'LineWidth', 1);
plot(Bxpc1(:,2), Bxpc1(:,1), 'white', 'LineWidth', 1);
plot(Bxpc2(:,2), Bxpc2(:,1), 'white', 'LineWidth', 1);
plot(Bxpc3(:,2), Bxpc3(:,1), 'white', 'LineWidth', 1);
plot(Bxpc4(:,2), Bxpc4(:,1), 'white', 'LineWidth', 1);
