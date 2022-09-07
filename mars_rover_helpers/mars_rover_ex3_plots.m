%% Script to plot the roll pitch yaw angles of the rover

% Copyright 2021-2022 The MathWorks, Inc.

cla(mapp.OutputAxes_1)
cla(mapp.OutputAxes_2)
cla(mapp.OutputAxes_3)
cla(mapp.OutputAxes_4)
pause(0.005);

if exist('sm_mars_rover_out_ex3') ~= 0


    rpy_data = sm_mars_rover_out_ex3.logsout.getElement('RoverRollPitchYaw');
    xyz_data = sm_mars_rover_out_ex3.logsout.getElement('RoverTranslation');

    hold(mapp.OutputAxes_1,'on') ;
    xlabel(mapp.OutputAxes_1,'Time(s)');
    ylabel(mapp.OutputAxes_1,'Rover X (m)');
    plot(mapp.OutputAxes_1,xyz_data.Values.Time,xyz_data.Values.Data(:,1),'r--','LineWidth',2);
    ylim(mapp.OutputAxes_1,'auto')
    hold(mapp.OutputAxes_1,'off');

    hold(mapp.OutputAxes_2,'on') ;
    xlabel(mapp.OutputAxes_2,'Time(s)');
    ylabel(mapp.OutputAxes_2,'Rover Y (m)');
    plot(mapp.OutputAxes_2,xyz_data.Values.Time,xyz_data.Values.Data(:,2),'g--','LineWidth',2);
    ylim(mapp.OutputAxes_2,'auto')
    hold(mapp.OutputAxes_2,'off');

    hold(mapp.OutputAxes_3,'on') ;
    xlabel(mapp.OutputAxes_3,'Time(s)');
    ylabel(mapp.OutputAxes_3,'Rover Yaw (deg)');
    plot(mapp.OutputAxes_3,rpy_data.Values.Time,rpy_data.Values.Data(:,3),'b--','LineWidth',2);
    ylim(mapp.OutputAxes_3,'auto')
    hold(mapp.OutputAxes_3,'off');

    mars_rover_plot_rover_path_fn(mapp.OutputAxes_4,sm_mars_rover_out_ex3,roverPath);
end