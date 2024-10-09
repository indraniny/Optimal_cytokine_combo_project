function [X_pre_syn,X_post_syn,X_bigg]=synthetic_cytokine_input
%Creating the matrix to tell presence of ILs in each of 12 conditions

% Y={'IL2','IL12','IL15','IL18','IL21'}

%pretreatment_presence of ILs
N = 10;
A=dec2bin(0:2^N-1)' - '0';
X_bigg=A' %1024 cytokine combinations are possible 

X_pre_syn=X_bigg(:,1:5); %first 5 cytokines in pretreatment
X_post_syn=X_bigg(:,6:10); %last 5 cytokines in posttreatment
 

%creating a matrix where presence of IL is put to be 1
X_pre_syn=(X_pre_syn>0);
X_post_syn=(X_post_syn>0);
end