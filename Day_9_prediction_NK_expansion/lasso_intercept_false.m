clear all;

X=rand(100,1);
y=+2*X+randn(100,1)/10;


lambda=1e-3;
% B1=lasso(X,y,"Lambda",lambda,"Intercept",true)
B2=lasso(X,y,"Lambda",lambda,"Intercept",false)
plot(y,y,'b--',y,B2*X,'ro')
