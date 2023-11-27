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
[EnvData] = ReadEnvironmentData('Disposizione_03.yml');

% Extract structures and objects
Tenda1 = EnvData.Tenda1;
Tenda2 = EnvData.Tenda2;
Diorama = EnvData.Diorama;
Floor = EnvData.Floor;
robotPos = EnvData.robotPos;
robotAng = EnvData.robotAng;

% Read the robot model footprint
NS12_footprint = NS12_model();

% Rotate and translate the robot footprint
tip_180(:,:,1) = NS12_footprint.tip.MESH_180(:,:,1)*cosd(robotAng) - NS12_footprint.tip.MESH_180(:,:,2)*sind(robotAng) + robotPos(1);
tip_180(:,:,2) = NS12_footprint.tip.MESH_180(:,:,1)*sind(robotAng) + NS12_footprint.tip.MESH_180(:,:,2)*cosd(robotAng) + robotPos(2);
tip_180(:,:,3) = NS12_footprint.tip.MESH_180(:,:,3)+robotPos(3);
tip_360(:,:,1) = NS12_footprint.tip.MESH_360(:,:,1)*cosd(robotAng) - NS12_footprint.tip.MESH_360(:,:,2)*sind(robotAng) + robotPos(1);
tip_360(:,:,2) = NS12_footprint.tip.MESH_360(:,:,1)*sind(robotAng) + NS12_footprint.tip.MESH_360(:,:,2)*cosd(robotAng) + robotPos(2);
tip_360(:,:,3) = NS12_footprint.tip.MESH_360(:,:,3)+robotPos(3);
elbow_180(:,:,1) = NS12_footprint.elbow.MESH_180(:,:,1)*cosd(robotAng) - NS12_footprint.elbow.MESH_180(:,:,2)*sind(robotAng) + robotPos(1);
elbow_180(:,:,2) = NS12_footprint.elbow.MESH_180(:,:,1)*sind(robotAng) + NS12_footprint.elbow.MESH_180(:,:,2)*cosd(robotAng) + robotPos(2);
elbow_180(:,:,3) = NS12_footprint.elbow.MESH_180(:,:,3)+robotPos(3);
elbow_360(:,:,1) = NS12_footprint.elbow.MESH_360(:,:,1)*cosd(robotAng) - NS12_footprint.elbow.MESH_360(:,:,2)*sind(robotAng) + robotPos(1);
elbow_360(:,:,2) = NS12_footprint.elbow.MESH_360(:,:,1)*sind(robotAng) + NS12_footprint.elbow.MESH_360(:,:,2)*cosd(robotAng) + robotPos(2);
elbow_360(:,:,3) = NS12_footprint.elbow.MESH_360(:,:,3)+robotPos(3);

load MESH_comaunNS12_1.mat

% Rotate and traslate NS12 cad
CAD_NS12.vert(:,1) = MESH.vertices(:,1)*cosd(robotAng) - MESH.vertices(:,2)*sind(robotAng) + robotPos(1);
CAD_NS12.vert(:,2) = MESH.vertices(:,1)*sind(robotAng) + MESH.vertices(:,2)*cosd(robotAng) + robotPos(2);
CAD_NS12.vert(:,3) = MESH.vertices(:,3)+robotPos(3);
CAD_NS12.faces = MESH.faces;

load MESH_OperationArea.mat

% Rotate and translate operational area cad
OpArea.vert(:,1) = MESH.vertices(:,1)*cosd(robotAng) - MESH.vertices(:,2)*sind(robotAng) + robotPos(1);
OpArea.vert(:,2) = MESH.vertices(:,1)*sind(robotAng) + MESH.vertices(:,2)*cosd(robotAng) + robotPos(2);
OpArea.vert(:,3) = MESH.vertices(:,3)+robotPos(3);
OpArea.faces = MESH.faces;

if EnvData.diorama.x > EnvData.diorama.y
    distance = abs(EnvData.diorama.center(2)-robotPos(2));
else
    distance = abs(EnvData.diorama.center(1)-robotPos(1));
end

fprintf('Distance from diorama: %f mm\n',distance)
fprintf('Robot coordinates (from bottom left tents angle): [%.2f, %.2f, %.2f] mm\n',robotPos(1:3))

%% Show Environment: reachable space of the tip for AX1 in [-90 90]

f1 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

PlotEnvElements(Tenda1,Tenda2,Diorama,Floor)

subtitle(strcat('Tip reachability with AX1 in [-90, 90]. Distance from diorama:', num2str(distance),'mm'))

surf(tip_180(:,:,1),tip_180(:,:,2),tip_180(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space: AX5', 'Robot origin', 'Origin', 'FontSize', 14)

view(3)

set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])

%% Show Environment: reachable space of the tip for AX1 in [-180 180]

f2 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

PlotEnvElements(Tenda1,Tenda2,Diorama,Floor)

subtitle(strcat('Tip reachability with AX1 in [-180, 180]. Distance from diorama:', num2str(distance),'mm'))

surf(tip_360(:,:,1),tip_360(:,:,2),tip_360(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space: AX5', 'Robot origin', 'Origin', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])

%% Show Environment: elbow footprint for AX1 in [-90 90]

f3 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

PlotEnvElements(Tenda1,Tenda2,Diorama,Floor)

subtitle(strcat('AX3 elbow footprint with AX1 in [-90, 90]. Distance from diorama:', num2str(distance),'mm'))

surf(elbow_180(:,:,1),elbow_180(:,:,2),elbow_180(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space: AX3', 'Robot origin', 'Origin', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])


%% Show Environment: elbow footprint for AX1 in [-180 180]

f4 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

PlotEnvElements(Tenda1,Tenda2,Diorama,Floor)

subtitle(strcat('AX3 elbow footprint with AX1 in [-180, 180]. Distance from diorama:', num2str(distance),'mm'))

surf(elbow_360(:,:,1),elbow_360(:,:,2),elbow_360(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space: AX3', 'Robot origin', 'Origin', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])


%% Show Environment: elbow footprint for AX1 in [-180 180]

f5 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

PlotEnvElements(Tenda1,Tenda2,Diorama,Floor)

subtitle(strcat('AX3 elbow footprint with AX1 in [-180, 180]. Distance from diorama:', num2str(distance),'mm'))

m = trisurf(OpArea.faces,OpArea.vert(:,1),OpArea.vert(:,2),OpArea.vert(:,3),'FaceColor','none','EdgeColor',[0 0 0]);axis equal;hold on;
m.EdgeAlpha = 1;
m.LineStyle = ':';

scatter3(robotPos(1),robotPos(2),robotPos(3),30,'b', 'filled')
scatter3(0,0,0,90,'r','filled')

m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Tenda1', 'Tenda2', 'Diorama', 'Floor', 'Reachable Space AX5 from CAD', 'Robot origin', 'Origin', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])

%% DIORAMA coverage

figure


if EnvData.diorama.x > EnvData.diorama.y

    area([-1e4 1e4 ],[1e4; 1e4],"FaceColor","k"); hold on
    
    levels = [min(tip_360(:,:,2),[],"all"),EnvData.diorama.center(2)];

    contourf(tip_360(:,:,1),tip_360(:,:,3),tip_360(:,:,2),levels)

    colormap(bone(2)); colorbar;
    axis('equal'); grid on; xlabel('X'); ylabel('Y')
    legend("Not reachable area")

    xlim([EnvData.diorama.center(1)-EnvData.diorama.x/2,EnvData.diorama.center(1)+EnvData.diorama.x/2])
    ylim([EnvData.diorama.center(3)-EnvData.diorama.z/2,EnvData.diorama.center(3)+EnvData.diorama.z/2])

else

    area([-1e4 1e4 ],[1e4; 1e4],"FaceColor","k"); hold on

    levels = [min(-tip_360(:,:,1),[],"all"),-EnvData.diorama.center(1)];

    contourf(tip_360(:,:,2),tip_360(:,:,3),-tip_360(:,:,1),levels,"Fill","on")

    colormap(bone(2)); colorbar;
    axis('equal'); grid on; xlabel('X'); ylabel('Y')
    legend("Not reachable area")

    xlim([EnvData.diorama.center(2)-EnvData.diorama.y/2,EnvData.diorama.center(2)+EnvData.diorama.y/2])
    ylim([EnvData.diorama.center(3)-EnvData.diorama.z/2,EnvData.diorama.center(3)+EnvData.diorama.z/2])

end

title("Diorama coverage")


