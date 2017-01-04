function [ featureimage ] = FeatureImage( RGBimage )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filename: FeatureImage.m
%
%  Description: This function calculates the feature image from the RGB image.
%               This function calculates the 9 features for each pixel in the 
%               image as described by equation 13 - Region Covariance: 
%               A Fast Descriptor for Detection and Classification
%
%  F(x,y) = [x y R(x,y) G(x,y) B(x,y) |dI/dx| |dI/dy| |d^2I/dx^2| |d^2I/dy^2|]
%
%  featureimage - Output feature image (W x H x d)
%  RGBimage - 3 dimensional RGB color image (W x H x 3)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Author
%  Nkosikhona Gumede
%  University of KwaZulu Natal
%  208504751@stu.ukzn.ac.za
%  Nov 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    I = rgb2gray(RGBimage);         % Convert to grayscale (intensity) image 
    I = im2double(I);               % Convert intensity image I to double

    [h,w,~] = size(RGB);            % Image dimensions

    featureimage = zeros(h,w,9);               % Feature image template  (H x W x d matrix)

    for i=1:h
        for j=1:w
            featureimage(i,:,1) = i*ones(1,w);         % Pixel x location
            featureimage(:,j,2) = j*ones(h,1);         % Pixel y location
        end
    end

    featureimage(:,:,3:5) = im2double(RGB);            % double RGB pixel values

    xdev1 = [-1 0 1]';      % first derivate w.r.t x calculation kernel (dx)
    ydev1 = xdev1';         % kernel transpose for dy    

    xdev2 = [-1 2 -1]';     % second derivate w.r.t x calculation kernel (dx^2)
    ydev2 = xdev2';         % kernel transpose for dy^2

    featureimage(:,:,6) = abs(conv2(I,xdev1,'same'));    % Absolute of first derivative w.r.t x |dI/dx|
    featureimage(:,:,7) = abs(conv2(I,ydev1,'same'));    % Absolute of first derivative w.r.t y |dI/dy|
    featureimage(:,:,8) = abs(conv2(I,xdev2,'same'));    % Absolute of second derivative w.r.t x |d^2I/dx^2|
    featureimage(:,:,9) = abs(conv2(I,ydev2,'same'));    % Absolute of second derivative w.r.t y |d^2I/dy^2|

    featureimage = permute(featureimage,[2 1 3]); % permute F from H x W x d to W x H x d
end

