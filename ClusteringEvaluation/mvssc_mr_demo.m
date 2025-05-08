clc
clear all;


dataName = 'UCI_DIGIT';
path = './';
addpath(genpath(path));

load(['/home/jeanine/Documents/MATLAB/dataset/',dataName,'_Kmatrix.mat']);
%KH = kcenter(KH);
%KH(:,:,1) = knorm(K{1,1});
%KH(:,:,2) = knorm(K{2,1});
KH = knorm(KH);
numclass = length(unique(Y));
Y(Y<1) = numclass;
numker = size(KH,3);
num = size(KH,1);
anchor_list = 500;
lamda = 1;
n = 30;
for an = 1:length(anchor_list)
   for i =1:n
   rng('shuffle') 
   [H,gamma,obj] = MVSSC_MRR(KH, anchor_list(an), numclass,lamda);
   res_mean(:,i,an) = myNMIACCV2(H,Y,numclass);
   end
end
index_MR_mean = mean(res_mean,2);
for an = 1:length(anchor_list)
   for i =1:n
   rng('shuffle') 
   [H,gamma,obj] = MVSSC(KH, anchor_list(an), numclass,lamda);
   res_mean_list(:,i,an) = myNMIACCV2(H,Y,numclass);
   end
end
index_ER_mean = mean(res_mean_list,2);