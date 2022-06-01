function [output] = my_calculator(input_image)
%in this function, you should finish the character recognition task.
%the input parameter is a matrix of an image which contains several expressions
%the output parameter is a matrix of an image which contains the results of expressions 
getsamples();
input_image = im2bw(input_image);
output = getblock(input_image);
end

