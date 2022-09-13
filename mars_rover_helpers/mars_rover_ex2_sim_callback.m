% Simulation callback script for mars_rover_ex_2 model

% Copyright 2022 The MathWorks, Inc


model = 'mars_rover_ex_2';
if ~exist('mapp') 
    mars_rover_app
elseif ~isvalid(mapp)
    mars_rover_app
end

cla(mapp.OutputAxes_1);
cla(mapp.OutputAxes_2);
cla(mapp.OutputAxes_3);
cla(mapp.OutputAxes_4);

plotSurfaceForCamera( mapp.RightNavCamAxes,Terrain.xg,Terrain.yg,Terrain.z_heights,Terrain.znew);
plotSurfaceForCamera(mapp.LeftNavCamAxes,Terrain.xg,Terrain.yg,Terrain.z_heights,Terrain.znew);

mapp.SimulateButtonEx2.Enable = 'on';
mapp.SimulateButtonEx2.Text = 'Stop';
mapp.statusLabel.Text = 'Running';

blk_R = [model '/Perception/sceneViewer/Right/RCam'];
listner_R =  @(app, event) plotRuntimeCameraR(app,mapp.RightNavCamAxes);
h_R  = add_exec_event_listener(blk_R, ...
    'PostOutputs', listner_R);

blk_L = [model '/Perception/sceneViewer/Left/LCam'];
listner_L =  @(app1, event1) plotRuntimeCameraL(app1,mapp.LeftNavCamAxes);
h_L   = add_exec_event_listener(blk_L, ...
    'PostOutputs', listner_L);

blk_DL = [model '/Perception/depthEstimation'];
listner_DL =  @(app1, event1) plotRuntimeRockDetection(app1,mapp.RockDetectionAxes);
h_DL   = add_exec_event_listener(blk_DL, ...
'PostOutputs', listner_DL);

% clear plotRuntimePose;
% blk_pose = [model '/Online Planner/ToApp'];
% listner_pose =  @(app, event) plotRuntimePose(app,mapp.OnlinePathPlansAxes);
% h_pose  = add_exec_event_listener(blk_pose, ...
% 'PostOutputs', listner_pose);


mapp.TabGroup.SelectedTab = mapp.RoverCamsTab;
% 
% SM_openFrames = javaMethodEDT('getFrames', 'java.awt.Frame');
% for idx = 1:numel(SM_openFrames)
%     if strcmp(char(SM_openFrames(idx).getName),'MechEditorDTClientFrame')
%         if strcmp(char(SM_openFrames(idx).getClient),'Mechanics Explorer-sm_mars_rover')
%             javaMethodEDT('hide', SM_openFrames(idx));
%         end
%     end
% end
figure(mapp.MarsRoverNavigationAppUIFigure);
% [18.9,18.1]
%[19.9,17.7]