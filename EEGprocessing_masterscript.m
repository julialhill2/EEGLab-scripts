%% Opening the files in EEGLAB

%Preprocessing- before operating this script, the annotation files must be
%formatted so that there is a column for the event and a column for the
%latency in the eeg file. The .edf files must be processed in polyman .edf
%viewer so that you only have EEG1, EMG, and EEG2 (no bio or annotations
%channels) EEGLab must be open for this script to work. You can find the eeglab.m
%document, hit run and then select "add to path". 

%Ideally, put only .edf and .txt files together alone in a folder for
%processing. 

%To learn more about the format of the specific commands, you can type (for
%instance) "EEGlab, pop_epoch" in google. Or type the command, "pop_epoch"
%into matlab command line and the input/output variables will come up. 

%This script is divided into sections. To run only 1 section at a time,
%simply hit command+enter(normally how I run). Otherwise, the whole thing will run at once. 

%Hit ctrl+c if you need to stop something if it gets stuck or is taking too
%long. 

clear all
clc
mainpath='D:\JH\ephys\1.16_ERP_TCF4round3\D2_SCN10a\';
filepath='D:\JH\ephys\1.16_ERP_TCF4round3\D2_SCN10a\';
cd(mainpath);
addpath(genpath(mainpath));


filelocs={filepath};  
files=[dir('*.edf')]; 
%%DIRECTORY HAS TO HAVE ALL THE EDF FILES IN IT- can do manually by switching folders
nfiles=length(files); 
%OUTPUT_FILE=sprintf(%s_%s.%s, INPUT

%% PROCESSING THE EEG DATA%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This is for ERP data, that has an accompanying .txt file noting the
%latencies for each repetition of sound1 and sound2

%The command is operating on the assumption that your files in the .edf
%list and the .txt list are matched to each other numerically in the order
%appearance (i.e. 'files' # = 'textfiles' #). The best way to do this is
%make sure they have the same name. 

%Loading the Data in EEGLAB
%If there is an issue with one of the files and processing stops, you can
%delete the problem file, re-run the files=dir and nfiles command, and then
%change k=to the number of the file to re-start on rather than 1. 

%Sometimes, we have
%encountered a problem running excel files created on a Mac and put on the
%server versus a desktop. If there is an error and you see "ghost files"
%(i.e. nfiles does is greater than the number of excel files in the folder)then try deleting the files from the folder and re-saving them on the computer you are running the program on.  

eeglab redraw

files=[dir('*.edf')]; %%DIRECTORY HAS TO HAVE ALL THE EDF FILES IN IT- can do manually by switching folders
nfiles=length(files); 
textfiles=[dir('*.txt')]; 

%Setting up to batch process all your files
for k=1:nfiles
    myfilename = (files(k,1).name)  
    filename2 = myfilename(1:6);
    textfilename = (textfiles(k,1).name)
    EEG = pop_biosig(myfilename, 'importevent','off','importannot','off');
    EEG.setname=filename2;
    subject = ['', char(filename2), '.set'];

    EEG = eeg_checkset( EEG );
    EEG = pop_importevent( EEG, 'event',textfilename,'fields',{'type' 'latency'},'skipline',1,'timeunit',1);
    EEG = eeg_checkset( EEG );
    
%Extracting the marked behavior
    EEG = eeg_checkset( EEG );
    EEG = pop_epoch( EEG, {  '1'  }, [-0.5 1], 'newname', filename2, 'epochinfo', 'yes');
    % EEG = pop_epoch( EEG, {  'chan4'  }, [-5 5], 'newname', filename2, 'epochinfo', 'yes');
    
    %this is creating individual epochs of the marked data using the tag
    %for sound1.Can change to the second sound by putting { '2' } following
    %EEG
    
    %The info in brackets is the time +- the event in seconds. 'newname' is
    %the new setname. 
    
    EEG = eeg_checkset( EEG );
    EEG = pop_rmbase( EEG, [-500 0]);
%You can change this to whatever you want in the studyset mode, but this is
%what dictates what timepoint will be taken for your baseline. Time is in
%ms. 
    EEG = eeg_checkset( EEG );
    eeglab redraw
    
%Saving the files
    EEG = pop_saveset( EEG, 'filename',subject,'filepath', 'D:\JH\ephys\1.16_ERP_TCF4round3\D2_SCN10a'); 
    %saves into the designated folder with the same file name as the text file and .mat file
    EEG = eeg_checkset( EEG );
    
   
end

 clear all
    
 eeglab redraw

%% CREATING A STUDYSET with the files%%SKIP
%still working on this section- not fully operational- pulls up files but
%then will not allow editing of the files. 

%BETTER to just create a studyset in EEGLAB by file>create study


mainpath='D:\JH\ephys\8.16_EEGEMG_NOR\9.16 ERP\D1_vehicle\';
filepath='D:\JH\ephys\8.16_EEGEMG_NOR\9.16 ERP\D1_vehicle\';
cd(mainpath);
addpath(genpath(mainpath));
filelocs={filepath};  
 D = dir('./*.set');
 
 for i = 1:size(D,1)
    [STUDY ALLEEG] = std_editset( STUDY, ALLEEG, 'commands',{{'index' i 'load' D(i).name}},'updatedat','on','addchannellabels','on','filename', 'practice', 'savedat','off');
    %this builds the studyset using all the existing .set files in the
    %specificed folder. The word in quotes after the filename will be
    %filename that the studyset is saved under. 
     [STUDY, ALLEEG] = std_checkset(STUDY, ALLEEG);
     eeglab redraw;
 end
 
  CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
 [STUDY, ALLEEG] = std_checkset(STUDY, ALLEEG);

  eeglab redraw;
  
  %At this point, a studyset with all of your files will be automatically
  %saved. You must add in subject number and the group/condition ID
  %for each file yourself. Then re-save the file. 


%% CALLING UP THE STUDYSET FOR FURTHER PROCESSING%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%set up the file paths
clear all
clc
mainpath='D:\Yishan\9.16 ERP\D1_vehicle\';
filepath='D:\Yishan\9.16 ERP\D1_vehicle\';
cd(mainpath);
addpath(genpath(mainpath));

%call up the study file
ask_filedir ='D:\Yishan\9.16 ERP\D1_vehicle\';                                                                    %Matlab prompts the user to input the data location (path).
ask_studies = 'practice.study';

[STUDY ALLEEG] = pop_loadstudy('filename', ask_studies, 'filepath', ask_filedir);                  %The data is loaded using eeglab.
    CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];                                %One study is loaded.
    study_number = STUDY.datasetinfo;                                                            %study_number is defined as the datasets of the study.
    study_num = length(study_number);                                                            %study_num is defined as the number of datasets.
    all_cell = {};

    
%% ERP- Component analysis- PEAK AMP, LATENCY, AVERAGE AMP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Extract the ERP data from the studyset that was created in EEGLAB. Have
%studyset pulled up. This has to be precomputed before you can visualize
%the data. 

%Study>precompute channel measures>ERP

%Make sure to uncheck the ICA box. 

%[STUDY, ALLEEG] = std_precomp(STUDY, ALLEEG, 'erp', {'components'[] , 'channels',{2}, 'recompute','on', 'trial indices'[1 100], 'rmcomps'[], 'interp'[], 'fileout'[], 'savetrials','off'} );
STUDY = std_erpplot (STUDY,ALLEEG,'channels',{'EEG 2'}, 'plotsubjects', 'on' ); 
[STUDY erpdata erptimes] = std_erpplot(STUDY,ALLEEG,'channels',{'EEG 2'});


%% Extracting the peak amplitude, latency to peak, and average amp
%SET-UP

%Name the specific groups of data based on what ERP data returns so that
%Matlab can work on each group independently. If you the group numbers are
%the same and you need to figure out which is which, delete one file and
%see how the number of data sets returns changes (it can always be added
%back once you know identity). 

WTVeh=erpdata{1,1};
TCF4HetVeh=erpdata{2,1};
WTSCN10a=erpdata{1,2};
TCF4HetSCN=erpdata{2,2};

subj=8;
%change subj depending on max # in a group

%if the EEG signal is inverted, you have to change the sign of the data
%otherwise the component script will not work properly

WTVeh=-(WTVeh);
TCF4HetVeh=-(TCF4HetVeh);
WTSCN10a=-(WTSCN10a);
TCF4HetSCN=-(TCF4HetSCN);

%check erpdata to figure out cell array structure ie {1,2} or {2,1} for
%second dataset-this depends on whether you separate them by group or
%condition in the studyset design.

%preallocate variables to increase speed
p20avg = zeros(1,subj);
p20amp = zeros(1,subj);
latencyp20 = zeros(1,subj);

n40avg = zeros(1,subj);
n40amp = zeros(1,subj);
latencyn40 = zeros(1,subj);

p80avg = zeros(1,subj);
p80amp = zeros(1,subj);
latencyp80 = zeros(1,subj);

p120avg = zeros(1,subj);
p120amp = zeros(1,subj);
latencyp120 = zeros(1,subj);

S2p20avg = zeros(1,subj);
S2p20amp = zeros(1,subj);
latencyS2p20 = zeros(1,subj);

S2n40avg = zeros(1,subj);
S2n40amp = zeros(1,subj);
latencyS2n40 = zeros(1,subj);

S2p80avg = zeros(1,subj);
S2p80amp = zeros(1,subj);
latencyS2p80 = zeros(1,subj);

S2p120avg = zeros(1,subj);
S2p120amp = zeros(1,subj);
latencyS2p120 = zeros(1,subj);

filename= '10.31_TCF4study_TCF4SCN10aERPcomponents';
filename = [filename, '.xlsx'];
%change filename for experimental group to avoid copying and pasting in
%writexls command. File will save to your current designated folder. 

nsubj= 'sheet8';
%change nsubj to account for number of subjects in expt group to avoid
%copying and pasting the write script

%% Exporting the Peaks data
%This script works by analyzing data in the given data point range for each
%component (The A(x:y) numbers). Check components within the dataset to make sure that it is
%compatible. If the range needs to be changed, you just have to figure out
%how the EEG time data (erptimes) matches up with the components and shift
%it. 


group=TCF4HetSCN;
%this specifies which dataset to work on. You can just change the group
%name to process multiple datasets. 

[m,n]=size(group);
%this returns the size of the matrix of your data

nsubj=n;
%nsubj=length(nsubj);
%this automatically spits out the number of columns, i.e. your number of
%subjects

for k=1:nsubj
    
    A=group(:,k);
    
    %SOUND 1 CALCULATIONS%%%%%%%%%%%%%%%%%%%%%%%%
    %P20 data
    p20avg(k)=mean(A(1035:1075));
    %The avg finds the mean in the specified range of data. Here, 5-25 ms
    p20amp(k)=max(A(1035:1075));
    %The amp finds the max or min amplitude in a given window
    latencyp20(k)=find(A(:,1)==p20amp(k));
    %The latency finds the time the max/min occurs
    latencyp20(k)=erptimes(1,latencyp20(k));
    %This matches the row number in the data to the actual EEG time
    %relative to tone onset
    
    %atency(i).P20=ALLEEG(k).times(find(M(:,1)==peaks(i).P20));
    %x1range='C1'
    
    %N40 data
    n40avg(k)=mean(A(1081:1126));
    %29-43 ms
    n40amp(k)=min(A(1081:1126));
    latencyn40(k)=find(A(:,1)==n40amp(k));
    latencyn40(k)=erptimes(1,latencyn40(k));
    
    %P80 data
    p80avg(k)=mean(A(1137:1171));
    %60-80 ms
    p80amp(k)=max(A(1137:1171));
    latencyp80(k)=find(A(:,1)==p80amp(k));
    latencyp80(k)=erptimes(1,latencyp80(k));
    
    %P120 data
    p120avg(k)=mean(A(1177:1291));
    %90-120- 591:621- looked promising
    %100-130
    p120amp(k)=max(A(1177:1291));
    latencyp120(k)=find(A(:,1)==p120amp(k));
    latencyp120(k)=erptimes(1,latencyp120(k));
    

    %SOUND 2 CALCULATIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %S2 P20 data
    S2p20avg(k)=mean(A(2047:2077));
    %505-525
    S2p20amp(k)=max(A(2047:2077));
    latencyS2p20(k)=find(A(:,1)==S2p20amp(k));
    latencyS2p20(k)=erptimes(1,latencyS2p20(k));
    
    %S2 N40
    S2n40avg(k)=mean(A(2083:2125));
    %526-546
    S2n40amp(k)=min(A(2083:2125));
    latencyS2n40(k)=find(A(:,1)==S2n40amp(k));
    latencyS2n40(k)=erptimes(1,latencyS2n40(k));
    
    %S2 P80
    %P80 data
    S2p80avg(k)=mean(A(2131:2155));
    %60-80 ms
    S2p80amp(k)=max(A(2131:2155));
    latencyS2p80(k)=find(A(:,1)==S2p80amp(k));
    latencyS2p80(k)=erptimes(1,latencyS2p80(k));
    
    %S2 P120
    %P120 data
    S2p120avg(k)=mean(A(1171:1291));
    %90-120- 591:621- looked promising
    %100-130
    S2p120amp(k)=max(A(1171:1291));
    latencyS2p120(k)=find(A(:,1)==S2p120amp(k));
    latencyS2p120(k)=erptimes(1,latencyS2p120(k)); 
    
    
    %S1/S2
    S1S2ratio=((p20avg)/(S2p20avg))
    
    Z=erptimes';
    % transpose this separately so it doesn't change the erptimes
    %data since this is referred to in the loop to find the EEG time values, 
    %but it writes the variable in the correct dimension in excel
    
    xlswrite(filename, Z, k, 'A1')
    xlswrite(filename, A, k, 'B1')
    
    xlswrite(filename, p20amp, n, 'C1')
    xlswrite(filename, latencyp20, n, 'C2')
    xlswrite(filename, p20avg, n, 'C3')
    
    xlswrite(filename, n40amp, n, 'C6')
    xlswrite(filename, latencyn40, n, 'C7')
    xlswrite(filename, n40avg, n, 'C8')
    
    xlswrite(filename, p80amp, n, 'C11')
    xlswrite(filename, latencyp80, n, 'C12')
    xlswrite(filename, p80avg, n, 'C13')
    
    xlswrite(filename, p120amp, n, 'C16')
    xlswrite(filename, latencyp120, n, 'C17')
    xlswrite(filename, p120avg, n, 'C18')
    
    xlswrite(filename, S2p20amp, n, 'M1')
    xlswrite(filename, latencyS2p20, n, 'M2')
    xlswrite(filename, S2p20avg, n, 'M3')
    
    xlswrite(filename, S2n40amp, n, 'M6')
    xlswrite(filename, latencyS2n40, n, 'M7')
    xlswrite(filename, S2n40avg, n, 'M8')
    
    xlswrite(filename, S2p80amp, n, 'M11')
    xlswrite(filename, latencyS2p80, n, 'M12')
    xlswrite(filename, S2p80avg, n, 'M13')
    
    xlswrite(filename, S2p120amp, n, 'M16')
    xlswrite(filename, latencyS2p120, n, 'M17')
    xlswrite(filename, S2p120avg, n, 'M18')
end
    %xlswrite('Barlo4_rawAEP_KI.xlsx', S1S2ratio, 7, 'C26')
 %% ERP AMPLITUDE ANALYSIS
    
    STUDY = std_erpplot (STUDY,ALLEEG,'channels',{'EEG 2'}, 'plotsubjects', 'on' ); 
[STUDY erpdata erptimes] = std_erpplot(STUDY,ALLEEG,'channels',{'EEG 2'});

%results will be housed in erpdata, erptimes= times, export the times and
%the erpdata for each group to excel. 

%% Time-Frequency Analysis 
% SEE 'EEGLAB_extractingtimefrequencyanalysis_results.m'