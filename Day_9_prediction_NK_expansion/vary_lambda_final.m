%28th February : Include lambda=0
%donors and day 9
clear all;
load day_9_donors.dat
 
 A=day_9_donors(:,:) ;
% 
% 
% A(:,7)=[]
% Da=A(1:6,:)
% Db=A(7:8,1:4)
% Dc=A(9:end,1:3)
% mean_A=mean(Da,2)
% mean_B=mean(Db,2)
% mean_C=mean(Dc,2)
% 
% Y=vertcat(mean_A,mean_B,mean_C)
% 
% % %  


 [Y,YY]=day9_dataload(A);
 
 
% 
%   Y %%standard mean
% % YY ;%weighted mean
%   Y=YY
n=0;
Y=[12.57888889
;9.845;
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

p=0;
m=0;
n=0;
lambda=[1e-11,1e-5,1e-3,0.2,0.4,0.6,0.8,0.82,0.85,0.9,0.95,1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1,2.2,2.3,2.4,2.5,3.0,3.2,3.3,3.5,4.5,5.5,10:30];
% map=1:64;
 map=[18,32,42,44,58,60]
%   map=32

for k=1:length(map) %loop of feasible map starts   
    fprintf('********************  MAP=%d  *****************************\n',map(k));
    [X]=map_model(map(k))
    
    rank(X)
    
    
   
   

    
    for i=1:size(X,1) %each condition
        
        [X_test,X_train,Y_train,Y_test]=test_train_split(X,Y,i);
        
        
        for j=1:length(lambda)
            
            
            
            %ridge regression on the training set for each lambda
            [Y_hat,pred_error,R_sq,B]=test_error(X_test,Y_test,X_train,Y_train,lambda(j));
            Y_prediction(j)=Y_hat;
            Y_prediction_error(j)=pred_error;
            Q1(j,:)=[Y_prediction_error(j),lambda(j),i,map(k),Y_prediction(j)];
            
            
        end
        
        Q1;
        Q2=sortrows(Q1);
        
        Y_hat_final(i,:)=Q2(1,5);
        [Y(i),Q2(1,5),Q2(1,1),Q2(1,2),Q2(1,3),Q2(1,4)];
        Y(i);
        opt_lambda=Q2(1,2)
        n=n+1;
        res(n,:)=[map(k),i,opt_lambda];
       
        
    end %i loop ends: each condition ends
    RR=corrcoef(Y,Y_hat_final);%different maps
    RR_SQ=RR(1,2).^2;
    
    
    maperror(k)=RR_SQ;
    
    RSS(k)=sum((Y-Y_hat_final).^2);
  
figure(k)
set(gca,'FontSize',24) % Creates an axes and sets its FontSize to 18
    hold on;
    
    a=min(Y);
    b=max(Y);
    
    str = sprintf('map=%d\n R^2= %f\n SSR=%f\n',map(k),maperror(k),RSS(k));
    txt = {str};
    
    text(a,b-2.2,txt,'FontSize',20)
    hold on
    plot(Y,Y_hat_final,'r*',Y,Y,'b--','Linewidth',2,'MarkerSize',20);
    hold on;
    
 end %end of k loop : map ends 


 res
[map',maperror',RSS']
% 
% 
%Find the optimum model
% TEMP=sortrows(QQQ);
% opt_error=TEMP(1,1)
% opt_map=TEMP(1,2)
% opt_lambda=TEMP(1,3)
% [ERR]=best_model(opt_lambda,opt_map,Y);
% ERR
% 
