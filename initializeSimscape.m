% Run script to simulate robot
clearvars ; close all ; clc ;

% Add required paths
addpath(genpath(fullfile('Simscape','SPART-master'))) ;
addpath(genpath(fullfile('Simscape','SimscapeBlocks'))) ;

% Load robot URDF model
[robot,~] = urdf2robot(fullfile('Simscape','URDF','urdf','SMART NS 12-1,85_ARTICOLATO.SLDASM.urdf')) ;

% Load robot position into Simscape
EnvData = ReadEnvironmentData(fullfile('Disposizione_02.yml')) ;
EnvData.robotPos = [2200,1000,0] ;

% Robot joint initial conditions
robot_ic_ang =    [0, 0, 0, 0, 0, 0] ; % [deg]
robot_ic_angvel = [0, 0, 0, 0, 0, 0] ;   % [deg/s]
robot_ic_r0 = EnvData.robotPos' ; % [mm]
robot_ic_R0 = eye(3) ; % [rad]

% Compute initial end-effector state
[ ~, RL, rJ, rL, e, g ] = Kinematics( robot_ic_R0, robot_ic_r0/1000, deg2rad(robot_ic_ang), robot ) ;
[Bij, Bi0, P0, pm] = DiffKinematics( robot_ic_R0, robot_ic_r0/1000, rL, e, g, robot) ;
[t0, tL] = Velocities(Bij, Bi0, P0, pm, zeros(6,1), zeros(6,1), robot) ;
[I0, Im] = I_I(robot_ic_R0, RL, robot) ;
p_ee0 = rL(1:3, end) + [0.0744476654482305 0.115913824172212 0.00106781708847979]' ; % [m] - The robot base in the URDF file is not exactly at [0,0,0], so the translation fixes the correct end-effector position
R_ee0 = RL(1:3, 1:3, end) ; % [rad]
v_ee0 = tL(4:6,end) ; % [m/s]
w_ee0 = tL(1:3,end) ; % [rad/s]

