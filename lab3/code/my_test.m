%DIP19 Assignment 3
%Character Recongnition

clc; clear all;
imgName = 'example.png';
name = strsplit(imgName,'.');
imgInput = imread(strcat('test/',imgName));
imgOutput = my_calculator(imgInput);
imwrite(imgOutput,strcat('result/',char(name(1)),'_result.png'));

subplot(1, 2, 1);
imshow(imgInput);
subplot(1, 2, 2);
imshow(imgOutput);



