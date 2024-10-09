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

[opt_map,opt_lambda,Y,B1]= optimum_map_model_10th_Aug_2023(Y);

Y

% Construct X inclusing all the conditions
[X_12]=map_model(opt_map) ; 
 %lasso
Beta_all = lasso(X_12,Y,'Lambda',opt_lambda,'Intercept',false) %calculate beta for all the 12 conditions

disp("pre x post regression mode X :")
X_12;
%Now write the ground truth model here
Y_Relief=X_12*Beta_all



modelscan_relief_pre_post_10_stats_9th_Aug_23(Y_Relief,opt_map)




