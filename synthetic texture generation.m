% A detailed information is available https://mtex-toolbox.github.io/OrientationStandard.html
% some of the standard orientations that are build into MTEX. The full list of predefined orientations consists of

%% Random Texture generation in MTEX

cs = crystalSymmetry('cubic'); ss = specimenSymmetry('orthorhombic');
odf = uniformODF(cs,ss);
ori = discreteSample(odf,5000);
euler_angles = [ori.phi1,ori.Phi,ori.phi2];
odf = calcDensity(ori);
plot(odf,'phi2',[0 45 65]* degree,'contour','antipodal','linewidth',2,'colorbar');
setColorRange('equal');  
mtexColorbar ('FontSize',25,'Fontweight','bold')



% 
% Cube, CubeND22, CubeND45, CubeRD
% Goss, invGoss
% Copper, Copper2
% SR, SR2, SR3, SR4
% Brass, Brass2
% PLage, PLage2, QLage, QLage2, QLage3, QLage4
% For visualisation we fix a generic cubic crystal symmetry and orthorhombic specimen symmetry
clear;
close;

cs = crystalSymmetry('m-3m');
ss = specimenSymmetry('orthorhombic');

% and select a subset of the above predifined orientations

components = [...
  orientation.cube(cs,ss),...
  orientation.goss(cs,ss),...
  orientation.brass(cs,ss),...
  orientation.copper(cs,ss),...
  orientation.SR(cs,ss),...
  orientation.cubeND22(cs,ss),...
  orientation.cubeND45(cs,ss),...
  orientation.cubeRD(cs,ss),...
  orientation.PLage(cs,ss),...
  orientation.QLage(cs,ss),...
  ];
odf = unimodalODF(components(1),'halfwidth',7.5*degree);
%% Exporting the orientations
% % If just want the component
fname = 'synthetic_texture.txt';
% export(components(1),fname)

% Exporting from ODF
% draw random orientations from ODF
ori = calcOrientations(odf,50);
export(ori,fname)


%% Visulalizing the generated texture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % Model ODF generation % % % %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plotting Pole figure distribution
plotx2north
h = Miller({1,0,0},{1,1,0},{1,1,1},{3,1,1},cs);

plotPDF(odf,h)
hold on
plotPDF(odf,h,'contour','lineColor','k','linewidth',2)
hold off

%% Plotting IPDF figures
% Defining r first
r = [vector3d.X,vector3d.Y,vector3d.Z];
plotIPDF(odf,r)
hold on
plotIPDF(odf,r,'contour','lineColor','k','linewidth',2)
hold off

%% Plotting ODF section
plotSection(odf,'phi2',[0 45 65]*degree)
hold on
plotSection(odf,'contour','lineColor','k','linewidth',2)



