%10th August 2023 -> Pareto front analysis -> 
%[If we 
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

%--------------------------------Using Optimal map and model find Beta and
%then find reponse for 1024 cytokine unknown inputs

[opt_map,opt_lambda,Y,B1]= optimum_map_model_10th_Aug_2023(Y)

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
for i=1:size(X_pre_syn,1)
[D(i,:),in]=multiply_post_pre(X_pre_syn(i,:),X_post_syn(i,:));
output(i)=D(i,:)*Beta_all;
fold_change_prediction(i,:)=[output(i),X_pre_syn(i,:),X_post_syn(i,:)];
end
Ans=sortrows(fold_change_prediction,'descend');
best_cocktails=Ans(1:5,:)

figure(3)

%plotting heatmap% Separate response vector and feature variables
response_vector = best_cocktails(:, 1);
feature_variables = best_cocktails(:, 2:end);

% Create custom color maps for response vector and feature variables
cmap_response = colormap("parula");
cmap_features = colormap('spring');

xvalues = {'FC','Pre-IL2', 'Pre-IL12', 'Pre-IL15', 'Pre-IL18', 'Pre-IL21', 'Post-IL2', 'Post-IL12', 'Post-IL15', 'Post-IL18', 'Post-IL21'};
yvalues = {'1','2','3','4','5'};


% Create the heatmap
figure;
colormap([cmap_response; cmap_features]);
heatmap_data = [response_vector, feature_variables];
heatmap(xvalues,yvalues,heatmap_data);
caxis([min(response_vector), max(response_vector)]); % Set colormap limits
xlabel('Cytokines');
ylabel('Unknown cocktail');


Y