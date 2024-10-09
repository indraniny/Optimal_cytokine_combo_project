function [opt_map,opt_lambda,Y,B1]= optimum_map_model_10th_Aug_2023(Y)


p=0;
m=0;
% map=1:64;
  % map=[18,32,42,44,58,60]
  map=[8,14,16,28,42,44]
%    map=60
nn=1;
for k=1:length(map) %loop of feasible map starts   
    fprintf('********************  MAP=%d  *****************************\n',map(k));
    [X]=map_model(map(k))
    
    rank(X)
    
% %     [Mu,ia,ic] = unique(X, 'rows', 'stable');           % Unique Values By Row, Retaining Original Order
% %     h = accumarray(ic, 1);                              % Count Occurrences
% %     maph = h(ic);                                       % Map Occurrences To ?ic? Values
% %     Result = [X, maph]
   
% %     
% lambda=1e-11;
lambda=[1e-11,1e-5,1e-3,0.2,0.4,0.5,0.6,1,2,3,10]

%     lambda=[1e-11,1e-5,1e-3,0.2,0.4,0.6,0.8,0.82,0.85,0.9,0.95,1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1,2.2,2.3,2.4,2.5,3.0,3.2,3.3,3.5,4.5,5.5,10];
   for j=1:length(lambda)

    
    for i=1:size(X,1) %each condition
        
        [X_test,X_train,Y_train,Y_test]=test_train_split(X,Y,i);
        
%       LASSO regression on the training set
        [Y_hat,pred_error,R_sq,B]=test_error(X_test,Y_test,X_train,Y_train,lambda(j));
        B1(:,nn)=B;
        nn=nn+1;
        Y_prediction(i)=Y_hat;
        Y_prediction_error(i)=pred_error;
        
        
        
        
%       writing to a file
        p=p+1;
        Errors(p,:)=[i,map(k), lambda(j),Y_test,Y_hat,R_sq];
        
    end %i loop ends: each condition ends
    
   
%     R^2 calculation
    RR=corrcoef(Y,Y_prediction');%different maps
    RR_SQ=RR(1,2).^2;
    
    writematrix(Errors,'Typical response_p_5_22_meadmeIQR.txt','Delimiter','tab');
    [Y,Y_prediction',Y_prediction_error'] ;%for a particular lambda
    
    Y_prediction;
    
    maperror=sum(Y_prediction_error);
    m=m+1;
    QQQ(m,:)=[maperror,map(k),lambda(j)];
    
       
%     plot to see the prediction for each map
%     plot_Rsq(Y,Y_prediction,lambda,RR_SQ,map,ERR)

   end %end of lambda loop   
 end %end of k loop : map ends 
% 
% 
% % [map',maperror']
% 
% 
%Find the optimum model
TEMP=sortrows(QQQ);
opt_error=TEMP(1,1)
opt_map=TEMP(1,2)
opt_lambda=TEMP(1,3)
[ERR]=best_model(opt_lambda,opt_map,Y);
ERR;
% 
X;

Y;
B1;

opt_map %optimal map 28
opt_lambda % lambda= 1E-11
Y

end
