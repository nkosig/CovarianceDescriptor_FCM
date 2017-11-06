function [ pvector ] = tensor_int_im( featureimage )
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%W%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filename: TensorIntImage.m
%
%  Description: This function calculates the W x H x d tensor matrix from 
%  feature image using equation 8 Region Covariance: A Fast Descriptor for 
%  Detection and Classification
%
%  featureimage - feature image (W x H x d)
%  pvector - W x H x d tensor of the integral images
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Nkosikhona Gumede
%  University of KwaZulu Natal
%  208504751@stu.ukzn.ac.za
%  Aug 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

featureimage = permute(featureimage,[3 1 2]); % shift dimensions for cumsum (d x W x H)

%[d,w,h] = size(featureimage);

%Ptemp = zeros(d,w,h);

pvector = cumsum(cumsum(featureimage,3),2);

%pvector = Ptemp(:,2:end,2:end);

pvector = permute(pvector,[2 3 1]); % Permute back W x H x d

end

