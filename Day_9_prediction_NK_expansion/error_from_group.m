function [err,error,B]=error_from_group(X,mean_Y,lambda,ya,min,max)

l=size(X,2);
B=(inv((X'*X)+(lambda*eye(l,l))))*(X'*mean_Y) ; %all beta
    y_pred=X*B
    error=sum((mean_Y-y_pred).^2);
    yhat=y_pred(min:max);
    compare=[mean_Y,y_pred];
    err=sum((ya-yhat).^2);
    compare_vec=[ya,yhat];

end