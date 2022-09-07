% Simulation callback script for mars_rover_ex_1b model

% Copyright 2022 The MathWorks, Inc

model = 'mars_rover_ex_1b';
if ~exist('mapp') 
    mars_rover_app
elseif ~isvalid(mapp)
    mars_rover_app
end


% roverPath.x = [roverPath.x(1); roverPath.x(end)];
% roverPath.y = [roverPath.y(1); roverPath.y(end)];

cla(mapp.RockDetectionAxes);
cla(mapp.OnlinePathPlansAxes);
cla(mapp.OutputAxes_1);
cla(mapp.OutputAxes_2);
cla(mapp.OutputAxes_3);
cla(mapp.OutputAxes_4);
% I_rockDet = imread('rockDetectionUnavaibleEx1Img.png');
% imshow(I_rockDet,'Parent',mapp.RockDetectionAxes);

plotSurfaceForCamera( mapp.RightNavCamAxes,Terrain.xg,Terrain.yg,Terrain.z_heights,Terrain.znew,...
    [roverPath.x,...
    roverPath.y,...
    roverPath.z]);
plotSurfaceForCamera(mapp.LeftNavCamAxes,Terrain.xg,Terrain.yg,Terrain.z_heights,Terrain.znew,...
    [roverPath.x,...
    roverPath.y,...
    roverPath.z]);

mapp.SimulateButtonEx1.Enable = 'on';
mapp.SimulateButtonEx1.Text = 'Stop';
mapp.statusLabel.Text = 'Running';

blk_R = [model '/Perception/sceneViewer/Right/RCam'];
listner_R =  @(app, event) plotRuntimeCameraR(app,mapp.RightNavCamAxes);
h_R  = add_exec_event_listener(blk_R, ...
    'PostOutputs', listner_R);

blk_L = [model '/Perception/sceneViewer/Left/LCam'];
listner_L =  @(app1, event1) plotRuntimeCameraL(app1,mapp.LeftNavCamAxes);
h_L   = add_exec_event_listener(blk_L, ...
    'PostOutputs', listner_L);


clear plotRuntimePoseEstimates
blk_poseEst = [model '/Mars Rover Plant/Rover Plant Model/Rover Pose Sensing/Kalman Filter/Pose Estimation Outputs'];
listner_poseEst =  @(app1, event1) plotRuntimePoseEstimates(app1,mapp.OutputAxes_4);
h_poseEst   = add_exec_event_listener(blk_poseEst, ...
    'PostOutputs', listner_poseEst);

clear plotRuntimePoseEx1b;

blk_pose = [model '/Mars Rover Plant/Rover Plant Model/Rover Pose Sensing/Kalman Filter/RoverNavTopView'];
listner_pose =  @(app, event) plotRuntimePoseEx1b(app,mapp.OnlinePathPlansAxes);
h_pose  = add_exec_event_listener(blk_pose, ...
'PostOutputs', listner_pose);

mapp.TabGroup.SelectedTab = mapp.RoverCamsTab;

SM_openFrames = javaMethodEDT('getFrames', 'java.awt.Frame');
for idx = 1:numel(SM_openFrames)
    if strcmp(char(SM_openFrames(idx).getName),'MechEditorDTClientFrame')
        if strcmp(char(SM_openFrames(idx).getClient),'Mechanics Explorer-sm_mars_rover')
            javaMethodEDT('hide', SM_openFrames(idx));
        end
    end
end
figure(mapp.MarsRoverNavigationAppUIFigure);
% [18.9,18.1]
%[19.9,17.7]