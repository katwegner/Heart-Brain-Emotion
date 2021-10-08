% P08 and P10: ai-am-ac
% P02, P04, P30: ai-am
% P17: ai-ac


A1_ai_to_am = [];
A1_am_to_ai = [];
A1_ai_to_ac = [];
A1_ac_to_ai = [];
A1_am_to_ac = [];
A1_ac_to_am = [];

A2_ai_to_am = [];
A2_am_to_ai = [];
A2_ai_to_ac = [];
A2_ac_to_ai = [];
A2_am_to_ac = [];
A2_ac_to_am = [];

A3_ai_to_am = [];
A3_am_to_ai = [];
A3_ai_to_ac = [];
A3_ac_to_ai = [];
A3_am_to_ac = [];
A3_ac_to_am = [];

A4_ai_to_am = [];
A4_am_to_ai = [];
A4_ai_to_ac = [];
A4_ac_to_ai = [];
A4_am_to_ac = [];
A4_ac_to_am = [];
sub_idx = 0;

n_tw = 232
for s = [2,4,8,10,17,30]
    sub_idx = sub_idx + 1;
for tw = 1:n_tw
    data_name = strcat('/Volumes/Elements4/heartbeat/DCM_average_timeseries/DCM_P', sprintf( '%02d', s ), '_', num2str(tw));
    try
    load(data_name)
    if ismember(s,[2,4,30,8,10])
        A1_ai_to_am(sub_idx,tw) = DCM.Ep.A{1}(2,1);
        A1_am_to_ai(sub_idx,tw) = DCM.Ep.A{1}(1,2);
        A2_ai_to_am(sub_idx,tw) = DCM.Ep.A{2}(2,1);
        A2_am_to_ai(sub_idx,tw) = DCM.Ep.A{2}(1,2);
        A3_ai_to_am(sub_idx,tw) = DCM.Ep.A{3}(2,1);
        A3_am_to_ai(sub_idx,tw) = DCM.Ep.A{3}(1,2);
        A4_ai_to_am(sub_idx,tw) = DCM.Ep.A{4}(2,1);
        A4_am_to_ai(sub_idx,tw) = DCM.Ep.A{4}(1,2);
    
   elseif s == 17
        A1_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{1}(2,1);
        A1_ac_to_ai(sub_idx,tw)  = DCM.Ep.A{1}(1,2);

        A2_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{2}(2,1);
        A2_ac_to_ai(sub_idx,tw)  = DCM.Ep.A{2}(1,2);

        A3_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{3}(2,1);
        A3_ac_to_ai(sub_idx,tw)  = DCM.Ep.A{3}(1,2);

        A4_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{4}(2,1);
        A4_ac_to_ai(sub_idx,tw)  = DCM.Ep.A{4}(1,2);
    end
    
    
    if ismember(s,[8,10])
        A1_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{1}(3,1);
        A1_ac_to_ai(sub_idx,tw) = DCM.Ep.A{1}(1,3);
        A1_am_to_ac(sub_idx,tw)  = DCM.Ep.A{1}(3,2);
        A1_ac_to_am(sub_idx,tw)  = DCM.Ep.A{1}(2,3);

        A2_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{2}(3,1);
        A2_ac_to_ai(sub_idx,tw)  = DCM.Ep.A{2}(1,3);
        A2_am_to_ac(sub_idx,tw)  = DCM.Ep.A{2}(3,2);
        A2_ac_to_am(sub_idx,tw)  = DCM.Ep.A{2}(2,3);

        A3_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{3}(3,1);
        A3_ac_to_ai(sub_idx,tw)  = DCM.Ep.A{3}(1,3);
        A3_am_to_ac(sub_idx,tw) = DCM.Ep.A{3}(3,2);
        A3_ac_to_am(sub_idx,tw)  = DCM.Ep.A{3}(2,3);

        A4_ai_to_ac(sub_idx,tw)  = DCM.Ep.A{4}(3,1);
        A4_ac_to_ai(sub_idx,tw)  = DCM.Ep.A{4}(1,3);
        A4_am_to_ac(sub_idx,tw)  = DCM.Ep.A{4}(3,2);
        A4_ac_to_am(sub_idx,tw)  = DCM.Ep.A{4}(2,3);
    end
    end
end
end
% 0 to NaN
A1_ai_to_am(A1_ai_to_am == 0) = NaN;
A1_am_to_ai(A1_am_to_ai == 0) = NaN;
A1_ai_to_ac(A1_ai_to_ac == 0) = NaN;
A1_ac_to_ai(A1_ac_to_ai == 0) = NaN;
A1_am_to_ac(A1_am_to_ac == 0) = NaN;
A1_ac_to_am(A1_ac_to_am == 0) = NaN;

A2_ai_to_am(A2_ai_to_am == 0) = NaN;
A2_am_to_ai(A2_am_to_ai == 0) = NaN;
A2_ai_to_ac(A2_ai_to_ac == 0) = NaN;
A2_ac_to_ai(A2_ac_to_ai == 0) = NaN;
A2_am_to_ac(A2_am_to_ac == 0) = NaN;
A2_ac_to_am(A2_ac_to_am == 0) = NaN;

A3_ai_to_am(A3_ai_to_am == 0) = NaN;
A3_am_to_ai(A3_am_to_ai == 0) = NaN;
A3_ai_to_ac(A3_ai_to_ac == 0) = NaN;
A3_ac_to_ai(A3_ac_to_ai == 0) = NaN;
A3_am_to_ac(A3_am_to_ac == 0) = NaN;
A3_ac_to_am(A3_ac_to_am == 0) = NaN;

A4_ai_to_am(A4_ai_to_am == 0) = NaN;
A4_am_to_ai(A4_am_to_ai == 0) = NaN;
A4_ai_to_ac(A4_ai_to_ac == 0) = NaN;
A4_ac_to_ai(A4_ac_to_ai == 0) = NaN;
A4_am_to_ac(A4_am_to_ac == 0) = NaN;
A4_ac_to_am(A4_ac_to_am == 0) = NaN;


% normalize per subject

n_A1_ai_to_am = A1_ai_to_am./max(abs(A1_ai_to_am'))';
n_A1_am_to_ai = A1_am_to_ai./max(abs(A1_am_to_ai'))';
n_A1_ai_to_ac = A1_ai_to_ac./max(abs(A1_ai_to_ac'))';
n_A1_ac_to_ai = A1_ac_to_ai./max(abs(A1_ac_to_ai'))';
n_A1_am_to_ac = A1_am_to_ac./max(abs(A1_am_to_ac'))';
n_A1_ac_to_am = A1_ac_to_am./max(abs(A1_ac_to_am'))';

n_A2_ai_to_am = A2_ai_to_am./max(abs(A2_ai_to_am'))';
n_A2_am_to_ai = A2_am_to_ai./max(abs(A2_am_to_ai'))';
n_A2_ai_to_ac = A2_ai_to_ac./max(abs(A2_ai_to_ac'))';
n_A2_ac_to_ai = A2_ac_to_ai./max(abs(A2_ac_to_ai'))';
n_A2_am_to_ac = A2_am_to_ac./max(abs(A2_am_to_ac'))';
n_A2_ac_to_am = A2_ac_to_am./max(abs(A2_ac_to_am'))';


n_A3_ai_to_am = A3_ai_to_am./max(abs(A3_ai_to_am'))';
n_A3_am_to_ai = A3_am_to_ai./max(abs(A3_am_to_ai'))';
n_A3_ai_to_ac = A3_ai_to_ac./max(abs(A3_ai_to_ac'))';
n_A3_ac_to_ai = A3_ac_to_ai./max(abs(A3_ac_to_ai'))';
n_A3_am_to_ac = A3_am_to_ac./max(abs(A3_am_to_ac'))';
n_A3_ac_to_am = A3_ac_to_am./max(abs(A3_ac_to_am'))';



n_A4_ai_to_am = A4_ai_to_am./max(abs(A4_ai_to_am'))';
n_A4_am_to_ai = A4_am_to_ai./max(abs(A4_am_to_ai'))';
n_A4_ai_to_ac = A4_ai_to_ac./max(abs(A4_ai_to_ac'))';
n_A4_ac_to_ai = A4_ac_to_ai./max(abs(A4_ac_to_ai'))';
n_A4_am_to_ac = A4_am_to_ac./max(abs(A4_am_to_ac'))';
n_A4_ac_to_am = A4_ac_to_am./max(abs(A4_ac_to_am'))';


%% plot
figure; plot(1:n_tw, nanmean(n_A1_ai_to_am,1)); hold on
plot(1:n_tw, nanmean(n_A2_ai_to_am,1))
plot(1:n_tw, nanmean(n_A3_ai_to_am,1))
plot(1:n_tw, nanmean(n_A4_ai_to_am,1))
legend({'A1', 'A2', 'A3', 'A4'})
title('AI to AM')
xlabel('Time Window')

figure; plot(1:n_tw, nanmean((n_A1_ai_to_am + n_A2_ai_to_am)/2,1))   ; hold on
plot(1:n_tw, nanmean((n_A3_ai_to_am + n_A4_ai_to_am)/2,1))
legend({'forward', 'backward'})
title('AI to AM')
xlabel('Time Window')

%
figure; plot(1:n_tw, nanmean(n_A1_am_to_ai,1)); hold on
plot(1:n_tw, nanmean(n_A2_am_to_ai,1))
plot(1:n_tw, nanmean(n_A3_am_to_ai,1))
plot(1:n_tw, nanmean(n_A4_am_to_ai,1))
legend({'A1', 'A2', 'A3', 'A4'})
title('AM to AI')
xlabel('Time Window')

figure; plot(1:n_tw, nanmean((n_A1_am_to_ai + n_A2_am_to_ai)/2,1))   ; hold on
plot(1:n_tw, nanmean((n_A3_am_to_ai + n_A4_am_to_ai)/2,1))
legend({'forward', 'backward'})
title('AM to AI')
xlabel('Time Window')
%
figure; plot(1:n_tw, nanmean(n_A1_ai_to_ac,1)); hold on
plot(1:n_tw, nanmean(n_A2_ai_to_ac,1))
plot(1:n_tw, nanmean(n_A3_ai_to_ac,1))
plot(1:n_tw, nanmean(n_A4_ai_to_ac,1))
legend({'A1', 'A2', 'A3', 'A4'})
title('AI to AC')
xlabel('Time Window')


figure; plot(1:n_tw, nanmean((n_A1_ai_to_ac + n_A2_ai_to_ac)/2,1))   ; hold on
plot(1:n_tw, nanmean((n_A3_ai_to_ac + n_A4_ai_to_ac)/2,1))
legend({'forward', 'backward'})
title('AI to AC')
xlabel('Time Window')
%

figure; plot(1:n_tw, nanmean(n_A1_ac_to_ai,1)); hold on
plot(1:n_tw, nanmean(n_A2_ac_to_ai,1))
plot(1:n_tw, nanmean(n_A3_ac_to_ai,1))
plot(1:n_tw, nanmean(n_A4_ac_to_ai,1))
legend({'A1', 'A2', 'A3', 'A4'})
title('AC to AI')
xlabel('Time Window')
figure; plot(1:n_tw, nanmean((n_A1_ac_to_ai + n_A2_ac_to_ai)/2,1))   ; hold on
plot(1:n_tw, nanmean((n_A3_ac_to_ai + n_A4_ac_to_ai)/2,1))
legend({'forward', 'backward'})
title('AC to AI')
xlabel('Time Window')

%
figure; plot(1:n_tw, nanmean(n_A1_am_to_ac,1)); hold on
plot(1:n_tw, nanmean(n_A2_am_to_ac,1))
plot(1:n_tw, nanmean(n_A3_am_to_ac,1))
plot(1:n_tw, nanmean(n_A4_am_to_ac,1))
legend({'A1', 'A2', 'A3', 'A4'})
title('AM to AC')
xlabel('Time Window')

figure; plot(1:n_tw, nanmean((n_A1_am_to_ac + n_A2_am_to_ac)/2,1))   ; hold on
plot(1:n_tw, nanmean((n_A3_am_to_ac + n_A4_am_to_ac)/2,1))
legend({'forward', 'backward'})
title('AM to AC')
xlabel('Time Window')




figure; plot(1:n_tw, nanmean(n_A1_ac_to_am,1)); hold on
plot(1:n_tw, nanmean(n_A2_ac_to_am,1))
plot(1:n_tw, nanmean(n_A3_ac_to_am,1))
plot(1:n_tw, nanmean(n_A4_ac_to_am,1))
legend({'A1', 'A2', 'A3', 'A4'})
title('AC to AM')
xlabel('Time Window')
figure; plot(1:n_tw, nanmean((n_A1_ac_to_am + n_A2_ac_to_am)/2,1))   ; hold on
plot(1:n_tw, nanmean((n_A3_ac_to_am + n_A4_ac_to_am)/2,1))
legend({'forward', 'backward'})
title('AC to AM')
xlabel('Time Window')


n_A4_ac_to_am = A4_ac_to_am./max(abs(A4_ac_to_am'))';



%%
