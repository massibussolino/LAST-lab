function q = DCM_quat(A)
%
% 1. PROTOTYPE:
% q = A2quat(A)
%
% 2. DESCRIPTION:
% Function is used to convert DCM to a quaternion. Function exploits
% Matlab's dcm2quat function, but with a different convention.
% In this function, the quaternion's scalar component is the last one:
%       q = [(q1,q2,q3),q4] with q4 being the scalar part
%
% 3. INPUT   SIZE   UNITS   DESCRIPTION
% A          [3,3]  [-]     Director cosine matrix
%
% 4. OUTPUT  SIZE   UNITS   DESCRIPTION
% q          [4,1]  [-]     Quaternion
%
% 5. CHANGELOG
% 26/02/2023 - Matteo D'Ambrosio - Created function
% 26/02/2023 - Matteo D'Ambrosio - Validated function
%
% 6. DEPENDENCIES
% -None
%

%% Function code

% Select which of the 4 transformations to use
% -> For numerical accuracy, the one with the highest square root term is
% selected.
q = 0.5 * sqrt([ 1 + A(1,1) - A(2,2) - A(3,3); 1 - A(1,1) + A(2,2) - A(3,3); 1 - A(1,1) - A(2,2) + A(3,3); 1 + A(1,1) + A(2,2) + A(3,3) ]) ;
[ q_max, transformationIdx ] = max(q) ;

% Precompute recurring parameter
k = 1/(4*q_max) ;

% Compute remaining part of quaternion
% -> Only the non-max terms will be overwritten
switch transformationIdx
    
    case 1
        
        q(2) = k * ( A(1,2) + A(2,1) ) ;
        q(3) = k * ( A(1,3) + A(3,1) ) ;
        q(4) = k * ( A(2,3) - A(3,2) ) ;
                
    case 2
        
        q(1) = k * ( A(1,2) + A(2,1) ) ;
        q(3) = k * ( A(2,3) + A(3,2) ) ;
        q(4) = k * ( A(3,1) - A(1,3) ) ;
        
    case 3
        
        q(1) = k * ( A(1,3) + A(3,1) ) ;
        q(2) = k * ( A(2,3) + A(3,2) ) ;
        q(4) = k * ( A(1,2) - A(2,1) ) ;
        
    case 4
        
        q(1) = k * ( A(2,3) - A(3,2) ) ;
        q(2) = k * ( A(3,1) - A(1,3) ) ;
        q(3) = k * ( A(1,2) - A(2,1) ) ;
        
end

end