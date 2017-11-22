%% FeatureImage
%
%  This feature method is based on the article 
%  "Region Covariance: A Fast Descriptor for Detection and Classification" 
%  by Oncel Tuzel, Fatih Porikli, and Peter Meer.
%
%  I  : rgb input image
%  F(:,x,y)   : Features of original image at position (x,y), i.e. color
%               and gradients
%
%  Paul Swoboda 
%  Universit?t Heidelberg
%  swoboda@math.uni-heidelberg.de
%  June 2014

function F = FeatureImage(I)
% I must be a threedimensional color image

I = double(I);

[n,m,~] = size(I);

F = zeros(9,n,m);
F(1:3,:,:) = permute(I,[3 1 2]);

[FX,FY,FZ] = gradient(F(1:3,:,:));
F(4:6,:,:) = FX;
F(7:9,:,:) = FZ;

F = int64(F);
end