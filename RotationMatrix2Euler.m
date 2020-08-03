function q = RotationMatrix2Euler(rotation_matrix)

% INPUT: 3x3 rotation matrix
% OUTPUT: [phi1 PHI phi2] in radians

threshold = 1e-6;

if abs(abs(rotation_matrix(3,3))-1.0)>threshold
    
    zeta = 1/sqrt(1-rotation_matrix(3,3)^2);
    q = [atan2(rotation_matrix(3,1)*zeta , -rotation_matrix(3,2)*zeta), acos(rotation_matrix(3,3)), ...
         atan2(rotation_matrix(1,3)*zeta , rotation_matrix(2,3)*zeta)];
    
else
  % we arbitrarily assign the entire angle to phi_1   
    if abs(rotation_matrix(3,3)-1.0)<threshold
    
        q = [atan2(rotation_matrix(1,2),rotation_matrix(1,1)),0.0,0.0];
        
    else
    
        q = [-atan2(-rotation_matrix(1,2),rotation_matrix(1,1)),pi,0.0];
    end

end

% reduce Euler angles to definition ranges (and positive values only)
if (q(1)<0.0) 
    q(1) = mod(q(1)+100.0*pi,2.0*pi);
end

if (q(2)<0.0) 
    q(2) = mod(q(2)+100.0*pi,pi);
end

if (q(3)<0.0) 
    q(3) = mod(q(3)+100.0*pi,2.0*pi);
end
end
