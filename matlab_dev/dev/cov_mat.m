function [ covmatrix ] = cov_mat( P,Q,xp,yp,xpp,ypp )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filename: RCovariance.m
%
%  Description: This function calculates the covariance matrix as per equation 12
%  from the first and second order tensors equation 10
%  Region Covariance: A Fast Descriptor for Detection and Classification
%
%
%
%
%
%
%  Nkosikhona Gumede
%  University of KwaZulu Natal
%  208504751@stu.ukzn.ac.za
%  Aug 2015
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rp = squeeze(P(xpp,ypp,:) + P(xp,yp,:) - P(xpp,yp,:) - P(xp,ypp,:));   % Second term
Rq = squeeze(Q(xpp,ypp,:,:) + Q(xp,yp,:,:) - Q(xpp,yp,:,:) - Q(xp,ypp,:,:)); % First term

n = (xpp - xp)*(ypp - yp);

covmatrix = 1/(n - 1) * (Rq - (1/n) * (Rp*Rp')); %Covariance matrix - equation 12 (d x d)

end

