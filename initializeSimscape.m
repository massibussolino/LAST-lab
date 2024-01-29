% Run script to simulate robot
clearvars ; close all ; clc ;
 
% Add required paths
addpath(genpath('SPART-master')) ;

% Load robot URDF model
[robot,~] = urdf2robot(fullfile('Simscape','URDF','urdf','SMART NS 12-1,85_ARTICOLATO.SLDASM.urdf')) ;

% Load robot position into Simscape
EnvData = ReadEnvironmentData(fullfile('Disposizione_02.yml')) ;
EnvData.robotPos = [2200,1000,0] ;

% Robot joint initial conditions
robot_ic_ang =    [0, 0, -90, 0, 0, 0] ; % [deg]
robot_ic_angvel = [0, 0, 0, 0, 0, 0] ;   % [deg/s]

















