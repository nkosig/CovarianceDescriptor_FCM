function [ pvector ] = TensorIntImage( featureimage )
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filename: TensorIntImage.m
%
%  Description: This function calculates the H x W x d tensor matrix from 
%  feature image using equation 8 Region Covariance: A Fast Descriptor for 
%  Detection and Classification
%
%  featureimage - feature image (H x W x d)
%  pvector - H × W × d tensor of the integral images
%
%  Nkosikhona Gumede
%  University of KwaZulu Natal
%  208504751@stu.ukzn.ac.za
%  Nov 2016
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

featureimage = permute(featureimage,[3 2 1]); % shift dimensions for cumsum (d x W x H)

%[d,w,h] = size(featureimage);

%Ptemp = zeros(d,w,h);

pvector = cumsum(cumsum(featureimage,3),2);

%pvector = Ptemp(:,2:end,2:end);

pvector = permute(pvector,[3 2 1]); % Permute back H x W x d

end

