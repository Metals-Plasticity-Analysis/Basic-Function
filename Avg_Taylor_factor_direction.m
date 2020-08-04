%This code is for calculating average Taylor factor
clc;
clear;

cs = crystalSymmetry('432');
ss = specimenSymmetry('1');

%define a family of slip systems
sS = slipSystem.fcc(cs);

%%some plane strain
q = 0.5;
epsilon= strainTensor([1 0 0; 0 -q 0;0 0 q-1]);


%% Asking the euler angle input from User

prompt = 'Enter your file name having orientation of grain in apostrophe(''myfile.txt''):-';
name_of_file = input(prompt);
grain_orientation = dlmread(name_of_file);
Taylor_factor_direction=[];
theta=[];

for i=0:15:90
    
    all_euler=[(grain_orientation(:,1)+i),(grain_orientation(:,2)),(grain_orientation(:,3))];
    Taylor_factor=[];
    loopcnt = 0;
    
 for counter=1:1:size(all_euler,1)
    euler = all_euler(counter,:)*degree;
    ori = orientation('Euler',euler,cs,ss);
    [M,~,W] = calcTaylor(inv(ori)*epsilon,sS.symmetrise);
    Taylor_factor = [Taylor_factor;M];
    loopcnt = loopcnt + 1;
 end
   
%calculate average Taylor factor
Avg_Taylor_Factor=(sum(Taylor_factor,'all'))/loopcnt;
Taylor_factor_direction=[Taylor_factor_direction;Avg_Taylor_Factor];
theta=[theta;i];    
end

plot(theta,Taylor_factor_direction,'-o','MarkerSize',5,'LineWidth',2,'LineStyle','-','linewidth',3,'Color','k');
xlim([0 90]);
xlabel('Angle from RD (degrees)','fontweight','bold','fontsize',32);
ylabel('Average Taylor Factor','fontweight','bold','fontsize',32);
set(gca,'FontSize',30,'fontweight','bold');
set(gcf,'color','w');
set(gca,'linewidth',3);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);


