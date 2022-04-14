% This program can compute the odf from the list of euler angles as orientation.
% These orientation can be the list obtained from the DAMASK simulation.
  
CS = crystalSymmetry('m-3m'); % Assuming fcc material
SS = specimenSymmetry('mmm'); % If symmetry is orthorhombic
data= loadOrientation_generic("euler_angles.dat",'CS',CS,'SS',SS,'ColumnNames',{'Euler1' 'Euler2' 'Euler3'}, 'Bunge'); % euler_angles.dat is the filename.
odf = calcDensity(data); % Calculating ODF
figure;
plot(odf,'phi2',[0 45 65]*degree)
