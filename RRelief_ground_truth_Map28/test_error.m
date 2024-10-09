%written on 3rd March 2023
function [Y_hat,pred_error,R_sq,B]=test_error(X_test,Y_test,X_train,Y_train,lambda)

l=size(X_train,2);

%Ridge
%  B=(inv((X_train'*X_train)+(lambda*eye(l,l))))*(X_train'*Y_train) ; %all beta

 %lasso
B = lasso(X_train,Y_train,'Lambda',lambda,'Intercept',false)

  %EN
% B = lasso(X_train,Y_train,'Lambda',lambda,'Alpha',0.5,'Intercept',false)  ;                     
    
%How bad is the fit
    Y_fit=X_train*B;
    r=corrcoef(Y_train,Y_fit);
    R_sq=r(1,2).^2;
    [Y_train,Y_fit];
%     
%     
%     %plot to see the fit
%     figure()
%     set(gca,'FontSize',24) % Creates an axes and sets its FontSize to 18
%     hold on;
%     
%     a=min(Y_train)
%     b=max(Y_train)
%       
%     str = sprintf('lambda=%f\n R^2= %f\n',lambda,R_sq);
%     txt = {str};
%     
%     text(a,b-1,txt,'FontSize',20)
%     hold on
%     plot(Y_train,Y_fit,'r*',Y_train,Y_train,'b--','Linewidth',2,'MarkerSize',20);
%  
    
%pediction error    
    Y_hat=X_test*B;
    B;
    pred_error=(Y_hat-Y_test).^2;
%     pred_error=sum((Y_train-Y_fit).^2)
    compare_Y=[Y_test,Y_hat];
    

end