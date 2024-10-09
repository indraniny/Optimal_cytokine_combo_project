function [WW,Y]=Attempt1_weight_assign(A)

% clear all;
 load day_9_donors.dat
%  
 A=day_9_donors(:,:) ;

Da=[A(1,:);A(4:6,:)] %Cond 1,4,5,6 shared by donor 10 donors : D8-D17

Da2=[A(2,:),12.0,11.4,12.0;A(3,:),19.2,18.0,17.1] %cond2, cond3 are shared by 13 donors : D8-D17, D32-D34

Db=A(7:8,1:4); %Cond 7 & 8 shared by 4 donors 4 donors : D25-D28
Dc=A(9:end,1:3); %Cond b4', b7', b10' & b11'shared by 3 donors : D32-D34

w1=0.9
w2=.1

%Weight calculation for donors in group-A
U=var(Da,0,1); %group A : 6 conditions : variance for 10 donors 
index_Da=8:17
group_A=[U',index_Da']
sort_group_A=sortrows(group_A)
mean(U)
median(U)
medme=w1*median(U)+w2*mean(U)

dev=(U-medme).^2
W=1./dev
norm_W=W/(sum(W))

[U',norm_W']

sum(norm_W)

YA=sum(Da.*norm_W,2)

%Weight calculation for donors in group-A2
U2=var(Da2,0,1) %group A : 6 conditions : variance for 10 donors 
index_Da2=8:20
group_A2=[U2',index_Da2']
sort_group_A2=sortrows(group_A2)
mean(U2)
median(U2)
medme=w1*median(U2)+w2*mean(U2)

dev=(U2-medme).^2
W2=1./dev
norm_W2=W2/(sum(W2))

[U2',norm_W2']

sum(norm_W2)

YA2=sum(Da2.*norm_W2,2)





%Weight calculation for donors in group-B
V=var(Db,0,1) %group B : 2 conditions : variance for 4 donors
index_Db=25:28
group_B=[V',index_Db']
sort_group_B=sortrows(group_B);
medmeB=w1*median(V)+w2*median(V)

devB=(V-medmeB).^2
WB=1./devB
norm_WB=WB/(sum(WB))

[V',norm_WB']

sum(norm_WB)

YB=sum(Db.*norm_WB,2)


% %Weight calculation for donors in group-C
wc=var(Dc,0,1) %group B : 2 conditions : variance for 4 donors
index_Dc=32:34
group_C=[wc',index_Dc']
sort_group_C=sortrows(group_C);
medmeC=w1*median(wc)+w2*mean(wc)


devC=(wc-medmeC).^2
WC=1./devC
norm_WC=WC/(sum(WC))

[wc',norm_WC']

sum(norm_WC)

YC=sum(Dc.*norm_WC,2)


WW=vertcat(norm_W',norm_WB', norm_WC');
YA;
YA3=YA(2:4);
YAA=vertcat(YA(1),YA2,YA3)

YB
YC

Y=vertcat(YAA,YB,YC)

end 
