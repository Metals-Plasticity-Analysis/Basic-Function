function [misorient, disorient,axang] = Disorientation(euler1, euler2)
%DISORIENTATION Compute disorientation/misorientation between euler angles

% Inputs:
% euler1: [phi1 PHI phi2] (deg)
% euler2: [phi1 PHI phi2] (deg)

%%% Outputs:
% misorient: misorientation (deg)
% disorient: disorientation (deg)
% axang: axis and angle in radian



% numerical tolerance threshold
thr = 1e-5;     % to deal with single precision error


% symmetry operators
    % m-3m
    R{1} = eye(3);
    R{2} = [-1 0 0;0 -1 0;0 0 1];
    R{3} = [-1 0 0;0 1 0;0 0 -1];
    R{4} = [1 0 0;0 -1 0;0 0 -1];
    R{5} = [0 0 1;1 0 0;0 1 0];
    R{6} = [0 0 1;-1 0 0;0 -1 0];
    R{7} = [0 0 -1;-1 0 0;0 1 0];
    R{8} = [0 0 -1;1 0 0;0 -1 0];
    R{9} = [0 1 0;0 0 1;1 0 0];
    R{10} = [0 -1 0;0 0 1;-1 0 0];
    R{11} = [0 1 0;0 0 -1;-1 0 0];
    R{12} = [0 -1 0;0 0 -1;1 0 0];
    R{13} = [0 1 0;1 0 0;0 0 -1];
    R{14} = [0 -1 0;-1 0 0;0 0 -1];
    R{15} = [0 1 0;-1 0 0;0 0 1];
    R{16} = [0 -1 0;1 0 0;0 0 1];
    R{17} = [1 0 0;0 0 1;0 -1 0];
    R{18} = [-1 0 0;0 0 1;0 1 0];
    R{19} = [-1 0 0;0 0 -1;0 -1 0];
    R{20} = [1 0 0;0 0 -1;0 1 0];
    R{21} = [0 0 1;0 1 0;-1 0 0];
    R{22} = [0 0 1;0 -1 0;1 0 0];
    R{23} = [0 0 -1;0 1 0;1 0 0];
    R{24} = [0 0 -1;0 -1 0;-1 0 0];
    R{25} = -R{1};
    R{26} = -R{2};
    R{27} = -R{3};
    R{28} = -R{4};
    R{29} = -R{5};
    R{30} = -R{6};
    R{31} = -R{7};
    R{32} = -R{8};
    R{33} = -R{9};
    R{34} = -R{10};
    R{35} = -R{11};
    R{36} = -R{12};
    R{37} = -R{13};
    R{38} = -R{14};
    R{39} = -R{15};
    R{40} = -R{16};
    R{41} = -R{17};
    R{42} = -R{18};
    R{43} = -R{19};
    R{44} = -R{20};
    R{45} = -R{21};
    R{46} = -R{22};
    R{47} = -R{23};
    R{48} = -R{24};



%%% misorientation
q1 = eu2qu(euler1*pi/180);
q2 = eu2qu(euler2*pi/180);
qdot = dot(q1,q2);

% if qdot>1 (euler1 and euler2 are the same angle, numerical error)
if qdot>1
    if qdot-1<thr
        misorient = 0;
        disorient = 0;
        return
    else
        % issue beyond numerical error
        warning('dp > 1+eps (misorient)');
        % will give complex numbers
    end
end

% if qdot~=1, continue...
misorient = 2*acosd(qdot);
misorient = min(misorient,360-misorient);   % put in range 0..180



%%% disorientation
disorient = misorient;  % initialize, stores current lowest disorientation as it loops through symmetry elements
R1 = eu2om(euler1*pi/180);  % rotation matrix of euler1
R2 = eu2om(euler2*pi/180);  % rotation matrix of euler2






for ii=1:length(R)
    for jj=1:length(R)
        Rdiff = R{jj}*R2/(R{ii}*R1);
        axang = rotm2axang(Rdiff);
        disorient_temp = axang(4)*180/pi;
        if disorient_temp < disorient
            disorient = disorient_temp;     % update if lower than previous value
        end
        
        Rdiff = R{ii}*R1/(R{jj}*R2);
        axang = rotm2axang(Rdiff);
        disorient_temp = axang(4)*180/pi;
        if disorient_temp < disorient
            disorient = disorient_temp;     % update if lower than previous value
        end
    end
end


end