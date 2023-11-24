function [EnvData] = ReadEnvironmentData(FileName)

EnvFile = ReadYaml(FileName);

% Tenda 1
tenda1.x = EnvFile.tenda1x;
tenda1.y = EnvFile.tenda1y;
tenda1.z = EnvFile.tenda1z;
tenda1.origin = cell2mat(EnvFile.tenda1_origin);
tenda1.center = [tenda1.origin(1)+tenda1.x/2;...
                 tenda1.origin(2)+tenda1.y/2;...
                 tenda1.origin(3)+tenda1.z/2];

% Tenda 2
tenda2.x = EnvFile.tenda2x;
tenda2.y = EnvFile.tenda2y;
tenda2.z = EnvFile.tenda2z;
tenda2.origin = cell2mat(EnvFile.tenda2_origin);
tenda2.center = [tenda2.origin(1)+tenda2.x/2;...
                 tenda2.origin(2)+tenda2.y/2;...
                 tenda2.origin(3)+tenda2.z/2];

% diorama
diorama.x = EnvFile.dioramax;
diorama.y = EnvFile.dioramay;
diorama.z = EnvFile.dioramaz;
diorama.origin = cell2mat(EnvFile.diorama_origin);
diorama.center = [diorama.origin(1)+diorama.x/2;...
                  diorama.origin(2)+diorama.y/2;...
                  diorama.origin(3)+diorama.z/2];

% floor
floor.x = EnvFile.floorx;
floor.y = EnvFile.floory;
floor.z = EnvFile.floorz;
floor.origin = cell2mat(EnvFile.floor_origin);
floor.center = [floor.origin(1)+floor.x/2;...
                floor.origin(2)+floor.y/2;...
                floor.origin(3)+floor.z/2];


Tenda1 = collisionBox(tenda1.x, tenda1.y, tenda1.z);
Tenda2 = collisionBox(tenda2.x, tenda2.y, tenda2.z);
Diorama = collisionBox(diorama.x, diorama.y, diorama.z);
Floor = collisionBox(floor.x, floor.y, floor.z);

Tenda1.Pose =  [eye(3) tenda1.center;  zeros(1,3) 1];
Tenda2.Pose =  [eye(3) tenda2.center;  zeros(1,3) 1];
Diorama.Pose = [eye(3) diorama.center; zeros(1,3) 1];
Floor.Pose =   [eye(3) floor.center;   zeros(1,3) 1];


% Robot
robotPos = [EnvFile.robotPosx, EnvFile.robotPosy, EnvFile.robotPosz];
robotAng = EnvFile.robotAng;


% Allocate variables for the output
EnvData.tenda1 = tenda1;
EnvData.Tenda1 = Tenda1;
EnvData.tedna2 = tenda2;
EnvData.Tenda2 = Tenda2;
EnvData.diorama = diorama;
EnvData.Diorama = Diorama;
EnvData.floor = floor;
EnvData.Floor = Floor;
EnvData.robotPos = robotPos;
EnvData.robotAng = robotAng;






end

