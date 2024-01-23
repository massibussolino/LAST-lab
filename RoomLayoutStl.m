% ENVIRONMENT
clear; close all; clc

format long
set(0,'defaultTextInterpreter',         'latex',...
      'DefaultLegendInterpreter',       'latex',...
      'DefaultAxesFontSize',            12,...
      'DefaultLegendFontSize',          15,...
      'DefaultAxesTickLabelInterpreter','latex',...
      'DefaultTextInterpreter',         'latex');

addpath(genpath("documents"))
addpath(genpath("functions"))


%% User defined inputs
robotAng = 90;              % anlge counterclockwise from x axis
robotPos = [2000; 1000; 0]; % Position from bottom left room corner
    
RoomFile = 'Controller_Out_stl.mat';
           %Controller_In_stl.mat

%% Main script

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

load(RoomFile)


%% Show Environment: reachable space of the tip for AX1 in [-90 90]

f1 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

trisurf(MESH.faces,MESH.vertices(:,1),MESH.vertices(:,2),MESH.vertices(:,3),'FaceColor',[0.7 0.7 0.7]);


subtitle('Tip reachability with AX1 in [-90, 90]')

surf(tip_180(:,:,1),tip_180(:,:,2),tip_180(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)

m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Room elements', 'Reachable Space: AX5', 'FontSize', 14)




%% Show Environment: reachable space of the tip for AX1 in [-180 180]

f2 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

trisurf(MESH.faces,MESH.vertices(:,1),MESH.vertices(:,2),MESH.vertices(:,3),'FaceColor',[0.7 0.7 0.7]);

subtitle('Tip reachability with AX1 in [-180, 180]')

surf(tip_360(:,:,1),tip_360(:,:,2),tip_360(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)


m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Room Elements', 'Reachable Space: AX5', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])

%% Show Environment: elbow footprint for AX1 in [-90 90]

f3 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

trisurf(MESH.faces,MESH.vertices(:,1),MESH.vertices(:,2),MESH.vertices(:,3),'FaceColor',[0.7 0.7 0.7]);

subtitle('AX3 elbow footprint with AX1 in [-90, 90]')

surf(elbow_180(:,:,1),elbow_180(:,:,2),elbow_180(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)


m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Room Elements', 'Reachable Space: AX3', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])


%% Show Environment: elbow footprint for AX1 in [-180 180]

f4 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

trisurf(MESH.faces,MESH.vertices(:,1),MESH.vertices(:,2),MESH.vertices(:,3),'FaceColor',[0.7 0.7 0.7]);

subtitle('AX3 elbow footprint with AX1 in [-180, 180]')

surf(elbow_360(:,:,1),elbow_360(:,:,2),elbow_360(:,:,3),'FaceColor','none','LineStyle',':','LineWidth',0.1)


m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Room Elements', 'Reachable Space: AX3', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])


%% Show Environment: elbow footprint for AX1 in [-180 180]

f5 = figure();
hold on; grid on;
%title('Environment', 'FontSize',18)
xlabel('X [mm]', 'FontSize',15)
ylabel('Y [mm]', 'FontSize',15)
zlabel('Z [mm]', 'FontSize',15)
axis equal

trisurf(MESH.faces,MESH.vertices(:,1),MESH.vertices(:,2),MESH.vertices(:,3),'FaceColor',[0.7 0.7 0.7]);

subtitle('AX1 elbow footprint with AX1 in [-180, 180] from CAD')

m = trisurf(OpArea.faces,OpArea.vert(:,1),OpArea.vert(:,2),OpArea.vert(:,3),'FaceColor','none','EdgeColor',[0 0 0]);axis equal;hold on;
m.EdgeAlpha = 1;
m.LineStyle = ':';


m = trisurf(CAD_NS12.faces,CAD_NS12.vert(:,1),CAD_NS12.vert(:,2),CAD_NS12.vert(:,3),'FaceColor',[.9 .1 .1],'EdgeColor',[0.4 0.4 0.4]);axis equal;hold on;
m.EdgeAlpha = 0.1;

legend('Room Elements', 'Reachable Space AX5 from CAD', 'FontSize', 14)
set(gcf,'Units','normalized','Position',[0.2, 0.3, 0.6, 0.5])



