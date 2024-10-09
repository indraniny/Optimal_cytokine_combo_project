function [error,B,y_pred]=regression_model(X,Y,lambda)

l=size(X,2);
B=(inv((X'*X)+(lambda*eye(l,l))))*(X'*Y)  %all beta
    y_pred=X*B;
    compare=[Y,y_pred]
    error=sum((Y-y_pred).^2);

end