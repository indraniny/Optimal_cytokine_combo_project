%Sept 18 2024 _> This code gives FC predictions for all possible unknown
%input of cytokine + for a given cytokine combo : This are studies with
%best predictive map (28) , model (pre x post) and lambda (1e-11)

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
  map=28
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
lambda=1e-11;
%lambda=[1e-11,1e-5,1e-3,0.2,0.4,0.5,0.6,1,2,3,10]

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
[X_pre_syn,X_post_syn,X_bigg]=synthetic_cytokine_input;  %This are ILs

%creating a matrix B where presence of each IL activates multiple STATs for 64 models
[B_pre_syn,info]=matrix(X_pre_syn);% linear STATs 5 terms
[B_post_syn,info]=matrix(X_post_syn);% linear STATs 5 terms
size(X_pre_syn)

%some checks on multiplication
X_pre_syn(46,:)
X_post_syn(46,:)

disp('size of priming and post priming cytokine / IL matrix')
size(X_pre_syn)
size(X_post_syn)


disp('size of priming and post priming STAT+NF-kB matrix')
size(B_pre_syn(:,:,opt_map))
size(B_post_syn(:,:,opt_map))

B11=B_pre_syn(:,:,opt_map);%linear STATs activated for optimal map during priming
G11=B_post_syn(:,:,opt_map);%linear STATs activate for optimal map during PP-I

disp('size of product of priming and post priming cytokine / IL matrix')
size(multiply_post_pre(X_pre_syn(46,:),X_post_syn(46,:)))

disp('size of priming and post priming STAT-NF-kB matrix')
size(multiply_post_pre(B11(1,:),G11(1,:)))



%creating all the synthetic conditions


for i=1:1024
[D(i,:),in]=multiply_post_pre(B11(i,:),G11(i,:)); %in is the index here
output(i)=D(i,:)*Beta_all;
fold_change_prediction(i,:)=[output(i),B11(i,:),G11(i,:)];%Stats
fold_change_prediction_IL(i,:)=[output(i),X_pre_syn(i,:),X_post_syn(i,:)];%ILs
end


Ans=sortrows(fold_change_prediction,'descend');
Ans_IL=sortrows(fold_change_prediction_IL,'descend');

disp('STAT-NFkB combo in priming and post-priming')

start_row=1
end_row=1024
Ans(start_row:end_row,:)

disp('IL combo in priming and post-priming')
Ans_IL(start_row:end_row,:)


% Extract response vector and feature variables
response_vector = Ans_IL(start_row:end_row, 1);
feature_variables = Ans_IL(start_row:end_row, 2:end);

% Filter the data where the response_vector is between 7.31 and 8
valid_indices = find(response_vector >= 18 & response_vector <= 21);

% Extract the filtered response vector and feature variables
response_vector_filtered = response_vector(valid_indices, :);
feature_variables_filtered = feature_variables(valid_indices, :);

% Dynamically create y-axis labels for the filtered data
num_rows_filtered = size(response_vector_filtered, 1);
yvalues_filtered = arrayfun(@(x) num2str(x), 1:num_rows_filtered, 'UniformOutput', false);

% Combine filtered response vector and feature variables for heatmap data
heatmap_data_filtered = [response_vector_filtered, feature_variables_filtered];

% Create the heatmap for the filtered data
figure;
xvalues = {'FC','Pre-IL2', 'Pre-IL12', 'Pre-IL15', 'Pre-IL18', 'Pre-IL21', 'Post-IL2', 'Post-IL12', 'Post-IL15', 'Post-IL18', 'Post-IL21'};
% Apply a colormap (choose one, e.g., 'parula', 'spring', etc.)
colormap(parula);  % Or use any other colormap like 'hot', 'jet', 'spring'

% Create the heatmap
heatmap(xvalues, yvalues_filtered, heatmap_data_filtered);

% Adjust colormap limits and labels
caxis([min(response_vector_filtered), max(response_vector_filtered)]); % Set colormap limits
xlabel('Cytokines');
ylabel('Unknown cocktail');

title('Heatmap for Response Vector Values Between 7.31 and 8');

figure;
histogram(response_vector,10)

%Predictions for 12 conditions
X_12
Beta_all
Y_validate=X_12*Beta_all
comparison=[Y,Y_prediction',Y_validate]



% Define the x-axis labels for conditions
numConditions = size(comparison, 1);
x_label = cell(1, numConditions);
for i = 1:numConditions
    x_label{i} = ['condition ', num2str(i)];
end

% Create the bar plot
figure;
bar(comparison);

% Set the x-axis tick labels
set(gca, 'XTickLabel', x_label);

% Add labels and title
xlabel('Conditions');
ylabel('Fold expansion');
%title('Bar Plot of Conditions with Three Measurements');
legend('True FC', 'Prediction FC - CV', 'Validation FC - 12 conds'); % Adjust the legend names as needed
%grid on; % Optional: add a grid for better readability

%prediction For a new condition ILs (Il2, 12, 15, 18, 21) in pre and post
new_cond=[ 0 1 1 1 1 1 0 0 0 0]
%new_cond=[0 0 1 0 0 0 0 1 0 0]

% Combine A and B to create C
C = [X_pre_syn, X_post_syn];  % C will be of size 5x8




[New_condition_output,row_indices]=predict_Fc_new_condtion(C,new_cond,Beta_all,B11,G11)

%STAT activation
new_cond_pre=B11(row_indices,:)
new_cond_post=G11(row_indices,:)