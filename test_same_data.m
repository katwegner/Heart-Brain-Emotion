% Same data?

data = 'P17'
cd(strcat('/Volumes/Elements4/heartbeat/heps_prep_data_aug_2021/', data))

load(strcat(data, '_data'))

ai_data_new = ai_data;

cd /Volumes/Elements4/heartbeat/data_to_be_used

load(strcat(data, '_data'))
sum((ai_data_new == mean(ai_data)) == 0)