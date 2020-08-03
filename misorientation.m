function misorient = misorientation(euler1, euler2)

% To Compute misorientation between euler angles

%%% Inputs:
% Euler angles are in Degree.

%%% Outputs:
% misorientation in Degree.



% numerical tolerance threshold
threshold = 1e-6;     % to deal with single precision error


% compute misorientation
quat1 = euler2quat(euler1*pi/180);
quat2 = euler2quat(euler2*pi/180);
qdot = dot(quat1,quat2);

% if qdot>1 (euler1 and euler2 are the same angle, numerical error)
if qdot>1
    if qdot-1<threshold
        misorient = 0;
        return
    else
        % issue beyond numerical error
        warning('dp > 1+eps');
        % continue calcs, which will give complex numbers
    end
end

% if qdot~=1, continue...
misorient = 2*acosd(qdot);
misorient = min(misorient,360-misorient);   % put in range 0.6.18