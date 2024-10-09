function [X_test,X_train,Y_train,Y_test]=test_train_split(X,Y,i)
        Y_org=Y; %temporarily saved to X_org and Y_org
        X_org=X;
        
        %test dataset
        Y_test=Y_org(i); %leaving out the ith Donor
        X_test= X_org(i,:) ; %leaving out the ith Donor
        
        %training datset
        Y_org(i)=[];
        Y_train=Y_org;
        X_org(i,:)=[];
        X_train=X_org;
end