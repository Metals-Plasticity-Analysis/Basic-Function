function q = quat2Euler(quat)

% This function will convert the quaternion to the Euler angles.
% Input = quats = [q0 q1 q2 q3];
% Output  = Euler angles in degree;

    epsilon_ijk =[];
    q0 = quat(1);
    q1 = quat(2);
    q2 = quat(3);
    q3 = quat(4);

    chi = sqrt((q0^2+q3^2)*(q1^2+q2^2));

    if chi==0 && q12==0
        q = [atan2(-2*epsilon_ijk*q0*q3,q0^2-q3^2),0,0];

    elseif chi==0 && q03==0
        q = [atan2(2*q1*q2,q1^2-q2^2),pi,0];

    else 
        q = [atan2((q1*q3-epsilon_ijk*q0*q2)/chi,(-epsilon_ijk*q0*q1-q2*q3)/chi), ...
             atan2(2*chi,q03-q12),...
             atan2((epsilon_ijk*q0*q2+q1*q3)/chi,(-epsilon_ijk*q0*q1+q2*q3)/chi)];
    end

    if (q(1)<0.0) 
        q(1) = mod(q(1)+100.0*pi,2*pi);
    end
    if (q(2)<0.0) 
        q(2) = mod(q(2)+100.0*pi,pi);
    end
    if (q(3)<0.0) 
        q(3) = mod(q(3)+100.0*pi,2*pi);
    end
    q = q*(180/pi);
end
