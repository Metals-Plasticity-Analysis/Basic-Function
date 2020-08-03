function q = euler2RotationMatrix(euler)

% INPUT: [phi1 PHI phi2] in radians
% OUTPUT: 3x3 rotation matrix

thr = 1e-10;

c1 = cos(euler(1));
c3 = cos(euler(3));
c2  = cos(euler(2));

s1 = sin(euler(1));
s3 = sin(euler(3));
s2  = sin(euler(2));

q = [ c1*c3-s1*c2*s3,  s1*c3+c1*c2*s3, s2*s3; ...
     -c1*s3-s1*c2*c3, -s1*s3+c1*c2*c3, s2*c3; ...
           s1*s2    ,      -c1*s2    ,  c2   ];

for i=1:3
  for j=1:3
    if (abs(q(i,j))< thr) 
        q(i,j) = 0.0;
    end
  end
end
