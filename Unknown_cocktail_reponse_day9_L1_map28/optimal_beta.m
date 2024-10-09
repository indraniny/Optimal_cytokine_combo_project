%donors and day 9
%4th August, checking for Map 60 and model =(prex post) with generating
%synthetic inputs of X, if any condition has higher output than condion
clear all;

function [Beta_all]=optimal_beta(opt_lambda,opt_map,Y)


[X]=map_model(opt_map) ;


 %lasso
Beta_all = lasso(X,Y,'Lambda',opt_lambda,'Intercept',false)









end 
