center = [0,0,0.11;
          1,1,0.11;
          1,0,0.11;
          0,1,0.11;
          2,1,0.11;
          -1,0,0.11;
          2,0,0.11;
          1,2,0.11];
alpha=1.0;
%=======one hidden layer=======
% oi = [0 0 0 0 0 0 0 0 1]';
% sj = [0 0 0 0 0 0 0 0 0]';
% oj = [0 0 0 0 0 0 0 0 0 1]';
% sk = [0 0 0]';
% ok = [0 0 0]';
% dk = [0 0 0]';
% ninpdim1=9;
% nhid=9;
% nhid1=10;
% noutdim=3;
%=======two hidden layer=======
si = [0 0 0 0 0 0 0 0 0]';
oi = [0 0 0 0 0 0 0 0 0 1]';
sj = [0 0 0 0 0 0]';
oj = [0 0 0 0 0 0 1]';
sk = [0 0 0]';
ok = [0 0 0]';
dk = [0 0 0]';
ninpdim1=9;
nhid1_input=9;
nhid1_output=10;
nhid2_input=6;
nhid2_output=7;
noutdim=3;
%==========Initial eight cluster==========
[dataset_rand,dataset_sort] = initial_data();
%==========Calculate PFS==========
figure;
X = dataset_sort(:,2:3);
N=400;
max_iter = 50;

for K=2:12
    [C,L] = mykmeans(X,K,max_iter);
    dataset_L = [L,X];
    for i=1:K
        [r,c] = find(dataset_L==i);
        %每一群中心點
        M(i,1:2) = sum(dataset_L(r,2:3))/sum(c);
        M_all = sum(dataset_L(:,2:3))/400;
    end
    trSw = 0;
    trSb = 0;
    for i = 1:K
        [r,c] = find(dataset_L==i);
        %第i類的點減第i類的中心點
        trSw_temp = (dataset_L(r,2:3)-repmat(M(i,1:2)',[1 sum(c)])');
        trSw = trSw + sum(trSw_temp(:,1).^2+trSw_temp(:,2).^2);
        trSb_temp = (M(i,1:2)-M_all);
        trSb = trSb + sum(c)*sum(trSb_temp(:,1).^2+trSb_temp(:,2).^2);
    end
    PFS(K,1) = K;
    PFS(K,2) = ((N-K)*trSb)/((K-1)*trSw);
end
plot(PFS(:,1),PFS(:,2));

%==========Layer2==========
for i=1:length(dataset_sort)
    for j=1:length(center)
        x=dataset_sort(i,2:3);
        mu=center(j,1:2);
        sigma=center(j,3);
        response(i,j)=gaussian(x,mu,sigma);
    end
end

%==========Training weighting==========
%==========one hidden layer==========
%[wji,wkj] = myperceptron1(response,dataset_sort);
%==========two hidden layer==========
[wib,wji,wkj] = myperceptron2(response,dataset_sort);

%==========Plot decision boundary
for i=1:51
    dataset_region(40*(i-1)+1:40*i,1) = -2.1+i*0.1;
    dataset_region(40*(i-1)+1:40*i,2) = -1:0.1:2.9;
end

for i=1:length(dataset_region)
    for j=1:length(center)
        x=dataset_region(i,1:2);
        mu=center(j,1:2);
        sigma=center(j,3);
        response_region(i,j)=gaussian(x,mu,sigma);
    end
    if response_region_to_propotion(i, :) <=0.00001
        response_region_to_propotion(i,1:8) = response_region(i, :)/sum(response_region(i, :));
    else
        response_region_to_propotion(i,1:8) = response_region(i, :);
    end
end

figure;
hold on;
axis([-2, 3, -1, 3]);

for index=1:1:2040
%==========two hidden layer==========
    ob=[response_region_to_propotion(index,1:8) 1]';
    for i=1:nhid1_input
        si(i)=wib(i,:)*ob;
        oi(i)=1/(1+exp(-si(i)));
    end
    oi(nhid1_output)=1.0;
    for j=1:nhid2_input
        sj(j)=wji(j,:)*oi;
        oj(j)=1/(1+exp(-sj(j)));
    end
    oj(nhid2_output)=1.0;
    for k=1:noutdim
        sk(k)=wkj(k,:)*oj;
        ok(k)=1/(1+exp(-sk(k)));
    end
    result(1:3,index)=ok;
%==========one hidden layer==========
%     oi=[response_region(index,1:8) 1]';
% 
%     for j=1:nhid
%         sj(j)=wji(j,:)*oi;
%         oj(j)=1/(1+exp(-sj(j)));
%     end
%     oj(nhid1)=1.0;
%     for k=1:noutdim
%         sk(k)=wkj(k,:)*oj;
%         ok(k)=1/(1+exp(-sk(k)));
%     end
    % Real output
    if ok(1,1)>0.5
        plot(dataset_region(index,1),dataset_region(index,2), 'r .');
    elseif ok(2,1)>0.5
        plot(dataset_region(index,1),dataset_region(index,2), 'g .');
    elseif ok(3,1)>0.5
        plot(dataset_region(index,1),dataset_region(index,2), 'b .');
    end
    hold on;
end
hold off;