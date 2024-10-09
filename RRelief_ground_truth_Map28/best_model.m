function [ERR]=best_model(lambda,map,Y)


p=0;
    
    [X]=map_model(map) ;
    for i=1:size(X,1) %each condition
        
        [X_test,X_train,Y_train,Y_test]=test_train_split(X,Y,i);
        
        %ridge regression on the training set
        [Y_hat,pred_error,R_sq,B]=test_error(X_test,Y_test,X_train,Y_train,lambda);
        Y_prediction(i)=Y_hat;
        Y_prediction_error(i)=pred_error;
        beta_25(i,:)=B;
        
        %writing to a file
        p=p+1;
        Errors(p,:)=[i,map, lambda,Y_test,Y_hat,R_sq];

%         fprintf("Nonzero_element=%d",nnz(B))
        
    end %i loop ends: each condition ends

    
    
    %R^2 calculation
    RR=corrcoef(Y,Y_prediction');%different maps
    RR_SQ=RR(1,2).^2;
    
    writematrix(Errors,'best_Typical response_p_5_22_meadmeIQR.txt','Delimiter','tab');
    [Y,Y_prediction',Y_prediction_error']
    
    ERR=sum(Y_prediction_error);
    %plot to see the prediction for each map
    plot_Rsq(Y,Y_prediction,lambda,RR_SQ,map,ERR)

    Y_truth_vs_prediction = [Y,Y_prediction']

    beta_25'
end