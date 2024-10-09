function [Y,YY]=day9_dataload(A)


Da=A(1:6,:); %Cond 1 to 6 shared by donor 10 donors : D8-D17
Db=A(7:8,1:4); %Cond 7 & 8 shared by 4 donors 4 donors : D25-D28
Dc=A(9:end,1:3); %Cond b4', b7', b10' & b11'shared by 3 donors : D32-D34

Na=10; %No of donors
Nb=4;
Nc=3;

%Totaldonor 17
ND=Na+Nb+Nc;



%Start calculating weights for individual donors
[xyz,u,v,w,ratio]=donor_weights(Da,Db,Dc);
xyz

mean_A=mean(Da,2);
mean_B=mean(Db,2);
mean_C=mean(Dc,2);

%Standard Mean
Y=vertcat(mean_A,mean_B,mean_C); ;%varage value from 10 donors

WA=xyz(1:10);
WB=xyz(11:14);
WC=xyz(15:end);

Da(1,:);
fa=WA/sum(WA);
fb=WB/sum(WB);
fc=WC/sum(WC);

f=vertcat(fa,fb,fc)
sum(fa);
sum(fb);
sum(fc);
YA=sum(Da.*fa',2);

YB=sum(Db.*fb',2);

Dc;
fc;
YC=sum(Dc.*fc',2);

YY=vertcat(YA,YB,YC);

end