% DCM analysis
% Aim: Effective connectivity changes between AI and AM related to HEP
% Authors: Katharina, Saurabh, Wouter

% -------------------------------------------------------------------------
% notes
% -------------------------------------------------------------------------

% swalot (job id 33550416)
% P08 and P10: ai-am-ac
% P02, P04, P30: ai-am
% P17: ai-ac
%%%%
% For P17 - the data is 5 seconds shorter as it starts from -5 to 1165 seconds. There was a ictal spike at the baseline and hence instead of the 10 seconds of baseline I only have 5 seconds of baseline for this patient.
%%%%

% -------------------------------------------------------------------------
% set data info
% -------------------------------------------------------------------------
%subjects = [2 4 30]
%subjects = [8 10];
subjects = 17;
fSample = 500;
binSize = 5; %seconds
on_HPC = 0;
% ai_i = 2;
% am_i = 2;
path =  './DCM_average_timeseries';%['DCM_ai', num2str(ai_i), '_am', num2str(am_i)];
%mkdir(path)
%cd(path)

for s = 30%[2 4 30 8 10 17]
    % -------------------------------------------------------------------------
    % set path
    % -------------------------------------------------------------------------
    % open template
    all_files =dir(fullfile(strcat('/Volumes/Elements4/heartbeat/DCM_average_timeseries/DCM_P', sprintf( '%02d', s ), '*')));
    load(strcat('/Volumes/Elements4/heartbeat/DCM_average_timeseries/',all_files(5).name));
    DCM_template = DCM;
    clear DCM
    data_name = strcat('/Volumes/Elements4/heartbeat/data_to_be_used/P', sprintf( '%02d', s ), '_data');
    load(data_name)
    if ismember(s,[8,10])
        data = [mean(ai_data,1); mean(am_data,1); mean(ac_data,1)];
    elseif ismember(s,[2 4 30])
        data = [mean(ai_data,1); mean(am_data,1)];
    elseif ismember(s, [17])
        data = [mean(ai_data,1); mean(ac_data,1)];
    end
    %data = [ai_data(ai_i,:);am_data(am_i,:)];
    % -------------------------------------------------------------------------
    % cut data
    % -------------------------------------------------------------------------
    % discard first 10 seconds (pre-stimulus) --> duration = 1165 seconds.
    % discard  last 5 seconds (credits) --> duration = 1160 seconds.
    if s == 17
        data_cut = data(:, 5*fSample + 1 : (end-5*fSample));
    else
        data_cut = data(:, 10*fSample + 1 : (end-5*fSample));
    end
    
    % -------------------------------------------------------------------------
    % create ftdata
    % -------------------------------------------------------------------------
    ftdata = [];
    ftdata.fsample = fSample;
    if ismember(s,[8,10])
  
        ftdata.label = {'ai', 'am', 'ac'};
    elseif ismember(s,[2 4 30])
        ftdata.label = {'ai', 'am'};
    elseif ismember(s,[17])
                ftdata.label = {'ai', 'ac'};
    end
    % form bins of 10 s
    nTrials = length(data_cut)/fSample/binSize;
    
    for j = 1:nTrials
        ftdata.trial{j} = squeeze(data_cut(:, fSample*binSize * (j-1)+1: fSample*binSize * j));
        ftdata.time{j} = [0:(fSample)*binSize-1]./fSample;
    end
    
    
    %--------------------------------------------------------------------------
    % Convert the ftdata struct to SPM M\EEG dataset
    %--------------------------------------------------------------------------
    fname = ['spm_P', sprintf( '%02d', s )];
    D = spm_eeg_ft2spm(ftdata, fname);
    D = type(D, 'single');                                                  % Sets the dataset type
    D = chantype(D, ':', 'LFP');                                            % Sets the channel type
    for i=1:nTrials
        D = conditions(D, i, ['Condition ', num2str(i)]);
    end
    save(D);
    
    %% step 2: add trial information
    load(fname)
    
    for i=1:nTrials
        D.trials(i).onset = [];
        D.condlist(i) = {num2str(i)};
        D.conditions(i) = {num2str(i)};
    end
    save(['./DCM_average_timeseries',fname],'D')
    address = ['DCM_P', sprintf( '%02d', s)];
    DCM.name = address;
    
    %--------------------------------------------------------------------------
    % Parameters and options used for setting up model
    %--------------------------------------------------------------------------
    
    Nareas = size(data,1);
    %DCM.xY.Ic = [1:Nareas];  % number of channels
    NConditions = length(unique(D.condlist));
    DCM.xY.Dfile = fname;
    DCM.options.analysis = 'CSD';
    DCM.options.model    = 'CMC';
    DCM.options.spatial  = 'LFP'; % spatial model
    DCM.options.Tdcm(1)  = 0;     % start of peri-stimulus time to be modelled
    DCM.options.Tdcm(2)  = binSize*1000;   % end of peri-stimulus time to be modelled
    DCM.options.Nmodes   = Nareas;     % nr of modes for data selection
    DCM.options.h        = 1;     % nr of DCT components
    DCM.options.D        = 1;     % downsampling
    DCM.options.Fdcm(1) = 4;
    DCM.options.Fdcm(2) = 48;
    DCM.options.hann     = 1;     % hanning
    DCM.Lpos = [];
    
    % Location priors for dipoles
    %--------------------------------------------------------------------------
    DCM.Sname = cell(Nareas,1);
    for nel = 1:Nareas; DCM.Sname{nel} = strcat('LFP',num2str(nel)); end
    
    % Spatial model
    %--------------------------------------------------------------------------
    % Specify connectivity model
    %--------------------------------------------------------------------------
    DCM.A = make_model_architecture(1:length(ftdata.label ), 'full');
    DCM.B = {};
    
    
    %--------------------------------------------------------------------------
    % Between trial effects
    %--------------------------------------------------------------------------
    DCM.xU.X = [];
    DCM.xU.name = {};
    %DCM = spm_dcm_erp_dipfit(DCM);
    
    %%%%%%%%%%%%%%%
    
    
    %%%%%%%%%%%%%%
    %     DCM.M.nograph = 1;
    %     DCM.M.flat = 0;
    %     DCM.xY.Hz = DCM.options.Fdcm(1): DCM.options.Fdcm(2);
    % Save
    save(DCM.name,'DCM')
    %% Step 3: inversion
    
    for tr = [149]%1:nTrials
        %try
            tic
            load(address)
            DCM.options.trials = tr;
            %%%%
            if on_HPC == 1
                drawnow
                clear spm_erp_L
                name = sprintf('DCM_%s',date);
                DCM.options.analysis  = 'CSD';
                
                % Filename and options
                %--------------------------------------------------------------------------
                try, DCM.name;                      catch, DCM.name = name;      end
                try, model   = DCM.options.model;   catch, model    = 'NMM';     end
                try, spatial = DCM.options.spatial; catch, spatial  = 'LFP';     end
                try, Nm      = DCM.options.Nmodes;  catch, Nm       = 8;         end
                try, DATA    = DCM.options.DATA;    catch, DATA     = 1;         end
                
                % Spatial model
                %==========================================================================
                DCM.options.Nmodes = Nm;
                DCM.M.dipfit.model = model;
                DCM.M.dipfit.type  = spatial;
                
                if DATA
                    DCM  = spm_dcm_erp_data(DCM);                   % data
                    DCM  = spm_dcm_erp_dipfit(DCM, 1);              % spatial model
                end
                Ns   = length(DCM.A{1});                            % number of sources
                
                
                % Design model and exogenous inputs
                %==========================================================================
                if ~isfield(DCM,'xU'),   DCM.xU.X = sparse(1 ,0); end
                if ~isfield(DCM.xU,'X'), DCM.xU.X = sparse(1 ,0); end
                if ~isfield(DCM,'C'),    DCM.C    = sparse(Ns,0); end
                if isempty(DCM.xU.X),    DCM.xU.X = sparse(1 ,0); end
                if isempty(DCM.xU.X),    DCM.C    = sparse(Ns,0); end
                
                % Neural mass model
                %==========================================================================
                
                % prior moments on parameters
                %--------------------------------------------------------------------------
                [pE,pC]  = spm_dcm_neural_priors(DCM.A,DCM.B,DCM.C,model);
                
                % check to see if neuronal priors have already been specified
                %--------------------------------------------------------------------------
                try
                    if spm_length(DCM.M.pE) == spm_length(pE);
                        pE = DCM.M.pE;
                        pC = DCM.M.pC;
                        fprintf('Using existing priors\n')
                    end
                end
                
                % augment with priors on spatial model
                %--------------------------------------------------------------------------
                [pE,pC] = spm_L_priors(DCM.M.dipfit,pE,pC);
                
                % augment with priors on endogenous inputs (neuronal) and noise
                %--------------------------------------------------------------------------
                [pE,pC] = spm_ssr_priors(pE,pC);
                %%% kat
                pE.L = pE.L + 0.2;
                %%%
                try
                    if spm_length(DCM.M.pE) == spm_length(pE);
                        pE = DCM.M.pE;
                        pC = DCM.M.pC;
                        fprintf('Using existing priors\n')
                    end
                end
                
                % initial states and equations of motion
                %--------------------------------------------------------------------------
                [x,f]    = spm_dcm_x_neural(pE,model);
                
                % check for pre-specified priors
                %--------------------------------------------------------------------------
                hE       = 12; % changed for humanPST from 8
                hC       = 1/128;  % changed for humanPST from 128 (March 31st 2020)
                try, hE  = DCM.M.hE; hC  = DCM.M.hC; end
                
                % create DCM
                %--------------------------------------------------------------------------
                DCM.M.IS = 'spm_csd_mtf';
                DCM.M.g  = 'spm_gx_erp';
                DCM.M.f  = f;
                DCM.M.x  = x;
                DCM.M.n  = length(spm_vec(x));
                DCM.M.pE = pE;
                DCM.M.pC = pC;
                DCM.M.hE = hE;
                DCM.M.hC = hC;
                DCM.M.m  = Ns;
                
                % specify M.u - endogenous input (fluctuations) and intial states
                %--------------------------------------------------------------------------
                DCM.M.u  = sparse(Ns,1);
                
                %-Feature selection using principal components (U) of lead-field
                %==========================================================================
                
                % Spatial modes
                %--------------------------------------------------------------------------
                try
                    DCM.M.U = spm_dcm_eeg_channelmodes(DCM.M.dipfit,Nm);
                end
                
                % get data-features (in reduced eigenspace)
                %==========================================================================
                if DATA
                    DCM  = spm_dcm_csd_data(DCM);
                end
                
                % scale data features (to a variance of about 8)
                %--------------------------------------------------------------------------
                ccf      = spm_csd2ccf(DCM.xY.y,DCM.xY.Hz);
                scale    = max(spm_vec(ccf));
                DCM.xY.y = spm_unvec(8*spm_vec(DCM.xY.y)/scale,DCM.xY.y);
                
                
                % complete model specification and invert
                %==========================================================================
                Nm       = size(DCM.M.U,2);                    % number of spatial modes
                DCM.M.l  = Nm;
                DCM.M.Hz = DCM.xY.Hz;
                DCM.M.dt = DCM.xY.dt;
                
                % normalised precision
                %--------------------------------------------------------------------------
                DCM.xY.Q  = spm_dcm_csd_Q(DCM.xY.y);
                DCM.xY.X0 = sparse(size(DCM.xY.Q,1),0);
                %%%
                DCM.options.mod_int = 0;
                DCM.M.nograph = 1;
                DCM.M.flat = 0;
                DCM.options.DATA = 0;

            else
                
                DCM.M.P = DCM_template.Ep;
                DCM = spm_dcm_csd(DCM);
            end
            
            save(['./DCM_average_timeseries/', DCM.name '_' num2str(tr)], 'DCM', spm_get_defaults('mat.format'))
            clear DCM
            toc
            
%         catch
%             continue
%         end
    end
    
    
    
end

