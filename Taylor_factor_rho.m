%This code is for calculating average Taylor factor using MTEX
clc;
clear;

cs = crystalSymmetry('432');
ss = specimenSymmetry('1');

%define a family of slip systems
sS = slipSystem.fcc(cs);




%% Asking the euler angle input from User

prompt = 'Enter your file name having orientation of grain in apostrophe(''myfile.txt''):-';
name_of_file = input(prompt);
grain_orientation = dlmread(name_of_file);
collect_Taylor_factor=[];
%%some plane strain
for q=0:0.05:1

epsilon= strainTensor([1 0 0; 0 -q 0;0 0 q-1]);

%% Assigning grain orientations to a variable all_Euler
all_euler = grain_orientation;
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
collect_Taylor_factor=[collect_Taylor_factor;Avg_Taylor_Factor];

end