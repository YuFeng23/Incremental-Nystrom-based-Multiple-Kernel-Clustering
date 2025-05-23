function [res_mean,res_std,H]= myNMIACCV2(U_normalized,Y,numclass)

stream = RandStream.getGlobalStream;
reset(stream);
d = size(U_normalized,2);
U_normalized = U_normalized ./ repmat(sqrt(sum(U_normalized.^2, 2)), 1,d);
maxIter = 20;
% tmp1 = zeros(maxIter,1);
% tmp2 = zeros(maxIter,1);
% tmp3 = zeros(maxIter,1);
% for iter = 1:maxIter
%     indx = litekmeans(U_normalized,numclass,'MaxIter',100, 'Replicates',1);
%     indx = indx(:);
%     [newIndx] = bestMap(Y,indx);
%     tmp1(iter) = mean(Y==newIndx);
%     tmp2(iter) = MutualInfo(Y,newIndx);
%     tmp3(iter) = purFuc(Y,newIndx);
% end
% res = [max(tmp1);max(tmp2);max(tmp3)];
res1 = zeros(maxIter,1);
res2 = zeros(maxIter,1);
res3 = zeros(maxIter,1);
res4 = zeros(maxIter,1);
for it = 1 : maxIter
    indx = litekmeans(U_normalized,numclass, 'MaxIter',100, 'Replicates',10);
    %% indx = kmeans(U_normalized,numclass, 'MaxIter',100, 'Replicates',maxIter);
    indx = indx(:);
    size_Z = size(U_normalized);
    Z = zeros(size_Z);
    for i = 1:size_Z(1)
        Z(i,indx(i)) = 1;
    end
    H = Z / sqrt((Z' * Z));
    
    [newIndx] = bestMap(Y,indx);
    res1(it) = mean(Y==newIndx);
    res2(it) = MutualInfo(Y,newIndx);
    res3(it) = purFuc(Y,newIndx);
    res4(it) = adjrandindex(Y,newIndx);
end
res_mean(1) = mean(res1);
res_mean(2) = mean(res2);
res_mean(3) = mean(res3);
res_mean(4) = mean(res4);
res_std(1) = std(res1);
res_std(2) = std(res2);
res_std(3) = std(res3);
res_std(4) = std(res4);