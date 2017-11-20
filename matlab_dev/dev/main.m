disp('Covariance Descriptor and Fuzzy C-Means');

addpath('../..');

image = 'images/icon_image.png';
% image = input('Enter image URL: ','s');
% while(exist(image,'file') ~= 2)
%     image = input('Invalid image URL, remember to include directory: ','s');
% end 

RGBimage = imread(image);
[h, w, ~] = size(RGBimage);

% Reference Image Computing

FeatureImageR = feature_image(RGBimage);    % W x H x d feature image

Pr = tensor_int_im(FeatureImageR);    % W x H x d
Qr = tensor_2ord_int_im(FeatureImageR);   % W x H x d x d   

Cr = cov_mat(Pr, Qr,1,1,w,h);

% Covariance matrix validity checking

[R, p] = chol(Cr);

if (p ~= 0 || not(issymmetric(Cr))) 
    disp('Reference matrix is not positive definite symmetric'); 
end

% Distance check

dist = cov_dist(Cr,Cr);


    