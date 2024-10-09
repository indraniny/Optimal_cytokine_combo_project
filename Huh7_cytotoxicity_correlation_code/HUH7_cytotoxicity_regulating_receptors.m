% 3rd October 2023
%22nd August 2023

clear all;

load tagged_absolute_MFI_cyto_receptor.dat
A=tagged_absolute_MFI_cyto_receptor(:,:)

%CD107 expressions in the presence of the ligands
% A(2,:)=[] %only for HepG2
% A(49:end,:)=[] %only for huh7

FC=A(:,1); %Fold change in Day 9

HEPG2= A(:,2) %CD107 expressions in presence of HepG2 at day 10
PLC= A(:,3); %CD107 expressions in presence of PLC at day 10
SNU= A(:,4) ;%CD107 expressions in presence of SNU475 at day 10
HUH= A(1:48,5); %CD107 expressions in presence of HUH7 at day 10



% % %Receptor expressions at day 10
CD16=A(:,6);
NKp44=A(:,7);
NKp30=A(:,8);
NKp46=A(:,9);
NKG2D=A(:,10);
NKG2C=A(:,11);
NKG2A=A(:,12);





XX=sortrows(A,6) %sorted CD16 from low to high expressions
median_CD16=median(CD16) %17650

for i=1:size(CD16,1)
    if (XX(i,6) > median_CD16)
        disp("true")
    idx=i-1
    break
    end
end


CD16_low=XX(1:idx,:) %till 17148
CD16_high=XX((idx+1):end,:) %[17650-end]

% CD16_low=XX(1:32,:) %till 17148
% CD16_high=XX(33:end,:) %[17650-end]

% 
% M=CD16_low
%  M=A
 M=CD16_high

% % %Receptor expressions at day 10
sCD16=M(:,6)
sNKp44=M(:,7)
sNKp30=M(:,8)
sNKp46=M(:,9)
sNKG2D=M(:,10)
sNKG2C=M(:,11)
sNKG2A=M(:,12)
donor=M(:,13)
cond=M(:,14)
IL_tag=M(:,15)

%Redifining arrows
sHEPG2= M(:,2); %CD107 expressions in presence of HepG2 at day 10
sPLC= M(:,3); %CD107 expressions in presence of PLC at day 10
sSNU= M(:,4); %CD107 expressions in presence of SNU475 at day 10
sHUH= M(:,5); %CD107 expressions in presence of HUH7 at day 10



 X=[sNKp44,sNKp30,sNKp46,sNKG2D,sNKG2C,sNKG2A, donor, cond, IL_tag]
%  Y=sHEPG2
%  Y=sHUH
Y=sSNU
% Y=sPLC

% Create a big figure
bigFigure = figure;
numPlots=6;

receptors=["NKp44","NKp30","NKp46","NKG2D","NKG2C", "NKG2A"]
for i=1:(size(X,2)-3)
% for i=1,6
    disp(receptors{i})
    [R,P]=corrcoef(X(:,i),Y)
   
     % Set the font name to Arial for axes labels and tick labels
    set(gca, 'FontName', 'Arial'); % Set the font for axes labels and tick labels

    %subplot grid look 2 x 3
    subplot(2,3,i);
%     subplot(1,2,i);
    hold on;
    title(['Subplot ', num2str(i)], 'FontSize', 30,'FontName', 'Arial');
    set(gca, 'FontSize', 28);
    
    % Set the y-axis range to 0 to 90
ylim([-5, 80]);
 xlim([min(X(:,i))-500, max(X(:,i))+500]);

% Set the number of y-axis ticks
ydesiredNumTicks = 5; % Change this to the number of ticks you want
yticks(linspace(0, 80, ydesiredNumTicks));

%     xlabel(receptors{i},'FontSize',25,'FontName', 'Arial')
%     ylabel("CD107 %",'FontSize',25,'FontName', 'Arial' )
   
    
%      ylabel(" HepG2 : CD107 %",'FontSize',22)
     
%      ylabel(" SNU : CD107 %",'FontSize',22)
%     ylabel(" PLC : CD107 %",'FontSize',22)
    
    % Display the value in the legend
%     titlestring=['R = ',num2str(R(1,2)),', P = ', num2str(P(1,2))]
%     title(titlestring)
%     hold on
    % Set the title font properties
% titleHandle = title(titlestring);
% titleFont = findall(titleHandle, '-property', 'FontName'); % Find the title's FontName property
% set(titleFont, 'FontName', 'Arial', 'FontSize', 24); % Set the FontName to Arial and FontSize to 14

   
%     plot(X(:,i),Y,'ro','LineWidth',3,'MarkerSize',10)

    % Set the title to an empty string
title('');
    l1=1
    l2=1
    l3=1
    l4=1
    aa=[]
    bb=[]
    ab=[]
    neu=[]
    q=9
    size(X,1)
    for k =1:size(X,1) %32
                    if (X(k,q)== 1) %IL-18
                        aa(l1,:)=[X(k,i),Y(k)]
                        l1=l1+1;
                    elseif (X(k,q)== 2) %IL-21
                             bb(l2,:)=[X(k,i),Y(k)]
                              l2=l2+1;
                        
                    elseif (X(k,q)== 12) %IL-21
                           ab(l3,:)=[X(k,i),Y(k)]
                           l3=l3+1;
                    elseif (X(k,q)== 0) %IL-21
                        neu(l4,:)=[X(k,i),Y(k)]
                        l4=l4+1;
                    end
    end 
    marker_size=400
   scatter(aa(:,1),aa(:,2), marker_size, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;
    scatter(bb(:,1),bb(:,2), marker_size, 'MarkerFaceColor', [ 0 0 1], 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;
    scatter(ab(:,1),ab(:,2), marker_size, 'MarkerFaceColor', [0.4660 0.6740 0.1880], 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;
    scatter(neu(:,1),neu(:,2), marker_size, 'MarkerFaceColor', [0.9 0.9 0.9], 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;

    if (i==3)
        % Set the marker size in the legend
        
        % Create the legend
legendHandle = legend;
markerSize = 200; % Adjust the marker size as needed
legendMarkers = findobj(legendHandle, 'Type', 'line', '-and', '-not', 'Tag', 'Colorbar');
set(legendMarkers, 'MarkerSize', markerSize);

% Set the legend font properties (optional)
% set(legendHandle, 'FontName', 'Arial');
% 
%         legend('IL-18', 'IL-21 ', 'IL-18+IL-21 ', 'Others ');
%         legend('FontName', 'Arial');
    end
% 
    
    
    aa
    bb
    ab
    neu
        % You can also set the line width of the box around the axes, if desired
    set(gca, 'Box', 'on', 'LineWidth', 2.5);
    % Set the tick size for the x-axis and y-axis
    set(gca, 'TickLength', [0.025, 0.025]);
    hold on
   

end
B=X\Y