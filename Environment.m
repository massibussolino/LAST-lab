% ENVIRONMENT
clear; close all; clc

format long
set(0,'defaultTextInterpreter','latex',...
    'DefaultLegendInterpreter','latex',...
    'DefaultAxesFontSize',12,...
    'DefaultLegendFontSize', 15,...
    'DefaultAxesTickLabelInterpreter','latex',...
    'DefaultTextInterpreter','latex');

addpath(genpath("documents"))
addpath(genpath("functions"))

% Read the environment data of the defined testcase
[EnvData] = ReadEnvironmentData('Disposizione_01.yml');

Tenda1 = EnvData.Tenda1;
Tenda2 = EnvData.Tenda2;
Diorama = EnvData.Diorama;
Floor = EnvData.Floor;
robotPos = EnvData.robotPos;
robotAng = EnvData.robotAng;

% Read the robot model footprint
NS12_footprint = NS12_model();

%% Show Environment: reachable space of the tip for AX1 in [-90 90]

f1 = figure();
hold on; grid on;
title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

% Tende nere, diorama grigio, pavimento a caso
[~,patchObj1] = show(Tenda1);
patchObj1.FaceColor = [ 0.4 0.4 0.4]; 

[~,patchObj2] = show(Tenda2);
patchObj2.FaceColor = [ 0.4 0.4 0.4];

[~,patchObj3] = show(Diorama);
patchObj3.FaceColor = [ 0.6 0.6 0.6];

[~,patchObj4] = show(Floor);
patchObj4.FaceColor = [ 0.901960784313726   0.694117647058824   0.458823529411765];

distance = 1805-robotPos(2);
% text(0,3500,2000,strcat('Distance from diorama:', num2str(distance)) ,'FontSize',15,'Rotation',0,'LineWidth',1.3)
subtitle(strcat('Tip reachability with AX1 in [-90, 90]. Distance from diorama:', num2str(distance),'mm'))

surf(NS12_footprint.tip.MESH_180(:,:,1)*cosd(robotAng) - NS12_footprint.tip.MESH_180(:,:,2)*sind(robotAng) + robotPos(1),...
     NS12_footprint.tip.MESH_180(:,:,1)*sind(robotAng) + NS12_footprint.tip.MESH_180(:,:,2)*cosd(robotAng) + robotPos(2),...
     NS12_footprint.tip.MESH_180(:,:,3)+robotPos(3),...
    'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space', 'Robot origin', 'Origin', 'FontSize', 14)


%% Show Environment: reachable space of the tip for AX1 in [-180 180]

f2 = figure();
hold on; grid on;
title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

% Tende nere, diorama grigio, pavimento a caso
[~,patchObj1] = show(Tenda1);
patchObj1.FaceColor = [ 0.4 0.4 0.4]; 

[~,patchObj2] = show(Tenda2);
patchObj2.FaceColor = [ 0.4 0.4 0.4];

[~,patchObj3] = show(Diorama);
patchObj3.FaceColor = [ 0.6 0.6 0.6];

[~,patchObj4] = show(Floor);
patchObj4.FaceColor = [ 0.901960784313726   0.694117647058824   0.458823529411765];

distance = 1805-robotPos(2);
% text(0,3500,2000,strcat('Distance from diorama:', num2str(distance)) ,'FontSize',15,'Rotation',0,'LineWidth',1.3)
subtitle(strcat('Tip reachability with AX1 in [-180, 180]. Distance from diorama:', num2str(distance),'mm'))

surf(NS12_footprint.tip.MESH_360(:,:,1)*cosd(robotAng) - NS12_footprint.tip.MESH_360(:,:,2)*sind(robotAng) + robotPos(1),...
     NS12_footprint.tip.MESH_360(:,:,1)*sind(robotAng) + NS12_footprint.tip.MESH_360(:,:,2)*cosd(robotAng) + robotPos(2),...
     NS12_footprint.tip.MESH_360(:,:,3)+robotPos(3),...
    'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space', 'Robot origin', 'Origin', 'FontSize', 14)


%% Show Environment: elbow footprint for AX1 in [-90 90]

f3 = figure();
hold on; grid on;
title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

% Tende nere, diorama grigio, pavimento a caso
[~,patchObj1] = show(Tenda1);
patchObj1.FaceColor = [ 0.4 0.4 0.4]; 

[~,patchObj2] = show(Tenda2);
patchObj2.FaceColor = [ 0.4 0.4 0.4];

[~,patchObj3] = show(Diorama);
patchObj3.FaceColor = [ 0.6 0.6 0.6];

[~,patchObj4] = show(Floor);
patchObj4.FaceColor = [ 0.901960784313726   0.694117647058824   0.458823529411765];

distance = 1805-robotPos(2);
% text(0,3500,2000,strcat('Distance from diorama:', num2str(distance)) ,'FontSize',15,'Rotation',0,'LineWidth',1.3)
subtitle(strcat('AX3 elbow footprint with AX1 in [-90, 90]. Distance from diorama:', num2str(distance),'mm'))

surf(NS12_footprint.elbow.MESH_180(:,:,1)*cosd(robotAng) - NS12_footprint.elbow.MESH_180(:,:,2)*sind(robotAng) + robotPos(1),...
     NS12_footprint.elbow.MESH_180(:,:,1)*sind(robotAng) + NS12_footprint.elbow.MESH_180(:,:,2)*cosd(robotAng) + robotPos(2),...
     NS12_footprint.elbow.MESH_180(:,:,3)+robotPos(3),...
    'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space', 'Robot origin', 'Origin', 'FontSize', 14)



%% Show Environment: elbow footprint for AX1 in [-180 180]

f4 = figure();
hold on; grid on;
title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

% Tende nere, diorama grigio, pavimento a caso
[~,patchObj1] = show(Tenda1);
patchObj1.FaceColor = [ 0.4 0.4 0.4]; 

[~,patchObj2] = show(Tenda2);
patchObj2.FaceColor = [ 0.4 0.4 0.4];

[~,patchObj3] = show(Diorama);
patchObj3.FaceColor = [ 0.6 0.6 0.6];

[~,patchObj4] = show(Floor);
patchObj4.FaceColor = [ 0.901960784313726   0.694117647058824   0.458823529411765];

distance = 1805-robotPos(2);
% text(0,3500,2000,strcat('Distance from diorama:', num2str(distance)) ,'FontSize',15,'Rotation',0,'LineWidth',1.3)
subtitle(strcat('AX3 elbow footprint with AX1 in [-180, 180]. Distance from diorama:', num2str(distance),'mm'))

surf(NS12_footprint.elbow.MESH_360(:,:,1)*cosd(robotAng) - NS12_footprint.elbow.MESH_360(:,:,2)*sind(robotAng) + robotPos(1),...
     NS12_footprint.elbow.MESH_360(:,:,1)*sind(robotAng) + NS12_footprint.elbow.MESH_360(:,:,2)*cosd(robotAng) + robotPos(2),...
     NS12_footprint.elbow.MESH_360(:,:,3)+robotPos(3),...
    'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space', 'Robot origin', 'Origin', 'FontSize', 14)


%% DIORAMA coverage

figure
title("Diorama coverage")

area([-1e4 1e4 ],[1e4; 1e4],"FaceColor","k"); hold on

levels = [min(NS12_footprint.tip.MESH_360(:,:,1)*cosd(robotAng) - NS12_footprint.tip.MESH_360(:,:,2)*sind(robotAng) + robotPos(2),[],"all"),...
    EnvData.diorama.center(2)];
contourf(NS12_footprint.tip.MESH_360(:,:,1)*sind(robotAng) + NS12_footprint.tip.MESH_360(:,:,2)*cosd(robotAng) + robotPos(1),...
         NS12_footprint.tip.MESH_360(:,:,3)+robotPos(3),...
         NS12_footprint.tip.MESH_360(:,:,1)*cosd(robotAng) - NS12_footprint.tip.MESH_360(:,:,2)*sind(robotAng) + robotPos(2),...
         levels)

colormap(bone(2));
colorbar
axis('equal')
grid
xlabel('X')
ylabel('Y')
xlim([EnvData.diorama.center(1)-EnvData.diorama.x/2,EnvData.diorama.center(1)+EnvData.diorama.x/2])
ylim([EnvData.diorama.center(3)-EnvData.diorama.z/2,EnvData.diorama.center(3)+EnvData.diorama.z/2])
legend("Not reachable area")
