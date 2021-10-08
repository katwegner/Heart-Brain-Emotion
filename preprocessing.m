% change pp08

cd /Volumes/Elements4/heartbeat/data_original

% ai and am
% for sub = [2 4]
%     clearvars -except sub
%     load(['P',sprintf('%02d', sub), '_data'])
% end

% rename variables(ai and acc)
sub  = 17
load P17_acc_aic_data
%load(['P',sprintf('%02d', sub), '_data'])
ac_data = ac_channel;
ai_data = ai_channel;
save('/Volumes/Elements4/heartbeat/data_to_be_used/P17_data.mat', "ac_data", "ai_data")


% merge datasets
for sub = [8, 10]
    load(['P',sprintf('%02d', sub), '_data'])
    load(['P',sprintf('%02d', sub), '_acc_aic_data'])
    ai_data = ai_channel;
    ac_data = ac_channel;
    save(strcat('/Volumes/Elements4/heartbeat/data_to_be_used/', ['P',sprintf('%02d', sub), '_data']), "ac_data", "ai_data", "am_data")
end