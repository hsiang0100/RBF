% C is a K*f matrix
% L is the label of each sample
%=10000*2
%C�OK�Ӥ����I���G���}�C
function [C L]=kmeans(X,K,max_iter)
%r=10000,f=2
[r f]=size(X);
%randperm=1-10000 size=1*10000
tmp = randperm(r);
%��W���H����tmp��bX�̡A��MX�̭�������index, size=5*2
C = X(tmp(1:K),:);
for i = 1 : max_iter
    %disp(i);
    for j = 1 : K
        %�p��Z��:X���C���I��C���Ĥ@�C(5�Ӥ����I)���Z���AC�]�X�W��2*10000
        dist(j,:) =sum(( X'-repmat(C(j,:)',[1 r])).^2);
    end
    %�qdist�̭��D�̤p��minv�O�̤p���ȡAL1�O�Ҧb���C(�]�N�O���ӭn�b���@�Ӥ����I�F)
    [minv L1]=min(dist);
    if(i==1)
        %�p�G�O�Ĥ@��iteration�A�hL = L1'
        L = L1';
        for j = 1 : K
            %��X�ݩ�j�Ӥ����I������
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