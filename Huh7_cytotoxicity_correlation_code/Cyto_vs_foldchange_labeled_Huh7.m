%2nd October 2023
%8th September 2023

% %CD107 expressions (at day 10) vs fold change (at day 9)
clear all;

load tagged_absolute_MFI_cyto_receptor.dat
A=tagged_absolute_MFI_cyto_receptor(:,:)

%CD107 expressions in the presence of the ligands
% A(2,:)=[] %only for HepG2
A(49:end,:)=[] %only for huh7

FC=A(:,1); %Fold change in Day 9

HEPG2= A(:,2) %CD107 expressions in presence of HepG2 at day 10
PLC= A(:,3); %CD107 expressions in presence of PLC at day 10
SNU= A(:,4) ;%CD107 expressions in presence of SNU475 at day 10
HUH= A(1:48,5); %CD107 expressions in presence of HUH7 at day 10
IL_tag=A(:,15);

% title(['HepG2', 'FontSize', 14);
    set(gca, 'FontSize', 28);
    
%     xlabel("Fold change",'FontSize',22)
%      ylabel(" PLC : CD107 %",'FontSize',22)
%      ylabel(" HepG2 : CD107 %",'FontSize',22)
%      ylabel(" HUH : CD107 %",'FontSize',22)
%       ylabel(" SNU : CD107 %",'FontSize',22)

ymax=100
    % Set the y-axis range to 0 to 90
ylim([-8, ymax]);
xlim([-5, 90]);

% % Set the number of y-axis ticks
% xdesiredNumTicks = 4; % Change this to the number of ticks you want
% xticks(linspace(0, max(X(:,i)), xdesiredNumTicks));

% Set the number of y-axis ticks
ydesiredNumTicks = 5; % Change this to the number of ticks you want
yticks(linspace(0, ymax, ydesiredNumTicks));

% plot(FC,HEPG2,'ro','LineWidth',3,'MarkerSize',10)

   %mention the cell line
%    Y=SNU
%    Y=PLC
%    Y=HEPG2
    Y=HUH
[R,P]=corrcoef(FC,Y)
% 
% %labelled plot
    hold on
%     
    
    l1=1
    l2=1
    l3=1
    l4=1
    aa=[]
    bb=[]
    ab=[]
    neu=[]

 
    
    for k =1:size(FC) %32
        if (IL_tag(k)== 1) %IL-18
            aa(l1,:)=[FC(k),Y(k)];
            l1=l1+1;
        elseif (IL_tag(k)== 2) %IL-21
            bb(l2,:)=[FC(k),Y(k)];
            l2=l2+1;
            
        elseif (IL_tag(k)== 12) %IL-21
            ab(l3,:)=[FC(k),Y(k)];
            l3=l3+1;
        elseif (IL_tag(k)== 0) %others
            neu(l4,:)=[FC(k),Y(k)];
            l4=l4+1;
        end
    end
    disp('IL-18 group (A)')
    aa
    disp('IL-21 group (B)')
    bb   
    disp('IL-21/18 group (AB)')
    ab
    disp('Others')
    neu
    
    
     marker_size=400
   scatter(aa(:,1),aa(:,2), marker_size, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;
    scatter(bb(:,1),bb(:,2), marker_size, 'MarkerFaceColor', [ 0 0 1], 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;
    scatter(ab(:,1),ab(:,2), marker_size, 'MarkerFaceColor', [0.4660 0.6740 0.1880], 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;
    scatter(neu(:,1),neu(:,2), marker_size, 'MarkerFaceColor', [0.9 0.9 0.9], 'MarkerEdgeColor', 'k','LineWidth', 2);
    hold on;


     legend('FontName', 'Arial','Fontsize', 24);
  legend('IL-18', 'IL-21 ', 'IL-18+IL-21 ', 'Others ');
    
      % You can also set the line width of the box around the axes, if desired
    set(gca, 'Box', 'on', 'LineWidth', 2.5);
    % Set the tick size for the x-axis and y-axis
    set(gca, 'TickLength', [0.025, 0.025]);

  