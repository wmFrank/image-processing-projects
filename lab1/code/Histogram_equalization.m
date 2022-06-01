function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    
    %several methods to process RGB-images(need choose)
    %output = method1(input_image);
    %output = method2(input_image);
    output = method3(input_image);
    %output = method4(input_image);
    %output = method5(input_image);
    %output = method6(input_image);
    
else
    %this is a gray image
    [output] = hist_equal(input_image);
end
    function [output] = method1(input_image)
    %apply hist_equal to R/G/B separately
    r=input_image(:,:,1);
    v=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = hist_equal(r);
    v1 = hist_equal(v);
    b1 = hist_equal(b);
    output = cat(3,r1,v1,b1);
    end

    function [output] = method2(input_image)
    %convert RGB to HSV, apply hist_equal to V-dimension
    tmp = rgb2hsv(input_image);    
    h = tmp(:,:,1);
    s = tmp(:,:,2);
    v = tmp(:,:,3);
    h1 = h;
    s1 = s;
    v1 = hist_equal(round(v * 255))/255;
    output = hsv2rgb(cat(3,h1,s1,v1));
    end

    function [output] = method3(input_image)
    %convert RGB to HSI, apply hist_equal to I-dimension
    tmp = rgb2hsi(input_image);
    h = tmp(:, :, 1); 
    s = tmp(:, :, 2); 
    i = tmp(:, :, 3);
    h1 = h;
    s1 = s;
    i1 = hist_equal(round(i * 255))/255;
    output = hsi2rgb(cat(3,h1,s1,i1));
    end

    function [output] = method4(input_image)
    %convert RGB to YUV, apply hist_equal to Y-dimension
    tmp = rgb2yuv(input_image);
    y = tmp(:, :, 1); 
    u = tmp(:, :, 2); 
    v = tmp(:, :, 3);
    y1 = hist_equal(round(y * 255))/255;
    u1 = u;
    v1 = v;
    output = yuv2rgb(cat(3,y1,u1,v1));
    end

    function [output] = method5(input_image)
    %convert RGB to YIQ, apply hist_equal to Y-dimension
    tmp = rgb2ntsc(input_image);
    y = tmp(:, :, 1); 
    i = tmp(:, :, 2); 
    q = tmp(:, :, 3);
    y1 = hist_equal(round(y * 255))/255;
    i1 = i;
    q1 = q;
    output = ntsc2rgb(cat(3,y1,i1,q1));
    end

    function [output] = method6(input_image)
    %convert RGB to YCbCr, apply hist_equal to Y-dimension
    tmp = rgb2ycbcr(input_image);
    y = tmp(:, :, 1); 
    cb = tmp(:, :, 2); 
    cr = tmp(:, :, 3);
    y1 = hist_equal(round(y * 255))/255;
    cb1 = cb;
    cr1 = cr;
    output = ycbcr2rgb(cat(3,y1,cb1,cr1));
    end

    function [hsi] = rgb2hsi(rgb)
    %convert RGB to HSI
    rgb = im2double(rgb); 
    r = rgb(:, :, 1); 
    g = rgb(:, :, 2); 
    b = rgb(:, :, 3); 
    num = 0.5*((r - g) + (r - b)); 
    den = sqrt((r - g).^2 + (r - b).*(g - b)); 
    theta = acos(num./(den + eps)); 
    H = theta; 
    H(b > g) = 2*pi - H(b > g); 
    H = H/(2*pi); 
    num = min(min(r, g), b); 
    den = r + g + b; 
    den(den == 0) = eps; 
    S = 1 - 3.* num./den; 
    H(S == 0) = 0; 
    I = (r + g + b)/3; 
    hsi = cat(3, H, S, I); 
    end

    function [rgb] = hsi2rgb(hsi) 
    %convert HSI to RGB
    H = hsi(:, :, 1) * 2 * pi; 
    S = hsi(:, :, 2); 
    I = hsi(:, :, 3); 
    R = zeros(size(hsi, 1), size(hsi, 2)); 
    G = zeros(size(hsi, 1), size(hsi, 2)); 
    B = zeros(size(hsi, 1), size(hsi, 2)); 
    idx = find( (0 <= H) & (H < 2*pi/3)); 
    B(idx) = I(idx) .* (1 - S(idx)); 
    R(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx)) ./ cos(pi/3 - H(idx))); 
    G(idx) = 3*I(idx) - (R(idx) + B(idx)); 
    idx = find( (2*pi/3 <= H) & (H < 4*pi/3) ); 
    R(idx) = I(idx) .* (1 - S(idx)); 
    G(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 2*pi/3) ./ cos(pi - H(idx))); 
    B(idx) = 3*I(idx) - (R(idx) + G(idx));  
    idx = find( (4*pi/3 <= H) & (H <= 2*pi)); 
    G(idx) = I(idx) .* (1 - S(idx)); 
    B(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 4*pi/3) ./cos(5*pi/3 - H(idx))); 
    R(idx) = 3*I(idx) - (G(idx) + B(idx)); 
    rgb = cat(3, R, G, B); 
    rgb = max(min(rgb, 1), 0);
    end

    function [yuv] = rgb2yuv(rgb)
    %convert RGB to YUV
    rgb = im2double(rgb); 
    r = rgb(:, :, 1); 
    g = rgb(:, :, 2); 
    b = rgb(:, :, 3); 
    y = 0.299 * r + 0.587 * g + 0.114 * b;
    u = -0.147 * r - 0.289 * g + 0.436 * b;
    v = 0.615 * r - 0.515 * g - 0.100 * b;
    yuv = cat(3, y, u, v); 
    end
    
    function [rgb] = yuv2rgb(yuv) 
    %convert YUV to RGB
    y = yuv(:, :, 1); 
    u = yuv(:, :, 2); 
    v = yuv(:, :, 3); 
    r = y + 1.14 * v;
    g = y - 0.39 * u - 0.58 * v;
    b = y + 2.03 * u;
    rgb = cat(3, r, g, b); 
    end

    function [ycbcr] = rgb2ycbcr(rgb)
    %convert RGB to YCBCR
    rgb = im2double(rgb); 
    r = rgb(:, :, 1); 
    g = rgb(:, :, 2); 
    b = rgb(:, :, 3); 
    y = 0.299 * r + 0.587 * g + 0.114 * b;
    cb = -0.1687 * r - 0.3313 * g + 0.5 * b + 128;
    cr = 0.5 * r - 0.4187 * g - 0.0813 * b + 128;
    ycbcr = cat(3, y, cb, cr); 
    end
    
    function [rgb] = ycbcr2rgb(ycbcr) 
    %convert YCBCR to RGB
    y = ycbcr(:, :, 1); 
    cb = ycbcr(:, :, 2); 
    cr = ycbcr(:, :, 3); 
    r = y + 1.402 * (cr - 128);
    g = y + 0.34414 * (cb - 128) - 0.71414 * (cr - 128);
    b = y + 1.772 * (cb - 128);
    rgb = cat(3, r, g, b); 
    end

    function [output2] = hist_equal(input_channel)
    %concretely realize hist_qual
    %get basic information of input
    [r,c] = size(input_channel);
    total_pixel = r * c;
    total_graylevel = 256;
    %count dots for each graylevel
    hist_a = zeros(1,total_graylevel);
    for i = 1:r
        for j = 1:c
            hist_a(1,input_channel(i,j)+1) = hist_a(1,input_channel(i,j)+1) + 1;
        end
    end
    hist_a = hist_a / total_pixel;
    %get the graylevel conversion function
    out_b = zeros(1,total_graylevel);
    for len = 1:total_graylevel
        sum = 0;
        for tmp = 1:len
            sum = sum + hist_a(1,tmp);
        end
        out_b(1,len) = round(sum * (total_graylevel - 1));
    end
    %apply graylevel conversion function to tranform original input
    for i = 1:r
        for j = 1:c
            input_channel(i,j) = out_b(1,input_channel(i,j)+1);
        end
    end
    output2 = input_channel;
    end

end

