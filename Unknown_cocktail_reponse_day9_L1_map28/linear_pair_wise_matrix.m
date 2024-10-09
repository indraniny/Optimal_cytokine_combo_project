function beta=linear_pair_wise_matrix(B1)



count=1;
for p=1:size(B1,1)
    for i=1:size(B1,2)
        for j=(i+1):size(B1,2)
            beta(p,count)=B1(p,i)*B1(p,j);
            
            count=count+1;
        end
    end
    count=1;
end

beta=[B1,beta];


%m=0;



% 
% for p=1:size(B1,1)
%     if(sum(B1(p,:)) == 1)
%         fprintf(" The model does not work, Model has linear term : New Model with 15 terms \n");
%         %BB1(p,:)=[beta(p,:),B1(p,:)];
%         linear_part(p,:)=B1(p,:);
%         m=1;
%     
%     else
%         linear_part(p,:)=zeros(1,size(B1,2));
%     end
% 
% end



end