% ENVIRONMENT
clear; close all; clc

format long
set(0,'defaultTextInterpreter','latex',...
    'DefaultLegendInterpreter','latex',...
    'DefaultAxesFontSize',12,...
    'DefaultLegendFontSize', 15,...
    'DefaultAxesTickLabelInterpreter','latex',...
    'DefaultTextInterpreter','latex');

%% Dimensions of Objects
% Tenda1 on the left side of the room
tenda1x = 30;       % [mm]
tenda1y = 2500;     % [mm]
tenda1z = 3000;     % [mm] Guessed
% Tenda2 on the opposite side of the diorama
tenda2x = 3000;     % [mm] Non vincolata
tenda2y = 30;       % [mm]
tenda2z = 3000;     % [mm]
% Diorama
dioramax = 2400;    % [mm]
dioramay = 80;      % [mm]
dioramaz = 2000;    % [mm]
% Floor
floorx =  6230;     % [mm]
floory = 3000;      % [mm]
floorz = 10;        % [mm]
% Walls (not necessary)

% Simplified robot
% radius = (2150.37+884.78)/2;
radius = (1850.37+1156.59)/2;

%% Generate Objects

tenda1 = collisionBox(tenda1x, tenda1y, tenda1z);
tenda2 = collisionBox(tenda2x, tenda2y, tenda2z);
diorama = collisionBox(dioramax, dioramay, dioramaz);
floor = collisionBox(floorx, floory, floorz);

%% Orientation and Location

tenda1.Pose = [eye(3) [0 tenda1y/2 tenda1z/2]'; zeros(1,3) 1];
tenda2.Pose = [eye(3) [tenda2x/2 0 tenda2z/2]'; zeros(1,3) 1];
diorama.Pose = [eye(3) [300+dioramax/2 1805 dioramaz/2]'; zeros(1,3) 1];
floor.Pose = [eye(3) [floorx/2-220 floory/2-395 -floorz/2]'; zeros(1,3) 1];

robotPos = [300+2400/2 1805-1500 600];
robotPos = robotPos+[0 300 300];

%% Show Environment

figure()
hold on; grid on;
title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

% Tende nere, diorama grigio, pavimento a caso
[~,patchObj1] = show(tenda1);
patchObj1.FaceColor = [ 0.1 0.1 0.1]; 

[~,patchObj2] = show(tenda2);
patchObj2.FaceColor = [ 0.1 0.1 0.1];

[~,patchObj3] = show(diorama);
patchObj3.FaceColor = [ 0.6 0.6 0.6];

[~,patchObj4] = show(floor);
patchObj4.FaceColor = [ 0.901960784313726   0.694117647058824   0.458823529411765];

% Simplified reachable space of robot
[X_sphere,Y_sphere,Z_sphere] = sphere;
surf(X_sphere*radius+robotPos(1),Y_sphere*radius+robotPos(2),Z_sphere*radius+robotPos(3),'FaceColor','none','LineStyle',':','LineWidth',0.1)
scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')
legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space', 'Ax2', 'Origin', 'FontSize', 14)

distance = 1805-robotPos(2);
% text(0,3500,2000,strcat('Distance from diorama:', num2str(distance)) ,'FontSize',15,'Rotation',0,'LineWidth',1.3)
subtitle(strcat('Distance from diorama:', num2str(distance)))
