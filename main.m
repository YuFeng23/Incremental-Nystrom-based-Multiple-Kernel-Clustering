clc;
clear all;
% clc;
warning off;
addpath(genpath('./'));
addpath(genpath('ClusteringEvaluation'));
addpath(genpath('utils'));

%% dataset

% ds ={'CUB'};
ds = {'proteinFold'};
% ds = {'Fashion_3V'};
% ds = {'ALOI-100'};
% ds ={'NoisyMNIST'};
%  ds ={'YouTubeFace10_4Views'};
% ds ={'Winnipeg1_fea'};
% ds ={'YouTubeFace100_4Views'};

dsPath = '.\dataset\';
resultdir = '.\res\';
metric = {'ACC','nmi','Purity'};
MaxResSavePath = 'final_res\';


for dsi =1:length(ds)
    dataName = ds{dsi}; disp(dataName);
    load(strcat(dsPath,dataName));


k = length(unique(Y));
Y(Y<1) = k;

viewnum = size(X,1);


n = size(Y,1);
num =size(X{1},1);

num_anchors = 300;

accelerated_flag = 0;
Z = [];


rng(5489); 

tic;
for i =1:viewnum
    [rInd_temp(i,:), ~] = recursiveNystrom_kernel(X{i},num_anchors,accelerated_flag);
    KH(:,:,i) = create_kernel(X{i},X{i}(rInd_temp(i,:),:));
end
time1= toc;


[S_star,obj,time2] = Update_S_star(KH,k);

res = myNMIACC(S_star,Y,k);

time  = time1/viewnum+time2;


fullFileName = fullfile(MaxResSavePath, [ds{dsi} '_result.mat']);
save(fullFileName, 'res','time');
end
tabulate(Y);

