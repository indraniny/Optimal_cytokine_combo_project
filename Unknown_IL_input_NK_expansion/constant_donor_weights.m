function [YY]=constant_donor_weights
load day_9_donors.dat

A=day_9_donors(:,:) ;
Da=A(1:6,:); %Cond 1 to 6 shared by donor 10 donors : D8-D17
Db=A(7:8,1:4); %Cond 7 & 8 shared by 4 donors 4 donors : D25-D28
Dc=A(9:end,1:3); %Cond b4', b7', b10' & b11'shared by 3 donors : D32-D34

Na=10; %No of donors
Nb=4;
Nc=3;

%Totaldonor 17
ND=Na+Nb+Nc;


Da
Db
Dc
U=var(Da,0,1) %group A : 6 conditions : variance for 10 donors 
V=var(Db,0,1) %group B : 2 conditions : variance for 4 donors
W=var(Dc,0,1) %group C : 4 conditions : variance for 3 donors

variance_donors =[U,V,W]' %17 donors variance
donor_index=[8:17,25:28,32:34]';
Q=[variance_donors,donor_index]
Q_sort=sortrows(Q)

plot(Q_sort(1:9,1),5,'go',Q_sort(10:15,1),5,'ro',Q_sort(16,1),5,'go',Q_sort(17,1),5,'ko','LineWidth',2,'MarkerSize',10) %First 9 donor
% plot(Q_sort(10:15,1),5,'ro','LineWidth',2,'MarkerSize',10) % middle 6 donors
% plot(Q_sort(16,1),5,'go','LineWidth',2,'MarkerSize',10) %First 9 donor


W=[2+zeros(8,1);3;13+zeros(6,1); 2;1]/100.0
sum(W)
Q_sort=[Q_sort,W]
temp=[Q_sort(:,2),Q_sort(:,1),Q_sort(:,3)]

sort_temp=sortrows(temp)

xyz=sort_temp(:,3)

WA=xyz(1:10)
WB=xyz(11:14)
WC=xyz(15:end)

Da(1,:);
fa=WA/sum(WA)
fb=WB/sum(WB)
fc=WC/sum(WC)

f=vertcat(fa,fb,fc)
sum(fa)
sum(fb)
sum(fc)
YA=sum(Da.*fa',2)

YB=sum(Db.*fb',2)

Dc
fc
YC=sum(Dc.*fc',2)

YY=vertcat(YA,YB,YC)
f

end