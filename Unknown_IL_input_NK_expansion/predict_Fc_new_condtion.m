function [New_condition_output,row_indices]=predict_Fc_new_condtion(C,new_cond,Beta_all,B11,G11)

% Check for the matching row
matching_rows = all(C == new_cond, 2);  % Compare each row of C with new_cond

% Get the indices of the matching rows
row_indices = find(matching_rows);

% Display the result
    if ~isempty(row_indices)
        disp('Matching row(s):');
        disp(row_indices);
    else
        disp('No matching row found.');
    end



[X_stat_input,in]=multiply_post_pre(B11(row_indices,:),G11(row_indices,:)); %in is the index here
New_condition_output=X_stat_input*Beta_all
end