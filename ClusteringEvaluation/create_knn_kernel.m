function Kernel = create_knn_kernel(A,num_anchors,k_nn)
num = size(A, 1);
index = datasample(1:num, num_anchors, 'Replace', false);
Ancpnt = A(index,:);
PairDist = repmat(sum(A .* A, 2), 1, num_anchors) + repmat(sum(Ancpnt .* Ancpnt, 2), 1, num)' - 2 * A * Ancpnt';
param = 2 * sum(sum(PairDist)) / (num * num_anchors);
[~, ind] = sort(PairDist,2);
ind = ind(:,1:k_nn);
IndMask = zeros(num - num_anchors, num_anchors);
for i = 1:num 
         IndMask(i, ind(i,:)) = 1;
end
Kernel = exp(-PairDist /param);
Kernel = Kernel.*IndMask;
end