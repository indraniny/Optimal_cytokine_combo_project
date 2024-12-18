%Fit check on the full data : 10th March 

clear all;
load day_9_donors.dat

A=day_9_donors(:,:) ;

%  [Y,YY]=day9_dataload(A);
% %  Y=YY
% 
Y=[12.57888889;9.845;
13.46083333;
10.85444444;
8.771111111;
11.75333333;
8.97;
10.425;
9.133333333;
16.4;
11.5;
15.4]

% [WW,Y]=Attempt0_weight_assign(A);

%  map=[18,32,42,44,58,60]
% lambda=[1e-11,1e-5,1e-3,0.20,1,1.5,2,2.5,3.0,5.5,10];
map=60
p=0;
 lambda=1e-11;
for j=1:length(lambda)
    
    for k=1:length(map) %loop of feasible map starts
        fprintf('********************  MAP=%d  *****************************\n',map(k));
        [X]=map_model(map(k))

        
%         
%         q=2
%         X_temp=X(q,:)
%         X(q,:)=[];
%         Y_temp=Y(q)
%         Y(q)=[]
%         
        rank(X)
        
        l=size(X,2)
        
        
        
        %Ridge
%         B=(inv((X'*X)+(lambda(j)*eye(l,l))))*(X'*Y)  %all beta
        
        %lasso
        B = lasso(X,Y,'Lambda',lambda,'Intercept',false)
        
        
        
        %How bad is the fit
        Y_fit=X*B;
        r=corrcoef(Y,Y_fit);
        R_sq=r(1,2).^2;
        
%         Y_hat=X_temp*B
%         [Y_temp,Y_hat]
        
        RSS=sum((Y-Y_fit).^2);
        p=p+1;
        M(p,:)=[R_sq,RSS];


        %check condition 2, 3 with STAT3 inhibitor
      

        
        %plot to see the fit
        figure()
        set(gca,'FontSize',24) % Creates an axes and sets its FontSize to 18
        hold on;
        
        a=min(Y)
        b=max(Y)
        
        str = sprintf('Lasso\n map=%d\nlambda=%f\n R^2= %f\n RSS=%f\n',map(k),lambda,R_sq,RSS);
        txt = {str};
        
        text(a,b-2,txt,'FontSize',20)
        hold on
         plot(Y,Y_fit,'b*',Y,Y,'b--','Linewidth',2,'MarkerSize',20);
        
        
        
        
    end
    M;
end
Y;

%  [Y_temp,Y_hat]
%         
   [I]=map_model_stat3_0(map)
        cond2=I(2,:)
        cond3=I(3,:)  
cond2_noS3=cond2*B
cond3_noS3=cond3*B
% [Y,Y_fit]
% X-I
[Y,X*B]