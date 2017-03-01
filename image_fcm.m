function [ output_args ] = image_fcm( image, fmt )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
image = imread(image,fmt);

if (size(image,2)==3)
    image = rgb2gray(image);
end

data = reshape(image,[],1);

[obj_fcn, U, c] = fuzzy_cm(data);

maxU = max(U);
% Find the data points with highest grade of membership in cluster 1
index1 = find(U(1,:) == maxU);
% Find the data points with highest grade of membership in cluster 2
index2 = find(U(2,:) == maxU);



