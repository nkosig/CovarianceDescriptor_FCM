function [ qmatrix ] = tensor_2ord_int_im( featureimage )
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filename: tensor_2ord_int_im.m
%
%  Description: This function calculates the H x W x d x d tensor matrix of 
%  second order integral image feature image using equation 9
%  Region Covariance: A Fast Descriptor for Detection and Classification
%
%  featureimage - feature image (W x H x d) 
%  qmatrix - W x H x d x d tensor of the second order integral images
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Nkosikhona Gumede
%  University of KwaZulu Natal
%  208504751@stu.ukzn.ac.za
%  Aug 2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

featureimage = permute(featureimage,[3 1 2]); % shift dimensions for cumsum (d x W x H)

[d,w,h] = size(featureimage);

% For each feature calculate the second order feature image as per equation 9
F2 = zeros(d,d,w,h);
for i=1:d
    for j=1:d
        F2(i,j,:,:) = featureimage(i,:,:).*featureimage(j,:,:);
    end
end

% For each feature calculate the tensor matrix of the 2nd Order int image
%Qtemp = zeros(d,d,w+1,h+1);

qmatrix = cumsum(cumsum(F2,4),3);

%qmatrix = Qtemp(:,:,2:end,2:end);  % Q - 9 x 9 matrix for each feature

qmatrix = permute(qmatrix,[3 4 1 2]); % Permute back W x H x d x d

end

