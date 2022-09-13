%% Script to setup parameters for the mars_rover model 

% Copyright 2021-2022 The MathWorks, Inc

%% Mars Rover Params

run('rover_params') ; 

%% Rigid Terrain Params

run('rover_rigid_terrain_params');

%% Sample Position

sample_position = [72.3000   30.4729  3.5231]; 

%% Rover Path Planning and Control Params
load('roverPath1.mat')
load('roverPath2.mat')
% roverPath = rover_path1;
goal_loc = [roverPath.x(end) roverPath.y(end)];
% Points for visualizing the waypoints
pointCloudPath = [roverPath.x  roverPath.y roverPath.z];
cam_base_angle = 0;
cam_target_angle = 20;
mapData = false(197,200);


cam_pan_ex1 = [0 90];
cam_pitch_ex1 = 10;

detectionThreshold_ex2 = 0.55;
cam_pan_ex2 = [-90 90];
rover_path_ex1.x = [5 ; 13];
rover_path_ex1.y = [24 ; 24];
rover_path_ex1.z = [2.1550 ; 3.5076];
point_cloud_path_ex1 = [5.0000   24.0000    2.1550
   13.0000   24.0000    3.0468];

%% Rover Arm Params
run('rover_arm_params');
Arm.arm_q0 =  [-2.3554 -125.9144   49.8193 -175.7336  177.6446  180.0000];
%% Rover Arm Planning And Control
load('roverArmTaskSpaceConfig.mat');

%% Rover Camera Assmebly Params
run('rover_camera_params') ;
