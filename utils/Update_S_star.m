function [S_star,obj,time] = Update_S_star(KH,k)
time=0;
[num,~,viewnum] = size(KH);
for p =1:viewnum
    if p==1
        [S(:,:,1),H(:,:,1)] = initialize(KH(:,:,1),k);
        S_star= S(:,:,1);
        obj = 0;
    else
        tic;
        [S(:,:,p),H(:,:,p)] = initialize(KH(:,:,p),k);
        P(:,:,p) = eye(k,k);
        S_star_last = S_star;
        [S_star,obj]=each_anchormatrix(KH(:,:,p),S(:,:,p),H(:,:,p),P(:,:,p),S_star_last);
        toc;
        time=time+toc;
    end
end
time=time/(viewnum-1);
end