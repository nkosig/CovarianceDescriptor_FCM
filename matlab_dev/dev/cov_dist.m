%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Filename: CovarianceDistance.m
%
%  Description: This function calculates the distance between feature points which
%  gives a measure of the dissimilarity of two covariance matrices - Equation 3
%  Region Covariance: A Fast Descriptor for Detection and Classification
%
%  Nkosikhona Gumede
%  University of KwaZulu Natal
%  208504751@stu.ukzn.ac.za
%  Aug 2015
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function d = cov_dist(C1,C2) 


global C
d = 0;
[~,n] = size(C1);

eps = 1e-6; 
I = eye(n);

try
  [~,D] = eig(C1 + I*eps,C2 + I*eps); %Calculating the generalised eigenvalues
catch
  C = C2;
  disp(C2);
  [~,D] = eigs(C1,C2); %Calculating the generalised eigenvalues
end

if(min(diag(D)) < -eps)
    disp('error occurred in generalized eigenvalue computation');
    return; 
end

d = sqrt(sum(log(diag(abs(D))).^2)); %Distance calculation

end