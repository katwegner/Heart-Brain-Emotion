% frequency

cd /Volumes/Elements4/heartbeat/DCM_average_timeseries

subi = 0;
for pp = [8,10,2,4,30,17]
    subi = subi +1;
    for tw = 1:232
        data_name = strcat('/Volumes/Elements4/heartbeat/DCM_average_timeseries/DCM_P', sprintf( '%02d', pp ), '_', num2str(tw));
        try
            load(data_name)
            spectra(:, subi,tw, 1) = abs(DCM.xY.csd{1}(:, 1,1));
            % am
            if ismember(pp,[8,10, 2 4 30])
                spectra(:, subi,tw, 2) = abs(DCM.xY.csd{1}(:, 2,2));
            end
            %ac
            if ismember(pp,[8,10])
                spectra(:, subi,tw, 3) = abs(DCM.xY.csd{1}(:, 3,3));
            elseif ismember(pp, [17])
                spectra(:, subi,tw, 3) = abs(DCM.xY.csd{1}(:, 2,2));
            end
            
        catch
            fprintf(data_name)
        end
        
        %   el = 1 == ai
        %   el = 2 == am
        %   el = 3 == ac
    end
end

spectra(spectra==0) = NaN;
for s = 1:size(spectra,2)
   n_spectra(:,s, :,:) =  spectra(:,s,:,:)./max(max(max(spectra(:,s,:,:))));
end
m_spectra = squeeze(nanmean(n_spectra,2));
% 
all_m_spectra = squeeze(nanmean(m_spectra,2));
figure; hold on
for el = 1:3
    plot(4:48, all_m_spectra(:,el))
end
legend({'Anterior Insula', 'Amygdala', 'Anterior Cingulate'})

figure;heatmap(m_spectra(:,:,1));

