function [] = getsamples()
file_inpath = 'raw_sample/';
file_outpath1 = 'digit_sample/';
file_outpath2 = 'operator_sample/';
img_path_list = dir(strcat(file_inpath,'*.png'));
img_num = length(img_path_list);
for k = 1 : img_num
    img_name = img_path_list(k).name;
    img_bw = im2bw(imread(strcat(file_inpath,img_name)));
    img_out = single_process(img_bw);
    name = strsplit(img_name,'.');
    name = name(1);
    if strcmp(name,'+') || strcmp(name,'-') || strcmp(name,'=')
        imwrite(img_out,strcat(file_outpath2,img_name));
    else
        imwrite(img_out,strcat(file_outpath1,img_name));
    end
end
end

