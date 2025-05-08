clc
clear all;

dataName = 'SUNRGBD_fea';
path = './';
addpath(genpath(path));

load(['/home/jeanine/Documents/MATLAB/dataset/',dataName,'_Kmatrix.mat']);
KH(:,:,1) = K{1,1};
KH(:,:,2) = K{2,1};
%KH = KH_temp;
%Y = Y_temp;
k = length(unique(Y));
Y(Y<1) = k;
nbSltPnt = 100:500:10000;
T =[];
n = 30;
for an = 1:length(nbSltPnt)
    for i = 1:n
        rng('shuffle')
        tic; % 启动计时器
        SSC(KH, nbSltPnt(an),k);
        t(an:i)= toc; % 输出经过的时间
    end
    T(an) = mean(t,2);
end
plot(nbSltPnt,T,'b-*','LineWidth',1,'markerfacecolor','b');
grid on 
xlabel('Sample Number','fontsize',14);
axis([100 10000,-inf,inf]);
xticks(nbSltPnt);
set(gca,'yTickLabel',num2str(get(gca,'yTick')','%.3f'));
ylabel('Time','fontsize',14);
title('SUNRGBD','fontsize',14);
set(gca,'XTickLabelRotation',46);
axis tight