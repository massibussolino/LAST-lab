function [NS12_footprint] = NS12_model()


% Read the screashot of the cad
I = imread("NS12-185_sideview.PNG");

%% Maximum footprint of the tip and elbow joint

% Plot translate and scale the side view
figure("Name","Ingombro tip e gomito AX3")
Im = imshow(I(end:-1:1,end:-1:1,:)); hold on
Im.AlphaData = 0.5;

% Scale factor to make the image compatible with the arm dimenstions
scale_factor = 1850.37/394;
Im.XData = (Im.XData-298)*scale_factor; %Change data if the image get changed
Im.YData = (Im.YData-242)*scale_factor; %Change data if the image get changed


axis on; axis equal;
xlim([min(Im.XData),max(Im.XData)]);
ylim([min(Im.YData),max(Im.YData)]);
set(gca,'XDir','reverse','YDir','normal','XAxisLocation','origin','YAxisLocation','origin')


% Define relevant parmaeters
AX2_center = [300, 600];
AX2_arm = 700;
AX2_limits = -([+155,-60]-90); % angles transformed according to new reference frame
AX3_center = [300, 700];
AX3_arm = 850.37;

tip_thick = 0;
elbow_thick = 360;


%% Computation of the equatorial plane

NS12_footprint.tip.equator_f.c = [0,0];
NS12_footprint.tip.equator_f.r = AX2_center(1)+AX2_arm+AX3_arm+tip_thick;
NS12_footprint.tip.equator_b.c = [0,0];
NS12_footprint.tip.equator_b.r = 1156.59; % directly from side view figure
NS12_footprint.tip.equator_f.h = AX2_center(2);
NS12_footprint.tip.equator_b.h = 900;     % directly from side view figure

NS12_footprint.elbow.equator_f.c = [0,0];
NS12_footprint.elbow.equator_f.r = AX2_arm+elbow_thick;
NS12_footprint.elbow.equator_b.c = [0,0];
NS12_footprint.elbow.equator_b.r = (AX2_arm+elbow_thick)*cosd(25);
NS12_footprint.elbow.equator_f.h = AX2_center(2);
NS12_footprint.elbow.equator_b.h = 600+(AX2_arm+elbow_thick)*sind(25);  


% AX3 reachability with AX2 in [-60, 155]
r = AX2_arm+elbow_thick;
c = AX2_center;
th = AX2_limits(1):0.01:AX2_limits(2)+5;
xx = r*cosd(th)+c(1);
yy = r*sind(th)+c(2);
plot(xx,yy,'--b')

NS12_footprint.elbow.centre = c;
NS12_footprint.elbow.radius = r;
NS12_footprint.elbow.ranges = [-65, 155];

% AX5 joint footprint
% max extension (AX2 in [-60 155], AX3 fully distended)
r = AX2_arm+AX3_arm+tip_thick;
c = AX2_center;
th = AX2_limits(1):0.01:AX2_limits(2);
xx = r*cosd(th)+c(1);
yy = r*sind(th)+c(2);
plot(xx,yy,'--r')

NS12_footprint.tip.centre(1,:) = c;
NS12_footprint.tip.radius(1) = r;
NS12_footprint.tip.ranges(1,:) = AX2_limits;

% AX2 in 150, AX3 in [-75 0]
r = AX3_arm+tip_thick;
c = [AX2_center(1)+AX2_arm*cosd(AX2_limits(2)),AX2_center(2)+AX2_arm*sind(AX2_limits(2))];
th = AX2_limits(2):0.01:270;
xx = r*cosd(th)+c(1);
yy = r*sind(th)+c(2);
plot(xx,yy,'--r')

NS12_footprint.tip.centre(2,:) = c;
NS12_footprint.tip.radius(2) = r;
NS12_footprint.tip.ranges(2,:) = [AX2_limits(2), 270];

% AX2 in +155, AX3 in [0 90]
r = AX3_arm+tip_thick;
c = [AX2_center(1)+AX2_arm*cosd(AX2_limits(1)),AX2_center(2)+AX2_arm*sind(AX2_limits(1))];
th = AX2_limits(1):-0.01:-150;
xx = r*cosd(th)+c(1);
yy = r*sind(th)+c(2);
plot(xx,yy,'--r')

NS12_footprint.tip.centre(3,:) = c;
NS12_footprint.tip.radius(3) = r;
NS12_footprint.tip.ranges(3,:) = [-150, AX2_limits(1)];

legend('elbow footprint','tip footprint')


% Compute the meshes for the 3D plot (+- 90 rotation)

% TIP: arch 1-3

xx = []; yy = []; zz = [];
for i = [3 1 2]
    theta = linspace(-90,90,30);
    phi = 90-linspace(NS12_footprint.tip.ranges(i,1),NS12_footprint.tip.ranges(i,2),30);

    [Theta, Phi] = meshgrid(theta, phi);
    
    x = (NS12_footprint.tip.radius(i) * sind(Phi) .* cosd(Theta)) + NS12_footprint.tip.centre(i,1).*cosd(theta);
    y = (NS12_footprint.tip.radius(i) * sind(Phi) .* sind(Theta)) + NS12_footprint.tip.centre(i,1).*sind(theta);
    z = (NS12_footprint.tip.radius(i) * cosd(Phi)) + NS12_footprint.tip.centre(i,2);

    xx = [xx; x]; yy = [yy; y]; zz = [zz; z];

end

NS12_footprint.tip.MESH_180(:,:,1) = xx;
NS12_footprint.tip.MESH_180(:,:,2) = yy;
NS12_footprint.tip.MESH_180(:,:,3) = zz;

% elbow 

theta = linspace(-90,90,30);
phi = 90-linspace(NS12_footprint.elbow.ranges(1),NS12_footprint.elbow.ranges(2),30);

[Theta, Phi] = meshgrid(theta, phi);

x = (NS12_footprint.elbow.radius * sind(Phi) .* cosd(Theta)) + NS12_footprint.elbow.centre(1).*cosd(theta);
y = (NS12_footprint.elbow.radius * sind(Phi) .* sind(Theta)) + NS12_footprint.elbow.centre(1).*sind(theta);
z = (NS12_footprint.elbow.radius * cosd(Phi)) + NS12_footprint.elbow.centre(2);

NS12_footprint.elbow.MESH_180(:,:,1) = x;
NS12_footprint.elbow.MESH_180(:,:,2) = y;
NS12_footprint.elbow.MESH_180(:,:,3) = z;

% Compute the mesh for the 3D plot (360°)

% TIP: acrch 1-3
xx = []; yy = []; zz = [];
for i = [3 1]
    theta = linspace(0,360,30);

    phi = 90-linspace(max(-90,NS12_footprint.tip.ranges(i,1)),min(90,NS12_footprint.tip.ranges(i,2)),30);

    [Theta, Phi] = meshgrid(theta, phi);
    
    x = (NS12_footprint.tip.radius(i) * sind(Phi) .* cosd(Theta)) + NS12_footprint.tip.centre(i,1).*cosd(theta);
    y = (NS12_footprint.tip.radius(i) * sind(Phi) .* sind(Theta)) + NS12_footprint.tip.centre(i,1).*sind(theta);
    z = (NS12_footprint.tip.radius(i) * cosd(Phi)) + NS12_footprint.tip.centre(i,2);

    xx = [xx; x]; yy = [yy; y]; zz = [zz; z];

end

NS12_footprint.tip.MESH_360(:,:,1) = xx;
NS12_footprint.tip.MESH_360(:,:,2) = yy;
NS12_footprint.tip.MESH_360(:,:,3) = zz;

% elbow 

theta = linspace(0,360,30);
phi = 90-linspace(NS12_footprint.elbow.ranges(1),NS12_footprint.elbow.ranges(2),30);

[Theta, Phi] = meshgrid(theta, phi);

x = (NS12_footprint.elbow.radius * sind(Phi) .* cosd(Theta)) + NS12_footprint.elbow.centre(1).*cosd(theta);
y = (NS12_footprint.elbow.radius * sind(Phi) .* sind(Theta)) + NS12_footprint.elbow.centre(1).*sind(theta);
z = (NS12_footprint.elbow.radius * cosd(Phi)) + NS12_footprint.elbow.centre(2);

NS12_footprint.elbow.MESH_360(:,:,1) = x;
NS12_footprint.elbow.MESH_360(:,:,2) = y;
NS12_footprint.elbow.MESH_360(:,:,3) = z;




end