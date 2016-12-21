function [dataset_rand,dataset_sort] = initial_data()

mu = [0;0]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_r_1 = mvnrnd(mu, convariance, 50);
plot(data_r_1(:,1),data_r_1(:,2),'.','MarkerEdgeColor','r');
data_r_1(:,3)=1;
data_r_1(:,4)=0;
data_r_1(:,5)=0;
dataset = [data_r_1];
hold on;

mu = [1;1]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_r_2 = mvnrnd(mu, convariance, 50);
plot(data_r_2(:,1),data_r_2(:,2),'.','MarkerEdgeColor','r');
data_r_2(:,3)=1;
data_r_2(:,4)=0;
data_r_2(:,5)=0;
dataset = [dataset;data_r_2];
hold on;

mu = [1;0]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_g_1 = mvnrnd(mu, convariance, 50);
plot(data_g_1(:,1),data_g_1(:,2),'x','MarkerEdgeColor','g');
data_g_1(:,3)=0;
data_g_1(:,4)=1;
data_g_1(:,5)=0;
dataset = [dataset;data_g_1];
hold on;

mu = [0;1]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_g_2 = mvnrnd(mu, convariance, 50);
plot(data_g_2(:,1),data_g_2(:,2),'x','MarkerEdgeColor','g');
data_g_2(:,3)=0;
data_g_2(:,4)=1;
data_g_2(:,5)=0;
dataset = [dataset;data_g_2];
hold on;

mu = [2;1]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_g_3 = mvnrnd(mu, convariance, 50);
plot(data_g_3(:,1),data_g_3(:,2),'x','MarkerEdgeColor','g');
data_g_3(:,3)=0;
data_g_3(:,4)=1;
data_g_3(:,5)=0;
dataset = [dataset;data_g_3];
hold on;

mu = [-1;0]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_b_1 = mvnrnd(mu, convariance, 50);
plot(data_b_1(:,1),data_b_1(:,2),'+','MarkerEdgeColor','b');
data_b_1(:,3)=0;
data_b_1(:,4)=0;
data_b_1(:,5)=1;
dataset = [dataset;data_b_1];
hold on;

mu = [2;0]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_b_2 = mvnrnd(mu, convariance, 50);
plot(data_b_2(:,1),data_b_2(:,2),'+','MarkerEdgeColor','b');
data_b_2(:,3)=0;
data_b_2(:,4)=0;
data_b_2(:,5)=1;
dataset = [dataset;data_b_2];
hold on;

mu = [1;2]; 
sigma=0.11;
convariance=[sigma.^2 0; 0 sigma.^2];
data_b_3 = mvnrnd(mu, convariance, 50);
plot(data_b_3(:,1),data_b_3(:,2),'+','MarkerEdgeColor','b');
data_b_3(:,3)=0;
data_b_3(:,4)=0;
data_b_3(:,5)=1;
dataset = [dataset;data_b_3];
hold on;

title('Original plot');
dataset_rand = [randperm(400)',dataset];
dataset_sort = sortrows(dataset_rand);
hold off;