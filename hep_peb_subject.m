function [PEB, BMA] = hep_peb_subject(s,X)  

%% 1. Set parameters and path
% -------------------------------------------------------------------------
% Set paths and file names
% -------------------------------------------------------------------------
fprintf(['Subject: ', num2str(s),'\n\n'])
% home_dir = pwd;
analysis_dir = '/Volumes/Elements4/heartbeat/DCM_average_timeseries';
cd(analysis_dir)
%% 2.  Get GCM and create PEB regressors

%% Create GCM
GCM = cell(0,0);
for t = 1:232
        all_files = dir(fullfile(['/Volumes/Elements4/heartbeat/DCM_average_timeseries/DCM_P', sprintf( '%02d', s ), '_',num2str(t), '.mat']));
        try
        GCM_i = {all_files.name};
        GCM(t,1) = GCM_i;
        end
end

 M = struct();
 M.X = X;


field = {'A'};
% Estimate model
[PEB , GCM]    = spm_dcm_peb(GCM,M,field);

end

