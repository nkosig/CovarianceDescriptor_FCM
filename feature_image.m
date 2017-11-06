function [ featureimage ] = feature_image( RGBimage )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filename: feature_image.m
%
%  Description: This function calculates the feature image from the RGB image.
%               This function calculates the 9 features for each pixel in the 
%               image as described by equation 13 - Region Covariance: 
%               A Fast Descriptor for Detection and Classification
%
%  F(x,y) = [x y R(x,y) G(x,y) B(x,y) |dI/dx| |dI/dy| |d^2I/dx^2| |d^2I/dy^2|]
%
%  featureimage - Output feature image (H x W x d)
%  RGBimage - 3 dimensional RGB color image (H x W x 3)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author: Nkosikhona Gumede
%  University of KwaZulu Natal
%  208504751@stu.ukzn.ac.za
%  Aug 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    I = rgb2gray(RGBimage);         % Convert to grayscale (intensity) image 
    I = im2double(I);               % Convert intensity image I to double

    [h,w,~] = size(RGBimage);            % Image dimensions

    featureimage = zeros(h,w,9);         % Feature image template  (H x W x d matrix)

    for y=1:h
        for x=1:w
            featureimage(y,x,1) = x;         % Pixel x location
            featureimage(y,x,2) = y;         % Pixel y location
        end
    end

    featureimage(:,:,3:5) = im2double(RGBimage);       % double RGB pixel values

    xdev1 = [1 0 -1; 2 0 -2; 1 0 -1];      % first derivate w.r.t x calculation kernel (dx)
    ydev1 = xdev1';         % kernel transpose for dy    

    xdev2 = [0 1 0; 1 -4 1; 0 1 0];     % second derivate w.r.t x calculation kernel (dx^2)
    ydev2 = xdev2';         % kernel transpose for dy^2

    featureimage(:,:,6) = abs(conv2(I,xdev1,'same'));    % Absolute of first derivative w.r.t x |dI/dx|
    featureimage(:,:,7) = abs(conv2(I,ydev1,'same'));    % Absolute of first derivative w.r.t y |dI/dy|
    featureimage(:,:,8) = abs(conv2(I,xdev2,'same'));    % Absolute of second derivative w.r.t x |d^2I/dx^2|
    featureimage(:,:,9) = abs(conv2(I,ydev2,'same'));    % Absolute of second derivative w.r.t y |d^2I/dy^2|

    featureimage = permute(featureimage,[2 1 3]); % permute F from H x W x d to W x H x d
end

