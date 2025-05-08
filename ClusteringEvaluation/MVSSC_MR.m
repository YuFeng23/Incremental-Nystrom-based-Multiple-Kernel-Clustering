function [Gx,gamma,obj] =MVSSC_MR(KH,num_anchors,k,lamda)
%n = 30;
[num,~,numker] = size(KH);
gamma = ones(numker, 1) / numker;
index = datasample(1:num, num_anchors, 'Replace', false);
PH = KH(:,index,:);


for ker = 1:numker
    P_temp = PH(:,:,ker);
    Dc_temp = 1./sqrt(sum(P_temp,1));
    Dr_temp = 1./sqrt(sum(P_temp,2));
    PH(:,:,ker) =Dc_temp.*( Dr_temp .*P_temp );
    %PH(:,:,ker) = diag(Dr_temp) *  P_temp * diag(Dc_temp);
end

% PH = Gcenter(PH);

h = zeros(numker, 1);
flag = 1;
nloop = 0;

while flag
    nloop = nloop+1;
    gamma_old = gamma;
    Z_star = sumKbeta(PH, (gamma.^2));
    [Gx, ~, Gu] = svds(Z_star, k);

    for ker = 1:numker
        h(ker) = -k+trace(Gx'*PH(:,:,ker)*Gu); %*** h(v) = trace(G'*L{v}*G);
    end
    M = calM(PH);
    obj(nloop) = (1/2)*gamma'*(lamda*M+2*diag(h))*gamma;
    
    gamma = updatekernelweights(h,M,lamda);
    if  max(abs(gamma_old-gamma))<1e-5
        flag = 0;
        fprintf(1,'variation convergence criteria reached \n');
    end
end

end

