%%Script used for taking epoched data (ERP) and converting it back to
%%continuous data for analysis using phase-amplitude coupling plugin. 

%Data must be open in EEGLAB, at the single-file level (not studyset). 


nframes=EEG.pnts;
ntrials=EEG.trials;
data=EEG.data(4,:,:);
%data = ALLEEG(1,14).data;
%data = ALLEEG(1,x).data;
%creates a variable for the data in the selected dataset
data2 = reshape(data, 1, nframes*ntrials, 1);
%data2 = reshape(data, a, b, c);
%multiply the number of frames per epoch to get new total # of frames
%a = # of EEG channels
%b = total frames
%c = # of epochs (1 for continuous data)

