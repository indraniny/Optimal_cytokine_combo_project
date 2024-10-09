%9th March - Train_t=validation_test 
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
 
 Y
% % 
% %   Y %%standard mean
% % % YY ;%weighted mean
%   Y=YY
%   
%   [WW,Y]=Attempt0_weight_assign(A);
% 
% Y
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

p=0;
m=0;
% map=1:64;
  map=[18,32,42,44,58,60]
%    map=18
    lambda=[1e-11,1e-5,1e-3,0.2,0.4,0.6,0.8,0.82,0.85,0.9,0.95,1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1,2.2,2.3,2.4,2.5,3.0,3.2,3.3,3.5,4.5,5.5,10];
   

    

for k=1:length(map) %loop of feasible map starts   
    fprintf('********************  MAP=%d  *****************************\n',map(k));
    [X]=map_model(map(k))
    
    rank(X)
    
% %     [Mu,ia,ic] = unique(X, 'rows', 'stable');           % Unique Values By Row, Retaining Original Order
% %     h = accumarray(ic, 1);                              % Count Occurrences
% %     maph = h(ic);                                       % Map Occurrences To ?ic? Values
% %     Result = [X, maph]
% %     
  
    for i=1:size(X,1) %each condition
        
        [X_test,X_temp,Y_temp,Y_test]=test_train_split(X,Y,i);
        
            for j=1:length(lambda)
                %training +validation set
                for s=1:(size(X,1)-1) %11
                    [X_validation,X_train,Y_train,Y_validation]=test_train_split(X_temp,Y_temp,s);
                    %ridge regression on the training set
                    [Y_hat,pred_error,R_sq,B]=test_error(X_validation,Y_validation,X_train,Y_train,lambda(j));
                    Y_prediction(s)=Y_hat;
                    Y_prediction_error(s)=pred_error;
                end
                info(j,:)=[sum(Y_prediction_error),i,map,lambda(j)]; %for a lambda
                
            end %end of lambda
                  info;
                sort_info=sortrows(info);
                opt_lambda=sort_info(1,4);
                
                [Y_hat_p(i),pred_error,R_sq,B]=test_error(X_test,Y_test,X_temp,Y_temp,opt_lambda)
                compare(i,:)=[Y_test,Y_hat_p(i)]
      
    end  %end of each condition
    compare
     Err=sum((Y-compare(:,2)).^2);
    %     R^2 calculation
    RR=corrcoef(Y,Y_hat_p);%different maps
    RR_SQ=RR(1,2).^2;
    
    
    %plot to see the fit
        figure()
        set(gca,'FontSize',24) % Creates an axes and sets its FontSize to 18
        hold on;
        
        a=min(Y)
        b=max(Y)
        
        str = sprintf('map=%d\n R^2= %f\n,RSS=%f\n',map(k),RR_SQ,Err);
        txt = {str};
        
        text(a,b-2,txt,'FontSize',20)
        hold on
         plot(Y,Y_hat_p,'c*',Y,Y,'b--','Linewidth',2,'MarkerSize',20);
        
    

    
    dummy(k,:)=[map(k),Err,RR_SQ];
end
    dummy      