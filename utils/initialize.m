function [S,H] = initialize(X,k)

 [U,~,V] = svd(X,'econ');
 S = U(:, 1:k);
 H = V(1:k, :);
end