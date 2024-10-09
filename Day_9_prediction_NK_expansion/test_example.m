%15th February
% Load the data
load carbig
% A=carbig(:,:)
x = Weight;
y = MPG;

% Fit the model
mdl = fitlm(x, y)

% Plot the model
plot(x, y, '.', 'MarkerSize', 10)
hold on
plot(mdl)
xlabel('Weight')
ylabel('MPG')
legend('Data', 'Linear Regression', 'Location', 'Northwest')