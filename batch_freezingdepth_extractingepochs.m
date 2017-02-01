%% Opening the files in EEGLAB
clear all
clc
mainpath='D:\JH\ephys\2015_alldepthanalysis\Raw .edf files for each session\ext1_5sec';
filepath='D:\JH\ephys\2015_alldepthanalysis\Raw .edf files for each session\ext1_5sec';
cd(mainpath);
addpath(genpath(mainpath));


filelocs={filepath};  
files=[dir('*.edf')] %%DIRECTORY HAS TO HAVE ALL THE EDF FILES IN IT- can do manually by switching folders
nfiles=length(files); 
%OUTPUT_FILE=sprintf(%s_%s.%s, INPUT

%%
for k=1:nfiles
%Loading the Data in EEGLAB
%If there is an issue with one of the files and processing stops, you can
%delete the problem file, re-run the files=dir and nfiles command, and then
%change k=to the number of the file to re-start on rather than 1. 
myfilename = (files(k,1).name)
filename2 = myfilename(1:end-8);
EEG = pop_biosig(myfilename, 'importevent','off','importannot','off');
EEG.setname=filename2;
subject = ['', char(filename2), '.set'];

%Extracting the freezing behavior
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG,'notime',[0 120] );
EEG = eeg_checkset( EEG ); 
EEG = pop_chanevent(EEG, 4,'edge','leading','edgelen',0,'delchan','on','delevent','off');
EEG = eeg_checkset( EEG );
%EEG = pop_chanevent(EEG, 5,'edge','leading','edgelen',0,'delchan','off','delevent','off');
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'chan4'  }, [-5 5], 'newname', filename2, 'epochinfo', 'yes');
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-2000 -200]);
%You can change this to whatever you want in the studyset mode
EEG = eeg_checkset( EEG );
eeglab redraw

%Saving
EEG = pop_saveset( EEG, 'filename',subject,'filepath', 'D:\JH\ephys\2015_alldepthanalysis\Raw .edf files for each session\hab_5sec'); %saves into the designated folder with the same file name as the text file and .mat file
EEG = eeg_checkset( EEG );


end

%% Loading the studyset
ask_filedir ='D:\JH\ephys\2015_alldepthanalysis\Raw .edf files for each session\ext1_5sec';                                                                    %Matlab prompts the user to input the data location (path).
ask_studies = {'ext1_5secvHPC'};

% [STUDY ALLEEG] = pop_loadstudy('filename', datafile , 'filepath', filedir);                  %The data is loaded using eeglab.
    CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];                                %One study is loaded.
    study_number = STUDY.datasetinfo;                                                            %study_number is defined as the datasets of the study.
    study_num = length(study_number);                                                            %study_num is defined as the number of datasets.
    all_cell = {};

%% Exporting events to examine number of events within an epoch%%
%requires a studyset being loaded
events=struct

for k=1:length(ALLEEG)
    filename=ALLEEG(1,k).filename
    EEG=EEG(1,k)
    events=EEG.event
    %pop_expevents(EEG, 'D:\JH\ephys\2015_alldepthanalysis\Raw .edf files for each session\ext1_5sec\test.csv', 'samples');
    %pop_expevents(EEG, 'D:\JH\ephys\2015_alldepthanalysis\Raw .edf files for each session\ext1_5sec\testingeventsexport.csv', 'samples');
end





