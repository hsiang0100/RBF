function [wji,wkj] = myperceptron1(response,dataset_sort)
%==========Initialize==========
nvectors=400;
ninpdim1=9;
nhid=9;
nhid1=10;
noutdim=3;

wkj = randn(3,10);
wkj_tmp = zeros(size(wkj));
wji = randn(9,9);
olddelwkj=[0 0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0 0];
olddelwji=[0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0];
oi = [0 0 0 0 0 0 0 0 1]';
sj = [0 0 0 0 0 0 0 0 0]';
oj = [0 0 0 0 0 0 0 0 0 1]';
sk = [0 0 0]';
ok = [0 0 0]';
dk = [0 0 0]';
 
Lowerlimit=0.02;
itermax=500;
eta=0.7;
beta=0.3;
iter=0;
error_avg=10;

deltak = zeros(1,noutdim);
sumback = zeros(1,nhid);
deltaj = zeros(1,nhid);
 
%==========Training==========
while (error_avg > Lowerlimit) && (iter<itermax)
    iter=iter+1;
    error=0;
    %==========Forward Computation:==========    
    for ivector=1:nvectors
        oi=[response(ivector,:) 1]';
        dk=[dataset_sort(ivector,4) dataset_sort(ivector,5) dataset_sort(ivector,6)]';
        for j=1:nhid
            sj(j)=wji(j,:)*oi;
            oj(j)=1/(1+exp(-sj(j)));
        end
        oj(nhid1)=1.0;
 
        for k=1:noutdim
            sk(k)=wkj(k,:)*oj;
            ok(k)=1/(1+exp(-sk(k)));
        end
        error=error+sum(abs(dk-ok));
        
        %==========Backward learning:==========
        for k=1:noutdim
            deltak(k)=(dk(k)-ok(k))*ok(k)*(1.0-ok(k));
        end
        for j=1:nhid1
            for k=1:noutdim
                wkj_tmp(k,j)=wkj(k,j)+eta*deltak(k)*oj(j)+beta*olddelwkj(k,j);
                olddelwkj(k,j)=eta*deltak(k)*oj(j)+beta*olddelwkj(k,j);
            end
        end
        for j=1:nhid
            sumback(j)=0.0;
            for k=1:noutdim
                sumback(j)=sumback(j)+deltak(k)*wkj(k,j);
            end
            deltaj(j)=oj(j)*(1.0-oj(j))*sumback(j);
        end
        for i=1:ninpdim1
            for j=1:nhid
                wji(j,i)=wji(j,i)+eta*deltaj(j)*oi(i)+beta*olddelwji(j,i);
                olddelwji(j,i)=eta*deltaj(j)*oi(i)+beta*olddelwji(j,i);
            end
        end
            wkj = wkj_tmp;
    end
    ite(iter)=iter;
    error_avg=error/nvectors;
    error_r(iter)=error_avg;
end
figure;
hold on;
plot(ite, error_r);

end