function [WW,Y]=Attempt0_weight_assign(A)

% clear all;
% load day_9_donors.dat
%  
% A=day_9_donors(:,:) ;

Da=A(1:6,:); %Cond 1 to 6 shared by donor 10 donors : D8-D17
Db=A(7:8,1:4); %Cond 7 & 8 shared by 4 donors 4 donors : D25-D28
Dc=A(9:end,1:3); %Cond b4', b7', b10' & b11'shared by 3 donors : D32-D34

w1=0.9
w2=.1

%Weight calculation for donors in group-A
U=var(Da,0,1) %group A : 6 conditions : variance for 10 donors 
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


WW=vertcat(norm_W',norm_WB', norm_WC')
Y=vertcat(YA,YB,YC)

end 
