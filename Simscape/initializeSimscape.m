% Run script to simulate robot
clearvars ; close all ; clc ;

% Load robot position into Simscape
EnvData = ReadEnvironmentData(fullfile('Disposizione_02.yml')) ;

% Robot joint initial conditions
robot_ic_ang =    [0, 0, -90, 0, 0, 0] ; % [deg]
robot_ic_angvel = [0, 0, 0, 0, 0, 0] ;   % [deg/s]














