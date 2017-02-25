function [  ] = plot_fcm( data )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[c1,u1,jm1] = fcm(data,2,[2,100,1e-5,0]);
subplot(1,2,1);
plot_data(data,u1,c1);
title('MATLAB fcm function');

[jm2,u2,c2] = fuzzy_cm(data);
subplot(1,2,2);
plot_data(data,u2,c2);
title('Custom fcm function');


function plot_data (data, U, center)
      plot(data(:,1), data(:,2),'o');
      hold on;
      maxU = max(U);
      % Find the data points with highest grade of membership in cluster 1
      index1 = find(U(1,:) == maxU);
      % Find the data points with highest grade of membership in cluster 2
      index2 = find(U(2,:) == maxU);
      line(data(index1,1),data(index1,2),'marker','*','color','g');
      line(data(index2,1),data(index2,2),'marker','*','color','r');
      % Plot the cluster centers
      plot(center([1 2],1),center([1 2],2),'*','color','k')
      hold off;
      
      

