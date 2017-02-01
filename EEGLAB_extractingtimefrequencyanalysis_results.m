%%Time-frequency data analysis- Instructions

%1. Import the EEG data into EEGLab, proccess using the
%EEGprocessing_masterscript. 
%2. Put the data into a study set in EEGLAB. 
%3. Perform the precompute for ERSP and ITC. Make sure the ICA box is
%unchecked. Hit "ok" when it gives you the warning about ERSP and ITC
%taking more time. 
        %Settings- 'cycles', [2 10], 'nfreqs', 50, 'ntimesout', 200,
        %'freqs', [0 50], 'freqscale', 'linear'
        %This will return a 50x200 matrix of the averaged data for each
        %animal, with a linear scale and for frequencies 0-50
%4. Once precomputed, ersp and itc values can be accessed using the prompts
%below. 

[STUDY itcdata itctimes itcfreqs] = std_itcplot(STUDY,ALLEEG,'channels',{'EEG 2'});
%calls up the data for the specified channel. Channel name has to match
%exactly. 
group1=itcdata{1,1};
group2=itcdata{2,1};
group3=itcdata{1,2};
group4=itcdata{2,2};

%% Exporting the specified ITC data to an .xlsx file

%Returns the 50x200 matrix, one sheet for each animal. The total number of
%sheets should match the # of subjects. itcdata and itc freqs can be used
%to match the information to the matrix. Will be the same for all analysis
%unless you change the values during precomputing. 


for k=1:length(group4)
    A=group4(:,:,1,k);
    xlswrite('D:\JH\ephys\9.16 ERP_Tcf4\FINALANALYSISfiles\ITC\testgroup4.xlsx', A, k)
end

%Saves a spreadsheet to the current folder with your requested data. 

%% Extracting the specified ERSP data
%All the same info about ITC applies to ERSP. 

[STUDY erspdata ersptimes erspfreqs] = std_erspplot(STUDY,ALLEEG,'channels',{'EEG 2'});

group1=erspdata{1,1};
group2=erspdata{2,1};
group3=erspdata{1,2};
group4=erspdata{2,2};


%% Exporting the ERSP data to an .xlsx file
for k=1:length(group2)
    A=group2(:,:,1,k);   
    xlswrite('D:\JH\ephys\9.16 ERP_Tcf4\finalanalysis\itc\1.20.17_ITC_TCF4Veh.xlsx', A, k)
end
    
