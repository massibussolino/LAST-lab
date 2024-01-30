% Run script to simulate robot
clearvars ; close all ; clc ;

% Simulation options
opts.simTime = 10 ; % [s] - Simulation time
opts.AbsTol = 1e-10 ;
opts.RelTol = 1e-10 ;
opts.gravity = [0,0,-9.81] ;
opts.autoCompensateGravity = true ;

% Add required paths
addpath(genpath(fullfile('Simscape','SPART-master'))) ;
addpath(genpath(fullfile('Simscape','SimscapeBlocks'))) ;

% Load robot URDF model
[robotURDF,~] = urdf2robot(fullfile('Simscape','URDF','urdf','SMART NS 12-1,85_ARTICOLATO.SLDASM.urdf')) ;
robot_rigidBodyTree = importrobot(fullfile('Simscape','URDF','urdf','SMART NS 12-1,85_ARTICOLATO.SLDASM.urdf')) ;
robot_rigidBodyTree.Gravity = opts.gravity ; % [m/s^2] - Define gravity used for gravity compensation

% Load robot position into Simscape
robot.Pos_mm = [2200, 1000, 0] ; % [mm] - Position of robot in LaST room

% Robot joint initial conditions
robot.ic.ang =    [30, 30, 30, 30, 30, 30] ; % [deg]
robot.ic.angvel = [0, 0, 0, 0, 0, 0] ;   % [deg/s]
robot.ic.r0 = robot.Pos_mm'/1000 ; % [m] - Converted from mm
robot.ic.R0 = eye(3) ; % [rad]

% Reference trajectory initial conditions
trajectoryRef.ic.r0 = robot.ic.r0 ;
trajectoryRef.ic.R0 = robot.ic.R0 ;

% Compute initial end-effector state
[ ~, RL, rJ, rL, e, g ] = Kinematics( robot.ic.R0, robot.ic.r0, deg2rad(robot.ic.ang), robotURDF ) ;
[Bij, Bi0, P0, pm] = DiffKinematics( robot.ic.R0, robot.ic.r0, rL, e, g, robotURDF) ;
[t0, tL] = Velocities(Bij, Bi0, P0, pm, zeros(6,1), zeros(6,1), robotURDF) ;
[I0, Im] = I_I(robot.ic.R0, RL, robotURDF) ;
p_ee0 = rL(1:3, end) + [0.0744476654482305 0.115913824172212 0.00106781708847979]' ; % [m] - The robot base in the URDF file is not exactly at [0,0,0], so the translation fixes the correct end-effector position
R_ee0 = RL(1:3, 1:3, end) ; % [rad]
v_ee0 = tL(4:6,end) ; % [m/s]
w_ee0 = tL(1:3,end) ; % [rad/s]

