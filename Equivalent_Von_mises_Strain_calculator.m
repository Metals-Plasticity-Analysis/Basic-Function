%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%         Strain Matrix   %%%%%%%%%%%%%%

% Rolling = [1 0 0; 0 0 0; 0 0 -1];
% Uniaxial_tension = [-0.5 0 0; 0 -0.5 0; 0 0 1];
Uniaxial_compression = [0.5 0 0; 0 0.5 0; 0 0 -1];
% Torsion  = [ 0 1 0; 1 0 0; 0 0 0]
% Wire_drawing = [ 1 0 0; 0 -0.5 0; 0 0 -0.5];

%%%% Deviatoric Strain Calculation %%%%%


strain_matrix = Uniaxial_compression;

e_xx = ((2/3)*strain_matrix(1,1)) - ((1/3)*strain_matrix(2,2)) -((1/3)*strain_matrix(3,3));
e_yy = ((2/3)*strain_matrix(2,2)) - ((1/3)*strain_matrix(1,1)) -((1/3)*strain_matrix(3,3));
e_zz = ((2/3)*strain_matrix(3,3)) - ((1/3)*strain_matrix(1,1)) -((1/3)*strain_matrix(2,2));


%%%%%%%%%% Calculating engineering strains gamma

Gamma = 2 * strain_matrix;
g_xy = Gamma(2,1);
g_yz = Gamma(3,2);
g_zx = Gamma(3,1);
%%%%%%%%% Calculating Von-mises strain %%%%%%%%%%%%%%

E_von_mises_strain = (2/3)*sqrt(((3/2)*(e_xx^2 + e_yy^2 + e_zz^2))+((3/4)*(g_xy^2 + g_yz^2 + g_zx^2)))
%%% Multiply above (E_von_mises_strain) factor with true strain = ln(final thickness/initial thickness).


