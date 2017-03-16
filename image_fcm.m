function [ fcm_image ] = image_fcm( image, fmt )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
image = imread(image,fmt);

if (size(image,3)==3)
    im = im2double(rgb2gray(image));
end

data = reshape(im,[],1);

[c1, U1, Jm1] = fcm(data,2);
[Jm2, U2, c2] = fuzzy_cm(data);

[~,u_index1] = max(U1);
[~,u_index2] = max(U2);

level1 = min(max(data(u_index1==1)),max(data(u_index1==2)))
level2 = min(max(data(u_index2==1)),max(data(u_index2==2)))

fcm_image = im2bw(im,level1);

subplot(1,2,1);
imshow(image);
subplot(1,2,2);
imshow(fcm_image);





