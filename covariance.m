function [ covmatrix ] = Covariance( P,Q,xp,yp,xpp,ypp )
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

Rp = squeeze(P(ypp,xpp,:) + P(yp,xp,:) - P(ypp,xp,:) - P(yp,xpp,:));   % Second term
Rq = squeeze(Q(ypp,xpp,:,:) + Q(yp,xp,:,:) - Q(ypp,xp,:,:) - Q(yp,xpp,:,:)); % First term

n = (ypp - yp)*(xpp - xp);

covmatrix = 1/(n - 1) * (Rq - (1/n) * (Rp*Rp')); %Covariance matrix - equation 12 (d x d)

end

