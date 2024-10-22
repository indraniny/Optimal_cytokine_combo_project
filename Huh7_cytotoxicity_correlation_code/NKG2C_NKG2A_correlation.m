% Load the data
load absolute_MFI_cyto_receptor.dat

% Extract receptor expressions
A = absolute_MFI_cyto_receptor(:,:);
NKG2C = A(:,11);
NKG2A = A(:,12);

% Calculate the correlation between NKG2A and NKG2C
correlation = corr(NKG2A, NKG2C);
disp(['Correlation between NKG2A and NKG2C: ', num2str(correlation)]);

% Create a scatter plot
figure;
scatter(NKG2A, NKG2C, 'filled');
xlabel('NKG2A Expression');
ylabel('NKG2C Expression');
title('Scatter Plot of NKG2A vs. NKG2C');
grid on;

% Optionally, add a trend line
hold on;
p = polyfit(NKG2A, NKG2C, 1); % Linear fit
yfit = polyval(p, NKG2A);
plot(NKG2A, yfit, '-r', 'LineWidth', 1.5); % Plot trend line
hold off;