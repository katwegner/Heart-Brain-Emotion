% addpath



subi = 0;
PEB1s = cell(2,1);
for s = [8 10]%[2 4 30]
    subi = subi + 1;
    X = ones(232,1);
    regions = {'ai', 'am', 'ac'};
    for i_region = 1:3
        region = regions{i_region}
        fname = strcat('/Volumes/Elements4/heartbeat/data_to_be_used/P', sprintf( '%02d', s ), '_dhep_', region);
        try
            load(fname)
            hep = eval(strcat('dhep_', region));
            hep(isnan(hep)) = max(hep);
            X = [X hep];
        end
    end
    [PEB] = heb_peb_subject(s,X, 1:232);
    PEB1s{subi} = PEB;
    clear PEB
end
if ismember(17, s)
  BMA = spm_dcm_peb_bmc(PEB1s{1});
else
[PEB2]    = spm_dcm_peb(PEB1s); % across days
% Bayesian Model Averaging
BMA = spm_dcm_peb_bmc(PEB2);
end