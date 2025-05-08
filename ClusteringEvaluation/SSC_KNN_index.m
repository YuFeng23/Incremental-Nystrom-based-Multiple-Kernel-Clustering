clc
clear all;


dataName = 'Caltech101-7';
path = './';
addpath(genpath(path));

load(['/home/jeanine/Documents/data_candidate/',dataName,'.mat']);
% X = data;
% Y = truth;
X = X';
[V,~] = size(X);

for i = 1:1:V
    KH(:,:,i) =create_kernel(X{i,1},X{i,1});
end


KH = knorm(KH);
numclass = length(unique(Y));
Y(Y<1) = numclass;
numker = size(KH,3);
num = size(KH,1);
anchor_list = 500;
lamda = 1;
n = 30;
% for an = 1:length(anchor_list)
%    for i =1:n
%    rng('shuffle') 
%    [H,gamma,obj] = MVSSC_MRR(KH, anchor_list(an), numclass,lamda);
%    res_mean(:,i,an) = myNMIACCV2(H,Y,numclass);
%    end
% end
% index_MR_mean = mean(res_mean,2);
for an = 1:length(anchor_list)
   for i =1:n
   rng('shuffle') 
   [H,gamma,obj] = MVSSC(KH, anchor_list(an), numclass,lamda);
   res_mean_list(:,i,an) = myNMIACCV2(H,Y,numclass);
   end
end
index_ER_mean = mean(res_mean_list,2);