function q = euler2quat(eu)
    
    % This function should convert the euler angle to quaternions.
    % Input  = Euler angles in Degree.
    % Output = array of quaternions.
    
    
    
    global epsijk
    epsijk = -1;

    aphi1 = eu(1)*(180/pi);
    aPhi = eu(2)*(180/pi);
    aphi2 = eu(3)*(180/pi);

    sigma = 0.5*(aphi1+aphi2);
    delta = 0.5*(aphi1-aphi2);
    c = cos(aPhi/2);
    s = sin(aPhi/2);

    q0 = c*cos(sigma);

    if q0>=0
        q = [c*cos(sigma), -epsijk*s*cos(delta), -epsijk*s*sin(delta), -epsijk*c*sin(sigma)];
    else
        q = [-c*cos(sigma), epsijk*s*cos(delta), epsijk*s*sin(delta), epsijk*c*sin(sigma)];
    end
    % set values very close to 0 as 0
    thr = 1e-10;
    if (abs(q(1))-0)<thr
        q(1)=0.0;
    elseif (abs(q(2))-0)<thr
        q(2)=0.0;
    elseif (abs(q(3))-0)<thr
        q(3)=0.0;
    elseif (abs(q(4))-0)<thr
        q(4)=0.0;    
    end
end


