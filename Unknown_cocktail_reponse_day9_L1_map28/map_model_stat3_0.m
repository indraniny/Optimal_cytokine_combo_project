function [X]=map_model_stat3_0(g)


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
beta7=[0    0   1   0   1];
beta10=[0   0   1   1   0];
beta11=[0   0   1   0   1];

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
X=X_pre+X_post;
XX=(X>0);
XX;


%creating a matrix to show presence of ILs for pretreatment and
%posttreatment
[X_pre,X_post]=X_pre_post;

%creating a matrix B where presence of each IL activates multiple STATs for 64 models
   [B_pre,info]=matrix(X_pre);


%   [B_pre,info]=matrix_secondary_stats(X_pre);


[B_post,info]=matrix(X_post);


% %create pre_treatment matrix for model number g
% fprintf('STAT1 STAT3 STAT4 STAT5 NFkb\n');
% fprintf('beta1 beta3 beta4 beta5 betab\n');
B1=B_pre(:,:,g);
G1=B_post(:,:,g);

B1_noS3=B1;
B1_noS3(:,2)=0;

G1_noS3=G1;
G1_noS3(:,2)=0;


%describes about the model index [l,n,m]=[IL2, IL21, IL18]


%create linear-pair wise matrix (size=5C2+5=15)
%fprintf("S1*S3 S1*S4 S1*S5 S1*Sb S3*S4 S3*S5 S3*Sb S4*S5 S4*Sb S5*Sb")
beta=linear_pair_wise_matrix(B1);
gamma=linear_pair_wise_matrix(G1);


% %Or Considering only pre-treatment - Model A
%       X_all=B1;
%      X_all=G1;
%         X_all=cat(2,B1,G1);

%mutiplying pre and post_treatment matrix with 25 crossterms- Model B
%  [X_all,in]=multiply_post_pre(gamma,beta);
% [X_all,in]=multiply_post_pre(B1,G1);

B1_noS3
G1_noS3
[X_all,in]=multiply_post_pre(B1_noS3,G1_noS3);


% %Or Considering only pre-treatment -Model C
%       X_all=beta;

%Or Considering only post-treatment -Model D
%  X_all=gamma;

% %Or Considering pre-treatment + post treatment additive effect - Model E
%   X_all=cat(2,beta,gamma);

X=X_all;
end


