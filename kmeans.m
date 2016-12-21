% C is a K*f matrix
% L is the label of each sample
%=10000*2
%C是K個中心點的二維陣列
function [C L]=kmeans(X,K,max_iter)
%r=10000,f=2
[r f]=size(X);
%randperm=1-10000 size=1*10000
tmp = randperm(r);
%把上面隨機的tmp放在X裡，找尋X裡面的那些index, size=5*2
C = X(tmp(1:K),:);
for i = 1 : max_iter
    %disp(i);
    for j = 1 : K
        %計算距離:X的每個點到C的第一列(5個中心點)的距離，C也擴增成2*10000
        dist(j,:) =sum(( X'-repmat(C(j,:)',[1 r])).^2);
    end
    %從dist裡面挑最小的minv是最小的值，L1是所在的列(也就是找到該要在哪一個中心點了)
    [minv L1]=min(dist);
    if(i==1)
        %如果是第一次iteration，則L = L1'
        L = L1';
        for j = 1 : K
            %找出屬於j個中心點的平均
            C(j,:) = mean(X(find(L==j),:));
        end
    else
        if(isequal(L,L1'))
            break;
        else
            L = L1';
            for j = 1 : K
                C(j,:) = mean(X(find(L==j),:));
            end
        end
    end
%     figure;
%     colortable = 'rgbcmykw';
%     hold on;
%     for j = 1: K
%         style = sprintf('.%c',colortable(j));
%         plot(X(L==j,1),X(L==j,2),style);
%         style = sprintf('x%c',colortable(j));
%         plot(C(j,1),C(j,2));
%     end
end