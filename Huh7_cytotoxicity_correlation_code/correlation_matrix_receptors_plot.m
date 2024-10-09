%3rd October 2023
%22nd August 2023
%Correlation matrix for receptor expressions with CD16 high population

clear all;
load absolute_MFI_cyto_receptor.dat

A=absolute_MFI_cyto_receptor(:,:)

% % %Receptor expressions at day 10
CD16=A(:,6);
NKp44=A(:,7);
NKp30=A(:,8);
NKp46=A(:,9);
NKG2D=A(:,10);
NKG2C=A(:,11);
NKG2A=A(:,12);


XX=sortrows(A,6) %sorted CD16 from low to high expressions
median_CD16=median(CD16) %17399


for i=1:size(CD16,1)
    if (XX(i,6) > median_CD16)
        disp("true")
    idx=i-1
    break
    end
end


CD16_low=XX(1:idx,:) %till 17148
CD16_high=XX((idx+1):end,:) %[17650-end]


% M=CD16_low
M=CD16_high
% M=A

% % %Receptor expressions at day 10
sCD16=M(:,6)
sNKp44=M(:,7)
sNKp30=M(:,8)
sNKp46=M(:,9)
sNKG2D=M(:,10)
sNKG2C=M(:,11)
sNKG2A=M(:,12)

 X=[sNKp44,sNKp30,sNKp46,sNKG2D,sNKG2C,sNKG2A]
 
 fprintf("NKp44,NKp30,NKp46, NKG2D, NKG2C,NKG2A")
%   fprintf("NKp46, NKG2D, NKG2C")
 correlation_matrix = corrcoef(X)
 [CM,P,lb,ub]=corrcoef(X,'alpha',0.05)
 
 CM(5,4)
  CM(5,4)=-5E-4
 CM=round(CM,3)
 
figure()
 % Replace upper triangle with NaNs
isupper = logical(triu(ones(size(CM)),1));
CM(isupper) = NaN
% Display the correlation matrix using imshow
% imshow(correlation_matrix, 'InitialMagnification', 'fit', 'Colormap', jet(256), 'Border', 'tight');
% 
%    set(gca, 'FontSize', 32,'FontName', 'Arial');

% Plot results
h = heatmap(CM,'MissingDataColor','w');
labels = ["NKp44","NKp30","NKp46","NKG2D", "NKG2C", "NKG2A"];
h.FontSize = 22;
h.XDisplayLabels = labels;
h.YDisplayLabels = labels; 

%Plot with colors

% Define the color for -1 and +1
% extremeColor = [0, 1, 1]; % blue (for both -1 and +1)
% neutralColor = [0, 0, 1]; % blueWhite for 0


neutralColor = [0.6, 0, 0]; % red (for both -1 and +1)
extremeColor = [1, 0.6, 0.4]; % red White for 0

% % 
% neutralColor = [0.6, 0, 0.5]; % red (for both -1 and +1)
% extremeColor = [0.2, 0.6, 0.4]; % red White for 0


% Define the number of colors in the gradient colormap
numColors = 256;

% Create the gradient colormap
cmapGradient = zeros(numColors, 3);
for i = 1:numColors
    t = (i - 1) / (numColors - 1);
    if t == 0.5 % Color at 0
        cmapGradient(i, :) = neutralColor;
    else % Linear interpolation for -1 and +1
        cmapGradient(i, :) = (1 - abs(t - 0.5) * 2) * extremeColor + abs(t - 0.5) * 2 * neutralColor;
    end
end


% Set the custom colormap for the heatmap
colormap(h, cmapGradient);

% Set color limits to match the range of the colormap
caxis(h, [-1, 1]);

% PCA_summary(X,5) 