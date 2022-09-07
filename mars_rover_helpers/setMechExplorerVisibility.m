function setMechExplorerVisibility(model,flag)

SM_openFrames = javaMethodEDT('getFrames', 'java.awt.Frame');
for idx = 1:numel(SM_openFrames)
    if strcmp(char(SM_openFrames(idx).getName),'MechEditorDTClientFrame') % For MATLAB Online
        if isempty(string(SM_openFrames(idx).getClient))
            javaMethodEDT('dispose', SM_openFrames(idx));
        elseif contains(string(SM_openFrames(idx).getClient.getName),string(model))
            javaMethodEDT(flag, SM_openFrames(idx));
        end
    end
end

end