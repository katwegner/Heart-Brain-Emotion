% HEP + DCM correlations

% P08 and P10: ai-am-ac
% P02, P04, P30: ai-am
% P17: ai-ac

subjects = [2,4,8,10,17,30];

% get correlations per region

regions = {'ai', 'am', 'ac'}
connections = {"A1_ai_to_am",
    "A1_am_to_ai",
    "A1_ai_to_ac",
    "A1_ac_to_ai",
    "A1_am_to_ac",
    "A1_ac_to_am",
    "A2_ai_to_am" ,
    "A2_am_to_ai",
    "A2_ai_to_ac" ,
    "A2_ac_to_ai",
    "A2_am_to_ac" ,
    "A2_ac_to_am" ,
    "A3_ai_to_am",
    "A3_am_to_ai",
    "A3_ai_to_ac",
    "A3_ac_to_ai",
    "A3_am_to_ac",
    "A3_ac_to_am",
    "A4_ai_to_am",
    "A4_am_to_ai",
    "A4_ai_to_ac",
    "A4_ac_to_ai",
    "A4_am_to_ac",
    "A4_ac_to_am"}
for i_region = 1:3
    region = regions{i_region};
    % select connections that contain that region
    connection_filtered = [];
    for i_connection = 1:length(connections)
        connection = connections{i_connection};
        if contains(connection, region)
            connection_filtered = [connection_filtered; connection];
        end
    end
    %     % select subjects that contain that region
    %     if strcmp(region, 'ai')
    %         subjects = [8, 10, 2, 4, 30, 17];
    %     elseif strcmp(region, 'am')
    %         subjects = [8, 10, 2, 4, 30];
    %     elseif strcmp(region, 'ac')
    %         subjects = [8, 10, 17];
    %     end
    
    i_s = 0;
    for s = subjects
        i_s = i_s +1;
        green_light = strcmp(region, 'ai')|| (strcmp(region, 'am') && ismember(s,[2,4,8,10,30])) || ((strcmp(region, 'ac') && ismember(s,[8,10,17])));
        
        if green_light
            % open HEP
            fname = strcat('/Volumes/Elements4/heartbeat/data_to_be_used/P', sprintf( '%02d', s ), '_dhep_', region);
            load(fname)
            
            for i_connection = 1:length(connection_filtered)
                connection = connection_filtered(i_connection);
                %dname = strcat('dhep_', region)
                hep = eval(strcat('dhep_', region));
                data_connection = eval(connection);
                try
                    [r,p] = corrcoef(hep, data_connection(i_s,:), 'rows', 'complete');
                    
                    if p(2,1) < 0.05
                        disp([region, connection, r(2,1), p(2,1), s])
                    end
                end
            end
        end
    end
    
    
    
end


