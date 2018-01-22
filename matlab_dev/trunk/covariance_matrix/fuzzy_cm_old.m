function [ output_args ] = fuzzy_cm( input_args )


% This program illustrates the Fuzzy c-means segmentation of an image. 
% This program converts an input image into two segments using Fuzzy k-means
% algorithm. The output is stored as "fuzzysegmented.jpg" in the current directory.
% This program can be generalised to get "n" segments from  an image
% by means of slightly modifying the given code.

clear all;

in=input('enter an image to segment\n','s');
image=imread(in);

% The code expects grayscale images so it breaks when RGB images are used.
% Update to check what type of image it is before converting
image=rgb2gray(image);      

image=double(image);
figure(1)
imshow(uint8(image))

[h,w]=size(image);                 % Image dimensions

% NG: Concatenates the 2 duplicate image matrices along the z-axis
IMM=cat(3,image,image);               
    
%%%%%%%%%%%%%%%%

% initial assumed cluster centres.
v1_t0=8;          % cluster center 1 (cc1) = 8p
v2_t0=250;        % cc2 = 250p

ttFcm=0;

while(ttFcm < 50) 
    
    ttFcm = ttFcm+1;        % increment ttFcm
    
    c1=repmat(v1_t0,h,w);     % create h x w matrix of cc1 (8)
    c2=repmat(v2_t0,h,w);     % create h x w matrix of cc2 (250)
    
    %% NG: unused piece of code
    if ttFcm==1 
        test1=c1; test2=c2;
    end
    %%
    
    c=cat(3,c1,c2);         % Concatenates the 2 matrices of 8 and 250 along z-axis
    
    ree=repmat(0.000001,h,w);   % create h x w matrix of (0,000001)
    
    ree1=cat(3,ree,ree);    % generate duplicate and concatenate them along z-axis
    
    %% Important part
    distance=IMM-c;         % subtrate concatenated image matrix from cluster centre ones.
    distance=distance.*distance+ree1;
    
    daoShu=1./distance;
    
    daoShu2=daoShu(:,:,1)+daoShu(:,:,2);
    distance1=distance(:,:,1).*daoShu2;
    u1=1./distance1;
    distance2=distance(:,:,2).*daoShu2;
    u2=1./distance2;
      
    v1_t1=sum(sum(u1.*u1.*image))/sum(sum(u1.*u1));
    v2_t1=sum(sum(u2.*u2.*image))/sum(sum(u2.*u2));
   
    tmpMatrix=[abs(v1_t0-v1_t1)/v1_t0, abs(v2_t0-v2_t1)/v2_t0];
    pp=cat(3,u1,u2);
    
    %% NG: Assigning each pixel to a cluster   
    for i=1:h
        for j=1:w
            if max(pp(i,j,:))==u1(i,j)
                cluster_matrix(i,j)=1;         % cluster 1
           
            else
                cluster_matrix(i,j)=2;         % cluster 2
            end
        end
    end
    
    %% NG: Maximum allowed error check
    if max(tmpMatrix)<0.0001
         break;
    else        % else update cluster centers
             v1_t0=v1_t1;
             v2_t0=v2_t1;
    end
    
    %% Update temp image pixel depending on which cluster it belongs to.
    for i=1:h
       for j=1:w
            if cluster_matrix(i,j)==2
            temp_image(i,j)=254;
            else
            temp_image(i,j)=8;
            end
       end
    end
    
    %% NG: Display final completed image
    figure(2);
 
    imshow(uint8(temp_image));
    
    imwrite(uint8(temp_image),'fuzzysegmented.jpg');
end


%% NG: Update image pixel for last time, 
% Assign 200p to cluster 2 pixels and 1p to cluster 1 pixels.
% IMMM is now the final image
for i=1:h
    for j=1:w
         if cluster_matrix(i,j)==2
            temp_image(i,j)=200;
         else
            temp_image(i,j)=1;
         end
    end
end 

%% NG: Saves same purpose as figure 2 display code above
temp_image=uint8(temp_image);
figure(3);
imshow(temp_image);

%%

disp('The final cluster centers are');
v1_t1
v2_t1

end

