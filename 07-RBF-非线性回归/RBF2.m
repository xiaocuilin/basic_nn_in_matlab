%% 案例7：RBF网络的回归-非线性函数回归的实现 

%% 清空环境变量
clc
clear
%% 产生训练样本（训练输入，训练输出）
% ld为样本例数
ld=400; 

% 产生2*ld的矩阵 
x=rand(2,ld); 

% 将x转换到[-1.5 1.5]之间
x=(x-0.5)*1.5*2; 

% x的第一列为x1，第二列为x2.
x1=x(1,:);
x2=x(2,:);

% 计算网络输出F值
F=20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);

xx1=x1;xx2=x2;FF=F;

%% 建立RBF神经网络 
% 采用approximate RBF神经网络。spread为默认值
net=newrb(x,F);

%% 建立测试样本

% generate the testing data
interval=0.1;
[i, j]=meshgrid(-1.5:interval:1.5);
row=size(i);
tx1=i(:);
tx1=tx1';
tx2=j(:);
tx2=tx2';
tx=[tx1;tx2];

%% 使用建立的RBF网络进行模拟，得出网络输出
ty=sim(net,tx);

%% 使用图像，画出3维图

% 真正的函数图像
interval=0.1;
[x1, x2]=meshgrid(-1.5:interval:1.5);
F = 20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);
subplot(2,2,1)
mesh(x1,x2,F);
zlim([0,60])
title('真正的函数图像')

% 网络得出的函数图像
v=reshape(ty,row);
subplot(2,2,2)
mesh(i,j,v);
zlim([0,60])
title('RBF神经网络结果')

% 训练图像
subplot(2,2,3)
scatter3(xx1,xx2,FF,6,'filled');
zlim([0,60])
title('训练图像')

% 误差图像
subplot(2,2,4)
mesh(x1,x2,F-v);
%zlim([0,0.1])
title('误差图像')

set(gcf,'position',[140 ,100,900,600])

err1=sum(sum(abs(F-v))')

