function [diff] = similarity(image1,image2)
%对目标图片和样本图片十字切割成4部分
[image1_p1,image1_p2,image1_p3,image1_p4] = cut_picture(image1);
[image2_p1,image2_p2,image2_p3,image2_p4] = cut_picture(image2);
%计算相对应的4个部分黑色色素所占比例的方差
diff = power(proportion(image1_p1) - proportion(image2_p1),2) + power(proportion(image1_p2) - proportion(image2_p2),2) + power(proportion(image1_p3) - proportion(image2_p3),2) + power(proportion(image1_p4) - proportion(image2_p4),2) + power(proportion(image1) - proportion(image2),2);
end

