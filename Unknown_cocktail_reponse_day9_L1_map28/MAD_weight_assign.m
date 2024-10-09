function [WW,Y]=Attempt0_weight_assign(A)

clear all;
load day_9_donors.dat
 
A=day_9_donors(:,:) ;

Da=A(1:6,:); %Cond 1 to 6 shared by donor 10 donors : D8-D17
Db=A(7:8,1:4); %Cond 7 & 8 shared by 4 donors 4 donors : D25-D28
Dc=A(9:end,1:3); %Cond b4', b7', b10' & b11'shared by 3 donors : D32-D34


w1=0.9
w2=.1
q1=1.0
%Weight calculation for donors in group-A
for i=1:6
temp_row=Da(i,:)

m=q1*median(temp_row)
diff=(temp_row-m)
abs_diff=abs(diff)
MAD=median(abs_diff)

W=temp_row/MAD
norm_WA=W/sum(W)
sum(norm_WA)
Da


YA(i)=sum(temp_row.*norm_WA)
end
YA

 temp_row=[]

%Weight calculation for donors in group-B
for i=1:2
temp_row=Db(i,:)

m=q1*median(temp_row)
diff=(temp_row-m)
abs_diff=abs(diff)
MAD=median(abs_diff)

W=temp_row/MAD
norm_WB=(1./W)/sum(1./W)
sum(norm_WB)
Db


YB(i)=sum(temp_row.*norm_WB)
end
YB

 temp_row=[]

%Weight calculation for donors in group-C
for i=1:3
temp_row=Dc(i,:)

m=q1*median(temp_row)
diff=(temp_row-m)
abs_diff=abs(diff)
MAD=median(abs_diff)

W=temp_row/MAD
norm_WC=W/sum(W)
sum(norm_WC)
Dc


YC(i)=sum(temp_row.*norm_WC)
end
YC

 temp_row=[]







WW=vertcat(norm_WA',norm_WB', norm_WC')
Y=vertcat(YA',YB',YC')

end 
