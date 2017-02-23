function [Jm, U, V] = fuzzy_cm( data )


% initialize all variables
[n_data,p] = size(data);  % p - dimension, n_data - number of data points

m = 2;              % weighting exponent
max_iter = 100;     % maximum iterations
e = 1e-5;           % termination tolerance

n_clusters = 2;     % number of clusters

%initialize all functions

Jm = zeros(max_iter, 1);

U = rand(n_clusters, n_data);
U(2,:) = 1 - U(1,:);

for t = 1:max_iter
    Uexp = U.^m;
    den = repmat(sum(Uexp,2),1,p);
    num = Uexp*data;
    V = num./den;
    dist = zeros(n_clusters,n_data);
    
    for i = 1:n_clusters
        dist(i,:) = sqrt(sum(((data - ones(n_data,1)*V(i,:)).^2),2));
    end
    
    Jm(t) = sum(sum(Uexp.*(dist.^2)));
    
    U_new = zeros(n_clusters,n_data);
    dist_temp = dist.^(2/(m-1));
    
    for i = 1:n_clusters
        U_new(i,:) = 1./(sum((repmat(dist_temp(i,:),2,1)).*dist_temp));
    end
    
    if t>1
        if abs(Jm(t) - Jm(t-1)) < e
            break;
        end
        U = U_new;
    end
end

Jm(t+1:max_iter) = [];

