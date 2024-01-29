function DCM = quat_DCM(q)
%
% 1. PROTOTYPE:
% A = quat2A(q)
%
% 2. DESCRIPTION:
% Function computes director cosine matrix (DCM) from the quaterion q
%
% 3. INPUT  SIZE   UNITS   DESCRIPTION
% q         [4,1]  [-]     Attitude quaternion between inertial and body frame
%
% 4. OUTPUT SIZE   UNITS   DESCRIPTION
% A         [3,3]  [-]     Director cosine matrix between inertial and body frame
%
% 5. CHANGELOG
% 26/02/2023 - Matteo D'Ambrosio - Created function
% 26/02/2023 - Matteo D'Ambrosio - Validated function
%
% 6. DEPENDENCIES
% - SkewSym.m
%
DCM = (q(4)^2 - q(1:3)'*q(1:3))*eye(3) + 2*q(1:3)*q(1:3)' - 2*q(4) * SkewSym(q(1:3)) ; 

    
end