clc
clear all;


dataName = 'Reuters2';
path = './';
addpath(genpath(path));

load(['/home/jeanine/Documents//data/',dataName,'.mat']);
X =X';
[~,V] = size(X);
anchor_list =500;
for i = 1:1:V
    X{1,i} = full(X{1,i});
    KH(:,:,i) = create_kernel(X{1,i}, X{1,i});
end
KH = knorm(KH);
numclass = length(unique(Y));
Y(Y<1) = numclass;
n = 30;
lamda = 1;
for an = 1:length(anchor_list)
   for i =1:n
   rng('shuffle') 
   [H,gamma,obj] = MVSSC(KH, anchor_list(an), numclass,lamda);
   res_mean_list(:,i,an) = myNMIACCV2(H,Y,numclass);
   end
end
res_mean = mean(res_mean_list,2);
for an = 1:length(anchor_list)
   for i =1:n
   rng('shuffle') 
   [H,gamma,obj] = MVSSC_MR(KH, anchor_list(an), numclass,lamda);
   res_mean1(:,i,an) = myNMIACCV2(H,Y,numclass);
   end
end
index_mean = mean(res_mean1,2);