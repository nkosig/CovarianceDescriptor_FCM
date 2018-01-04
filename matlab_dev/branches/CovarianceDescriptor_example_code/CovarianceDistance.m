%% CovarianceDistance
%
%  This feature method is based on the article 
%  "Region Covariance: A Fast Descriptor for Detection and Classification" 
%  by Oncel Tuzel, Fatih Porikli, and Peter Meer.
%
%  C1,C2 : Covariance matrices 
%  d     : distance between C1 and C2 as computed in the above article
% 
%  Paul Swoboda 
%  Universit?t Heidelberg
%  swoboda@math.uni-heidelberg.de
%  June 2014
%

function d = CovarianceDistance(C1,C2)

eps = 1e-6; % for numerical stabilty

[~,D] = eig(C1 + eps,C2 + eps);

if(min(diag(D)) < -eps)
    disp('error occurred in generalized eigenvalue computation');
    return; 
end

d = sum(log(diag(abs(D))).^2);
end