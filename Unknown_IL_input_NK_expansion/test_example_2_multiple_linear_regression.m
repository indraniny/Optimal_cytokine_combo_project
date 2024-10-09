clear all;

x1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]';
x2 = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20]';
y = [14, 23, 25, 32, 36, 45, 46, 50, 60, 68]';

% Combine predictor variables into a table
tbl = table(x1, x2, y)

% Create the linear regression model
lm = fitlm(tbl, 'y ~ x1 + x2');

% Display the model summary
disp(lm)

% Make predictions
x1_new = [1, 2, 3, 4, 5]';
x2_new = [11, 12, 13, 14, 15]';
tbl_new = table(x1_new, x2_new);
y_pred = predict(lm, tbl_new);

% Display the predictions
disp('Predicted values:')
disp(y_pred)