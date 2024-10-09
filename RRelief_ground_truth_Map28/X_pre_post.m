function [X_pre,X_post]=X_pre_post
%Creating the matrix to tell presence of ILs in each of 12 conditions

% Y={'IL2','IL12','IL15','IL18','IL21'}

%pretreatment_presence of ILs
cond1=[1   0    0   0   0];
cond2=[0    1   1   1   0];
cond3=[0    1   1   1   1];
cond4=[1    0   1   0   1];
cond5=[1    0   1   0   0];
cond6=[1    0   1   0   0];
cond7=cond2;
cond8=cond3;
beta4=[0    0   1   0   1];
beta7=beta4;
beta10=[0   0   1   1   0];
beta11=beta4;

%pretreatment_presence of ILs
X_pre=[cond1;cond2;cond3;cond4;cond5;cond6;cond7;cond8;beta4;beta7;beta10;beta11];

% Y={'IL2','IL12','IL15','IL18','IL21'}
c1=[1   0    0   0   0];
c2=[1   0    0   0   0];
c3=[1   0    0   0   0];
c4=[1   0    1   0   1];
c5=[1   0    1   0   0];
c6=[1   0   1   0   0];
c7=[1   0   0   1   0];
c8=c7;
b4=[1    0   0   0   0];
b7=[0    0   1   0   1];
b10=[1   0   0   1   0];
b11=[1   0   0   1   0];

%posttreatment_presence of ILs
X_post=[c1;c2;c3;c4;c5;c6;c7;c8;b4;b7;b10;b11];

%combined pre and post treatment
%X=X_pre+X_post;


%creating a matrix where presence of IL is put to be 1
X_pre=(X_pre>0);
X_post=(X_post>0);
end