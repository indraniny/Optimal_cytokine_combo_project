function [D,in]=multiply_post_pre(gamma,beta)


for p=1:size(gamma,1)
    
    A=gamma(p,:);
    B=beta(p,:);
  r=1;
    for i=1:length(B)
        for j=1:length(A)
            D(p,r)=A(i)*B(j);
            in(r,:)=[i,j];
            r=r+1;
        end
    end
end

end