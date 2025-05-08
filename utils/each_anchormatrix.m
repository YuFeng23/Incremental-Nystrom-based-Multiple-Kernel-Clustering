function [S_star,obj] = each_anchormatrix(KH,S,H,P,S_star_last)

maxIter = 100;
flag = 1;
iter = 0;
while flag
    iter=iter+1;
    %update S_star
    AA = S*P +S_star_last;
    [UA,~,VA] = svd(AA,'econ');
    S_star = UA*VA';
    %update S_t 
    BB = KH*H' + S_star*P';
    [UB,~,VB] = svd(BB,'econ');
    S = UB*VB';
    %update P_t
    CC = S'*S_star;
    [UC,~,VC] = svd(CC,'econ');
    P = UC*VC';
    %update H_t
    DD = KH'*S;
    [UD,~,VD] = svd(DD,'econ');
    H = VD*UD';
    obj(iter) = (norm(KH - S*H,'fro'))^2+ (norm(S_star - S*P,'fro'))^2+(norm(S_star - S_star_last,'fro'))^2;
%     obj(iter) = (norm(KH - S*H','fro'))^2+ (norm(S_star - S*P,'fro'))^2+beta*(norm(S_star - S_star_last,'fro'))^2;
    if (iter>9) && (abs((obj(iter-1)-obj(iter))/(obj(iter)))<1e-6 || iter>maxIter)
        %     if iter==maxIter
        flag =0;
    end
end
end
