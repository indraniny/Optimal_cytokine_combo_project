function modelscan_relief_pre_post_10_stats_9th_Aug_23(Y,opt_map)
%clear all

%7th Novemeber - Finding model for cell proliferation day 9
%3rd October for Receptor
%18th September - Relief Pre and Post separate
%16th September - Checking the code, added some comments, included beta4'
%18th August -automate that only show which are either m=2 or l=3,
%variable k


%18th August -automate that only show which are either m=2 or l=3,
%6,9,10,12,13,14,16 for a fixed k

%16th August

%12th August - Create that model where IL-2 can activate all the stats in
%all the combinations



%This code is written on 12th August
%Model 3,4 and 5,6,7,8 were same, so fixed that model 3, IL18 only can
%activate S3
%added the idea Z(i,1)=z(i,1)+0.0
%also added the part that after printing all matrix assigns to zero matrix
%=Z+T, otherwise in the next loop 1 will stay as 1,and we need to make it
%zero



%16th September
%how many stats are getting activated
% load day16.dat
% Y=day16(:,1);
% % % 
% load NKp44_D10.dat
% Y=NKp44_D10(:,1);% 

% load NKp46_D10.dat
% Y=NKp46_D10(:,1);
% 
% load NKG2C_D10.dat
% Y=NKG2C_D10(:,1);
% % 
% load NKG2A_D10.dat
% Y=NKG2A_D10(:,1);
% % 
%  load CD16_D10.dat
%  Y=CD16_D10(:,1);%  

% load NKG2D_D10.dat
% Y=NKG2D_D10(:,1);
% 
% load NKp30_D10.dat
% Y=NKp30_D10(:,1);

% % 
% load day9.dat
% Y=day9(:,1);

 %Y=[11.9406,13.6280,20.5478,11.8515,8.6763,13.3492,7.3077,8.8032,14.6143,17.5523,11.9617,14.0261]';

% [Y,YM]
% Y-YM

disp('This the new Y to be used in the R-Relief')
Y
%cytokine matrix for pre and post-treatment
[X_pre,X_post,X]=cytokine_matrix;


%STATs for pre and post-treatment for 64 maps
[B_pre,s,info]=STAT_presence(X_pre);
[B_post,s,info]=STAT_presence(X_post);


% s %65 sum over all the maps(s=s+1)

B=cat(2,B_pre,B_post); %64 maps with each row [S1 S3 S4 S5 Sb s1 s3 S4 S5 Sb]


%64 Maps are ready now apply RRelief 
%verification for Map 27
B_pre(:,:,27);
B_post(:,:,27);
CCC=B(:,:,12)
info(27,:);
info;
%12=(3,2,2)

info(28,:)
CCC=B(:,:,28)

CC1=B(:,:,5)

size(X,1) %12
size(X,1)-1 %10

du=0
oset=[0,0];% initilizating the number of maps
l=1;
d=1;
%This is the index for k nearest neighborhood in RRelief 2,10
 for k=2:1:(size(X,1)-1)
% for k=6
    
    
    q=0; %If the certain STAT scores are positive, q will increase
    p=1; %If the certain STAT scores are positive, in WW(p) matrix will increase


    for i=1:s-1 %loop over the 64 maps to apply RRelief
%       for i=60

        XA=B(:,:,i); %each map from 64 maps
        info(i,:);
        
        [idx,weights] = relieff(XA,Y,k); %relief score 
        
        %when STAT3 and NFkb are positive 
%        
      if (weights(2) > 0.0) && (weights(5)> 0.0) && (weights(7) > 0.0) && (weights(10)> 0.0)  %NKp44, NKp30, day 9
%         
      %if ((weights(5)> 0.0) && (weights(7) > 0.0) && (weights(10)> 0.0))  %NKp44, NKp30
%              
      %if ((weights(5) > 0.0) && (weights(10) > 0.0))  % NKG2C, NKG2A,%NKG2D,NKp46, CD16
%      
%             %IL18 activates STAT3 
            if (info(i,3)==2) %second condition cond 2 should express STAT3
                
                WW(p,:)=[weights,k,i]; %k nearest neighbor in RRelief, ith map
                %m;
                i;
                info(i,:);
                q=q+1; 
                p=p+1;%to update relief scores for each map i an each nearest neighbor k
                du=i;% which map supports the inhibition experiment

                fprintf('k=%i, Map_no=%i, l=%i, n=%i, m=%i \n',k,i,info(i,1),info(i,2),info(i,3))
            
            
            %IL2 activates STAT3    
            elseif ((info(i,1)==3))
                WW(p,:)=[weights,k,i];
                q=q+1; 
                p=p+1;
                du=i;
                fprintf('k=%i, Model_no=%i, l=%i, n=%i, m=%i \n',k,i,info(i,1),info(i,2),info(i,3))
            
            %IL2 activates STAT3   
            elseif ((info(i,1)==6) || (info(i,1)==9) || (info(i,1)==10))
                WW(p,:)=[weights,k,i];
                q=q+1; 
                p=p+1;
                du=i;
                fprintf('k=%i, Model_no=%i, l=%i, n=%i, m=%i \n',k,i,info(i,1),info(i,2),info(i,3))
            
            %IL2 activates STAT3   
            elseif ((info(i,1)==12) || (info(i,1)==13) || (info(i,1)==14))
                WW(p,:)=[weights,k,i];
                q=q+1; 
                p=p+1;
                du=i ;
                fprintf('k=%i, Model_no=%i, l=%i, n=%i, m=%i \n',k,i,info(i,1),info(i,2),info(i,3))
            
            %IL2 activates STAT3   
            elseif (info(i,1)==16)
                WW(p,:)=[weights,k,i];
                q=q+1; 
                p=p+1;
                du=i;

                fprintf('k=%i, Model_no=%i, l=%i, n=%i, m=%i \n',k,i,info(i,1),info(i,2),info(i,3))
                
            
%              WWW(i,:)=[weights,(k/10),(i/100)];
%              fprintf('k=%i, Model_no=%i, l=%i, n=%i, m=%i \n',k,i,info(i,1),info(i,2),info(i,3)) 
%             
%    
            end
            %WWW(i,:)=weights;
%           WWW(i,:)=[weights,(k/10),(i/100)];
%           fprintf('k=%i, Model_no=%i, l=%i, n=%i, m=%i \n',k,i,info(i,1),info(i,2),info(i,3))
              du;
            if(du > 0) % if both inhibition condition satisfy
             all_weights(l,:)=[weights,k,i];
             l=l+1;
             nset=[0,du];
             set=union(nset,oset);
             oset=set;
%              
            end
           
        
        end %end of if else loop inhibition experiment
           
            

         
    end %end of i loop
        

        
 

    
%      WW(WW<=0) = nan;
%      heatmap(WW,'Colormap',summer,'XData', ["STAT1" "STAT3" "STAT4" "STAT5" "NFkb" "S1" "S3" "S4" "S5" "Sb" "k*10" "Model number*100"])
% %    
    q ;%available subset from 64 models
    if(q>0)
        fprintf('Model exists for k=%i\n',k)
        WW;
         WW(WW<=0) = nan;
        
         
        % WW(isnan(WW))=0;
        
%         heatmap(WW,'Colormap',summer,'XData', ["STAT1" "STAT3" "STAT4" "STAT5" "NFkb" "S1" "S3" "S4" "S5" "Sb" "K" "Model"])
        
        
    elseif(q==0)
        fprintf('skip the k=%i\n',k)
         
    end   %end of q>0 

%Y;

       
% %which map represent the activation of STAT
% for i=1:s-1
%     value(i,:)=[i,info(i,:)]; %which index denotes which l, m, n
% end

% C=B(:,:,25);
% [idx,weights]= relieff(C,Y,k);
 
% oset
% WW;
%  all_weights
%  pre_Sb_weights=all_weights(:,5);
%  post_Sb_weights=all_weights(:,10);
%  mean_pre_Sb_weights=mean(pre_Sb_weights)
%  mean_post_Sb_weights=mean(post_Sb_weights)
%  figure(2)
%  histogram(pre_Sb_weights,10)
%  figure(3)
%  histogram(post_Sb_weights,10)
end %This is the end index for k nearest neighbor
oset

fprintf("Optimal_Map=%i",opt_map)
B(:,:,opt_map)

