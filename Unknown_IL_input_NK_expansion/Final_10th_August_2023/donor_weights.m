function [xyz,u,v,w,ratio]=donor_weights(Da,Db,Dc)

Da;
Db;
Dc;
U=var(Da,0,1); %group A : 6 conditions : variance for 10 donors 
V=var(Db,0,1); %group B : 2 conditions : variance for 4 donors
W=var(Dc,0,1); %group C : 4 conditions : variance for 3 donors

variance_donors =[U,V,W]' ;%17 donors variance

index=1:17;
[index,donor_index]=sort(variance_donors,'ascend');


sorted_var=sort(variance_donors); %varinace of  17 donors in ascending order

L_pop=sorted_var(1:8); %left side of IQR
R_pop=sorted_var(10:end); %Right side of IQR

IQRLB=median(L_pop); %median of left side of IQR :1.53
IQRRB=median(R_pop); %median of right side of IQR : 57.5

IQR=vertcat(L_pop(5:8),sorted_var(9),R_pop(1:4)); %variances inside IQR
OIQR=vertcat(L_pop(1:4),R_pop(5:end)); %Variances outside IQR



w1=0.9; %weight of median
w2=0.1; %weight of mean
median(variance_donors); %17 donors
mean(variance_donors);%17 donors
medme=(w1*(median(variance_donors)))+((w2*mean(variance_donors))); %meadme calculated from 17 donors

dev_OIQR=(OIQR-medme).^2 ; %actual deviance : Outside IQR
dev_IQR=(IQR-medme).^2; %actual deviance : Inside IQR
dev_IQR=mean(dev_IQR)+zeros(9,1) ;%inside IQR mean of deviances


inv_devIQR=1./dev_IQR ;%inverse of deviances inside IQR

inv_devOIQR=1./dev_OIQR; %inverse of deviances outside IQR

weights_IQR=inv_devIQR/(sum(inv_devOIQR)+sum(inv_devIQR)); %normalization
weights_OIQR=inv_devOIQR/(sum(inv_devOIQR)+sum(inv_devIQR));

weights=vertcat(weights_OIQR,weights_IQR); %all weights of 17 donors 

donor_order=vertcat(donor_index(1:4),donor_index(14:end),donor_index(5:13));

temp=[donor_order,weights];
sort_temp = sortrows(temp);


sum(weights_OIQR)+sum(weights_IQR);

xyz=sort_temp(:,2);
format short;
sum(xyz);

[variance_donors,xyz]

%%Weight Calculation on medme in deviance, however we are not giving smaller weights for donors with smaller deviance 
% w1=0.9;
% w2=0.1;
% 
% mean_var=(w1*(median(variance_donors)))+((w2*mean(variance_donors)))
% devU=(U-mean_var).^2
% devV=(V-mean_var).^2
% devW=(W-mean_var).^2
% 
% deviance=[devU,devV,devW]'
% 
% inv_deviance=1./deviance
% xyz=inv_deviance/sum(inv_deviance)
% format short
% sum(xyz)


sum_var=sum(U)+sum(V)+sum(W);

u=(U)/sum_var;
v=(V)/sum_var;
w=(W)/sum_var;
ratio=[u,v,w]';
Q=[variance_donors,ratio];

sum(ratio)

end
