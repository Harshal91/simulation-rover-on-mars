function plotRuntimePose(block,ax)

% Function to plot Rover pose during simulation.

% Copyright 2022 The MathWorks, Inc

outport1 = block.OutputPort(1);
outport2 = block.OutputPort(2);
outport3 = block.OutputPort(3);
outport4 = block.OutputPort(4);
outport5 = block.OutputPort(5);
outport6 = block.OutputPort(6);
outport7 = block.OutputPort(7);
outport8 = block.OutputPort(8);


pose = outport1.Data;
originalPath = outport2.Data;
originalPath(:,3) = 6;
newPath = outport3.Data;
newPath(:,3) = 6;
obsLocation =outport4.Data;
xg = outport5.Data;
yg = outport6.Data;
z_heights = outport7.Data;
znew = outport8.Data;

obsL = obsLocation(find(obsLocation(:,1)),:);

if isempty(obsL)
       obsL = [0 0 0];
end
obsL(:,3) = 6;

persistent counter_pose  marker_h lastPath lastObsLocation count_obs count_path;

if isempty(counter_pose)
    counter_pose = 1;
    count_obs = 1;
    count_path = 1;
    cla(ax);
    hold(ax,'on')    
    % Set background color
    set(ax,'Color',[209 181 169]/255);
    daspect(ax,[1 1 1])
    % Plot Surface
    [Xg, Yg] = ndgrid(xg, yg);

    surf( ax ,Xg, Yg, znew-8e-2,'FaceAlpha',1,'EdgeAlpha',0.3,...
        'FaceColor',[0.702 0.3216 0.1059]*0.8,'edgecolor','none','DisplayName','Terrain data')

    surf( ax ,Xg, Yg, z_heights,'FaceAlpha',1,'EdgeAlpha',0.1,...
        'FaceColor',([187 109 63]/255)*1.1,'edgecolor','none','DisplayName','Terrain data');

    material(ax,"dull")
    % Set camera as perspective view
    camproj(ax,'perspective')
    % Set camera view anlge as manual
    light(ax,'Style','infinite')
    lighting(ax,'gouraud')
    
    plot3(ax,originalPath(:,1),originalPath(:,2),originalPath(:,3),'--','LineWidth',1.5,'Color',[0 0 1],'DisplayName','Original planned path');
    plot3(ax,originalPath(1,1),originalPath(1,2),originalPath(1,3),'s','MarkerSize',10,'LineWidth',2,'Color',[1 0 1],'DisplayName','Start location');
    plot3(ax,originalPath(end,1),originalPath(end,2),originalPath(end,3),'O','MarkerSize',15,'LineWidth',2,'Color',[0 1 0],'DisplayName','Goal location');
    lastPath = originalPath;
         
    lastObsLocation = obsLocation;
    
    marker_h = plot3(ax,pose(1),pose(2),6,'s','MarkerSize',12,'LineWidth',3,'Color',[1.0 1.0 0.8],'DisplayName','Rover');   
    legend(ax,'Location','best')
    hold(ax,'off')
    view(ax,2)  
end


hold(ax,"on")
if any(obsLocation(:) ~= lastObsLocation(:))
plot3(ax,obsL(:,1),obsL(:,2),obsL(:,3),'O','MarkerSize',12,'LineWidth',2,'Color',[1/count_obs 0 0],'DisplayName',['Detected rocks on path ', num2str(count_obs)]);
count_obs =count_obs + 1;
lastObsLocation = obsLocation;
end
if any(newPath(:) ~= lastPath(:))
    plot3(ax,newPath(:,1),newPath(:,2),newPath(:,3),'--','LineWidth',1.5,'Color',[1 1/count_path 0],'DisplayName',['New planned path', num2str(count_path)]);
    count_path = count_path + 1;
    lastPath = newPath;
end
marker_h.XData = pose(1);
marker_h.YData = pose(2);
marker_h.ZData = 6;

hold(ax,'off')

pause(0.005)

%
% refPath = outport1.Data;
% plot(ax,refPath(1),refPath(2),'*','MarkerSize',10);
% pause(0.005)

end