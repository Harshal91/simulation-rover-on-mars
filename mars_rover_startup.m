%% Script to setup the rover navigation app and the mars_rover simulink model 

% Copyright 2021-2022 The MathWorks, Inc

addpath('mars_rover_helpers')
addpath('mars_rover_data')
addpath('mars_rover_yolov2_dl')
mars_rover_params
[goal_loc,roverPath,sample_position,pointCloudPath] = rover_path_select(3);

mapData = false(197,200);
mapp = MarsRoverNavigationApp;

pause(2);

d = uiprogressdlg(mapp.MarsRoverNavigationAppUIFigure,'Title','Initializing',...
        'Message','Initializing project...');
pause(0.005);

d.Value = .25; 
d.Message = 'Loading exercise 1';
pause(0.005)

model = 'mars_rover_ex_1a';
load_system(model);

set_param(model,'SimulationCommand','update');
% SM_openFrames = javaMethodEDT('getFrames', 'java.awt.Frame');
% for idx = 1:numel(SM_openFrames)
%     if strcmp(char(SM_openFrames(idx).getName),'MechEditorDTClientFrame')
%         javaMethodEDT('hide', SM_openFrames(idx));
%     end
% end
mapp.TabGroup.SelectedTab = mapp.PathPlannerTab;

model = 'mars_rover_ex_1b';
load_system(model);

set_param(model,'SimulationCommand','update');

% mars_rover_ex_1b([],[],[],'compile')
% % SM_openFrames = javaMethodEDT('getFrames', 'java.awt.Frame');
% % for idx = 1:numel(SM_openFrames)
% %     if strcmp(char(SM_openFrames(idx).getName),'MechEditorDTClientFrame')
% %         javaMethodEDT('hide', SM_openFrames(idx));
% %     end
% % end
% mars_rover_ex_1b([],[],[],'term')
mapp.TabGroup.SelectedTab = mapp.PathPlannerTab;

model = 'mars_rover_ex_2';
load_system(model);


d.Value = .5; 
d.Message = 'Loading exercise 2';
pause(0.005)

set_param(model,'SimulationCommand','update');

% mars_rover_ex_2([],[],[],'compile')
% % SM_openFrames = javaMethodEDT('getFrames', 'java.awt.Frame');
% % for idx = 1:numel(SM_openFrames)
% %     if strcmp(char(SM_openFrames(idx).getName),'MechEditorDTClientFrame')
% %         javaMethodEDT('hide', SM_openFrames(idx));
% %     end
% % end
% mars_rover_ex_2([],[],[],'term')
mapp.TabGroup.SelectedTab = mapp.PathPlannerTab;


d.Value = .75; 
d.Message = 'Loading exercise 3';
pause(0.005)

model = 'mars_rover_ex_3';
load_system(model);

set_param(model,'SimulationCommand','update');
setMechExplorerVisibility(model, 'hide');
% mars_rover_ex_3([],[],[],'compile')
% % SM_openFrames = javaMethodEDT('getFrames', 'java.awt.Frame');
% % for idx = 1:numel(SM_openFrames)
% %     if strcmp(char(SM_openFrames(idx).getName),'MechEditorDTClientFrame')
% %         javaMethodEDT('hide', SM_openFrames(idx));
% %     end
% % end
% mars_rover_ex_3([],[],[],'term')
mapp.TabGroup.SelectedTab = mapp.PathPlannerTab;

d.Value = 1; 
d.Message = 'Initialization complete.';
pause(0.005)

close(d)