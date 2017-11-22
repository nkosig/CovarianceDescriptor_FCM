%% RegionCovarianceDescriptor
%
%  This feature method is based on the article 
%  "Region Covariance: A Fast Descriptor for Detection and Classification" 
%  by Oncel Tuzel, Fatih Porikli, and Peter Meer.
%
%  C(:,:,x,y) : Covariance matrix at position (x+l,y+l). Note that
%               covariance matrix is not computed at the borders of thickness l!
%  F(:,x,y)   : Features of original image at position (x,y)
%  l          : half the side length of square in which the covariance
%               region descriptor is computed, i.e. region is square with
%               side length (2l+1)
% 
%  Paul Swoboda 
%  Universit?t Heidelberg
%  swoboda@math.uni-heidelberg.de
%  June 2014
%

function C = RegionCovarianceDescriptor(F,l)

[d,n,m] = size(F);

P = int64(zeros(d,n+1,m+1));
for i=1:d
    P(i,:,:) = integralImage(squeeze(int64(F(i,:,:))));
end
P = P(:,2:end,2:end);

F2 = int64(zeros(d,d,n,m));
for i=1:d
    for j=1:d
        F2(i,j,:,:) = F(i,:,:).*F(j,:,:);
    end
end
Q = int64(zeros(d,d,n+1,m+1));
for i=1:d
    for j=1:d
        Q(i,j,:,:) = integralImage(squeeze(F2(i,j,:,:)));
    end
end
Q = Q(:,:,2:end,2:end);

Qshift = circshift(Q, [0 0 l l]) + circshift(Q,[0 0 -l -l]) - circshift(Q, [0 0 l -l]) - circshift(Q,[0 0 -l l]);
Pshift = circshift(P, [  0 l l]) + circshift(P,[  0 -l -l]) - circshift(P, [  0 l -l]) - circshift(P,[  0 -l l]);

PshiftRep = repmat(reshape(Pshift,[d 1 n m]),[1 d 1 1]);
PshiftRepTrans = permute(PshiftRep,[2 1 3 4]);
Pmult = PshiftRep.*PshiftRepTrans;

C = 1/((2*l+1)^2 - 1) * (double(Qshift) - 1/((2*l+1)^2) * double(Pmult));

C = C(:,:,l+1:end-l,l+1:end-l);
end