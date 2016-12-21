function [wib,wji,wkj] = myperceptron2(response,dataset_sort)
%==========Initialize==========
nvectors=400;
ninpdim1=9;
nhid1_input=9;
nhid1_output=10;
nhid2_input=5;
nhid2_output=6;
noutdim=3;

wkj = randn(3,6);
wkj_tmp = zeros(size(wkj));
wji = randn(5,10);
%wji_tmp = zeros(size(wji));
wib = randn(9,9);
olddelwkj=[0 0 0 0 0 0;
           0 0 0 0 0 0;
           0 0 0 0 0 0];
olddelwji=[0 0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0 0];
olddelwib=[0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0;
           0 0 0 0 0 0 0 0 0];
ob = [0 0 0 0 0 0 0 0 1]';
si = [0 0 0 0 0 0 0 0 0]';
oi = [0 0 0 0 0 0 0 0 0 1]';
sj = [0 0 0 0 0]';
oj = [0 0 0 0 0 1]';
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
sumbackj = zeros(1,nhid2_input);
deltaj = zeros(1,nhid2_input);
sumbacki = zeros(1,nhid1_input);
deltai = zeros(1,nhid1_input);
 
%==========Training==========
while (error_avg > Lowerlimit) && (iter<itermax)
    iter=iter+1;
    error=0;
    %==========Forward Computation:==========    
    for ivector=1:nvectors
        ob=[response(ivector,:) 1]';
        dk=[dataset_sort(ivector,4) dataset_sort(ivector,5) dataset_sort(ivector,6)]';
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
        error=error+sum(abs(dk-ok));
        
        %==========Backward learning:==========        
        for k=1:noutdim
            deltak(k)=(dk(k)-ok(k))*ok(k)*(1.0-ok(k));
        end
        
        for j=1:nhid2_output
            for k=1:noutdim
                wkj_tmp(k,j)=wkj(k,j)+eta*deltak(k)*oj(j)+beta*olddelwkj(k,j);
                olddelwkj(k,j)=eta*deltak(k)*oj(j)+beta*olddelwkj(k,j);
            end
        end
        
        for j=1:nhid2_input
            sumbackj(j)=0.0;
            for k=1:noutdim
                sumbackj(j)=sumbackj(j)+deltak(k)*wkj(k,j);
            end
            deltaj(j)=oj(j)*(1.0-oj(j))*sumbackj(j);
        end
        for i=1:nhid1_output
            for j=1:nhid2_input
                wji(j,i)=wji(j,i)+eta*deltaj(j)*oi(i)+beta*olddelwji(j,i);
                olddelwji(j,i)=eta*deltaj(j)*oi(i)+beta*olddelwji(j,i);
            end
        end
        
        for i=1:nhid1_input
            sumbacki(i)=0.0;
            for j=1:nhid2_input
                sumbacki(i)=sumbacki(i)+deltaj(j)*wji(j,i);
            end
            deltaj(i)=oi(i)*(1.0-oi(i))*sumbacki(i);
        end
        for b=1:ninpdim1
            for i=1:nhid1_input
                wib(i,b)=wib(i,b)+eta*deltai(i)*ob(b)+beta*olddelwib(i,b);
                olddelwib(i,b)=eta*deltai(i)*ob(b)+beta*olddelwib(i,b);
            end
        end
        wkj = wkj_tmp;
        %==========Backward learning:==========

    end

    ite(iter)=iter;
    error_avg=error/nvectors;
    error_r(iter)=error_avg;
end
figure;
hold on;
plot(ite, error_r);

end