%% Script to setup the rover navigation app and the mars_rover simulink model 

% Copyright 2021-2022 The MathWorks, Inc
tic

flag1a = false;
flag1b = false;
flag2 = false;
flag3 = false;
addpath('mars_rover_helpers')
addpath('mars_rover_data')
addpath('mars_rover_yolov2_dl')

mapp = MarsRoverNavigationApp;
% mapp.RightPanel.Visible = 'off';
d = uiprogressdlg(mapp.MarsRoverNavigationAppUIFigure,'Title','Initializing',...
        'Message','Loading Map...');
d.ShowPercentage = "on";

%%
d.Value = .15; 
mapData = false(197,200);

mars_rover_params
[goal_loc,roverPath,sample_position,pointCloudPath] = rover_path_select(1);

d.Value = .25; 
d.Message = 'Loading exercise 1';
pause(0.005)
mapp.Exercise1Panel.Collapsed = false;
id = 'Simulink:Engine:NonTunableVarChangedInFastRestart';
warning('off',id)

warning('off','Simulink:Engine:NonTunableVarChangedMaxWarnings');

%% setup models

model1a = 'mars_rover_ex_1a';

if ~bdIsLoaded(model1a)
    load_system(model1a);   
    flag1a = true;
end

model1b = 'mars_rover_ex_1b';

if ~bdIsLoaded(model1b)
    load_system(model1b);
    flag1b = true;
end

d.Value = .5; 
d.Message = 'Loading exercise 2';
pause(0.005)
mapp.Exercise1Panel.Collapsed = true;
mapp.Exercise2Panel.Collapsed = false;

model2 = 'mars_rover_ex_2';
if ~bdIsLoaded(model2)
    load_system(model2);
    flag2 = true;
end

d.Value = .75; 
d.Message = 'Loading exercise 3';
pause(0.005)

mapp.Exercise2Panel.Collapsed = true;
mapp.Exercise3Panel.Collapsed = false;

model3 = 'mars_rover_ex_3';

if ~bdIsLoaded(model3)
    load_system(model3);
    flag3 = true;
end

%% Compile models

d.Value = .75; 
d.Message = 'Updating models (this may take a few mins)...';
mapp.Exercise3Panel.Collapsed = true;
model3 = 'mars_rover_ex_3';

if flag3     
    origText = mapp.SimulateButtonEx3.Text;
      
    st_orig = get_param(model3,'StopTime');
    set_param(model3,'StopTime','0.3');
    set_param(model3,'FastRestart','on'); 
    sim(model3);
    set_param(model3,'StopTime',st_orig);
    mapp.SimulateButtonEx3.Text = origText;
    mapp.SimulateButtonEx3.Enable = 'off';
    flag3 = false;
    setMechExplorerVisibility(model3,'hide');   
end

d.Value = .8; 

model2 = 'mars_rover_ex_2';

if flag2
    origText = mapp.SimulateButtonEx2.Text;
    set_param(model2,'FastRestart','on');
    st_orig = get_param(model2,'StopTime');
    set_param(model2,'StopTime','1');
    sim(model2);
    set_param(model2,'StopTime',st_orig);
    mapp.SimulateButtonEx2.Text = origText;
    flag2 = false;
end

d.Value = .85; 

model1b = 'mars_rover_ex_1b';

if flag1b
    origText = mapp.SimulateButtonEx1.Text;
    set_param(model1b,'FastRestart','on');
    st_orig = get_param(model1b,'StopTime');
    set_param(model1b,'StopTime','1');
    sim(model1b);
    set_param(model1b,'StopTime',st_orig);
    mapp.SimulateButtonEx1.Text = origText;
    mapp.SimulateButtonEx1.Enable = 'off';
    flag1b = false;
end

model1a = 'mars_rover_ex_1a';

if flag1a  
    origText = mapp.SimulateButtonEx1a.Text;
    set_param(model1a,'FastRestart','on');
    st_orig = get_param(model1a,'StopTime');
    set_param(model1a,'StopTime','1');
    sim(model1a);
    set_param(model1a,'StopTime',st_orig);
    mapp.SimulateButtonEx1a.Text = origText;
    mapp.SimulateButtonEx1.Enable = 'off';
    flag1a = false;
end
% 

d.Value = .92; 
pause(5)
d.Value = 1; 
d.Message = 'Initialization complete.';
mapp.TabGroup.SelectedTab = mapp.PathPlannerTab;
close all

pause(5)
close(d)
drawnow

