%19th february 2023

clear all;

 n = 10; p = 5;
 X = randn(n,p)
 B=[8,2,13,-0.2,1.7]'
 size(B)

 Y=X*B

lambda = 1e-03;
B1 = lasso(X,Y,'Lambda',lambda,'Intercept',false)
[B,B1]
[Y,X*B1]