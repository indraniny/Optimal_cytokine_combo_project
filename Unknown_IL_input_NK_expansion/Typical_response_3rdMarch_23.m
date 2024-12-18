%10th August 2023 -> Pareto front analysis
%28th February : Include lambda=0
%donors and day 9
%4th August, checking for Map 60 and model =(prex post) with generating
%synthetic inputs of X, if any condition has higher output than condion
clear all;
load day_9_donors.dat
 
 A=day_9_donors(:,:) ; %excluding D32-34
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

%Type-1a
%  [Y,YY]=day9_dataload(A);
%   Y %%standard mean

%%Type -1b
%  [Y,YY]=day9_dataload(A);
% YY ;%weighted mean
% Y=YY

%%Type 2 [putting weights to all donor, removing D32,D33,D34 in cond2 cond3]
  [WW,Y]=Attempt0_weight_assign(A); %BEst Lasso - (1/Deviance)/sum(1/dev)

  
%% Type 3a %removing D14 standard mean (including D32-34 in condition 2,3)
% Y=[12.57888889;
%     9.845;
% 13.46083333;
% 10.85444444;
% 8.771111111;
% 11.75333333;
% 8.97;
% 10.425;
% 9.133333333;
% 16.4;
% 11.5;
% 15.4]

% %% Type 3B %removing D14 standard mean (removing D32-34 in condition
% 2,3): Worse R^2=0.43, Worse SSR=243
% Y=[12.57888889;
%     9.193;
% 11.914;
% 10.85444444;
% 8.771111111;
% 11.75333333;
% 8.97;
% 10.425;
% 9.133333333;
% 16.4;
% 11.5;
% 15.4]

%%Type-4
% [YY]=constant_donor_weights;
% Y=YY;

p=0;
m=0;
% map=1:64;
  % map=[18,32,42,44,58,60]
  map=[8,14,16,28,42,44]
%    map=60
nn=1;
for k=1:length(map) %loop of feasible map starts   
    fprintf('********************  MAP=%d  *****************************\n',map(k));
    [X]=map_model(map(k)) %matrix of STATs for all ILs
    
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
ERR
% 
X;

Y
B1;

opt_map %optimal map 28
opt_lambda % lambda= 1E-11
Y



% Construct X inclusing all the conditions
[X_12]=map_model(opt_map) ; 
 %lasso
Beta_all = lasso(X_12,Y,'Lambda',opt_lambda,'Intercept',false) %calculate beta for all the 12 conditions


%creating a matrix to show presence of ILs for pretreatment and
%post-treatment
[X_pre_syn,X_post_syn,X_bigg]=synthetic_cytokine_input;  

%creating a matrix B where presence of each IL activates multiple STATs for 64 models
%[B_pre_syn,info]=matrix(X_pre_syn);% linear STATs 5 terms
%[B_post_syn,info]=matrix(X_post_syn);% linear STATs 5 terms
size(X_pre_syn)

%some checks on multiplication
X_pre_syn(46,:)
X_post_syn(46,:)
multiply_post_pre(X_pre_syn(46,:),X_post_syn(46,:))

%creating all the synthetic conditions
for i=1:1024
[D(i,:),in]=multiply_post_pre(X_pre_syn(i,:),X_post_syn(i,:)); %in is the index here
output(i)=D(i,:)*Beta_all;
fold_change_prediction(i,:)=[output(i),X_pre_syn(i,:),X_post_syn(i,:)];
end
Ans=sortrows(fold_change_prediction,'descend');
Ans(1:5,:)


%Predictions for 12 conditions
X_12
Beta_all
Y_validate=X_12*Beta_all
comparison=[Y,Y_prediction',Y_validate]
data=[Y;Y_prediction'; Y_validate]

% for i=1:12
%  x_label(i)='cond '+'i'
% end
figure()
bar(data')