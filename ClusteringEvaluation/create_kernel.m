function P = create_kernel(A, C)
num = size(A, 1);
anchor_num = size(C, 1);

dmatrix = repmat(sum(A .* A, 2), 1, anchor_num) + repmat(sum(C .* C, 2), 1, num)' - 2 * A * C';
delta = 2 * sum(sum(dmatrix)) / (num * anchor_num);
P = exp(-dmatrix / delta);
end