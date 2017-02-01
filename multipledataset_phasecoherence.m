%%%%Script to load multiple datasets, perform cross-channel coherence, and
%%%%output the selected variables to a .mat file

eeglab
Ns=4; Nc=1
%Ns= number of subjects (must match # of files within folder)
%Nc= number of conditions (can have multiple for 1 subject)

for S=1: Ns
    for s=1:Nc
        
        %Set-up
        setname = ['subj' int2str(S) 'data' int2str(s) '.set'];
        %example of saved dataset name format: subj1data1.set
        %if more than 1 condition change number of 'data'
        
        outputFilename = ['subj' int2str(S) 'data' int2str(s) '.mat'];
        %Saves a .mat file with the designated variables into the same file
        %where the dataset is stored. 
        
        %Process
        EEG = pop_loadset(setname, 'D:\JH\ephys\10.2013_JHDepth\EZM\crosscoherence_test'); 
        % Load the data set, designate the input folder
       
        figure; [coh, mcoh, timesout, freqsout, cohangle] = pop_newcrossf( EEG, 1, 1, 3, [-5000  5000], [2  10] ,'type', 'phasecoher', 'title','Channel 1-3 Phase Coherence','padratio', 1);
        %Command to return coherence, etc as variables at the single-subject level.

        save(outputFilename, 'coh', 'mcoh', 'timesout', 'freqsout')
        %saves the .mat file with a unique name. Listed variables are
        %saved.
        eeglab redraw
    end
end


%Notes on cross channel coherence command:
%figure; [coh, mcoh, timesout, freqsout, cohangle] = pop_newcrossf( EEG, 1, 1, 2, [-3000  2999], [2  10] ,'type', 'phasecoher', 'title','Channel 1-2 Phase Coherence','padratio', 1);
%Command to return coherence, etc as variables at the single-subject level.
%Outputs created as variables-
%       coh         = Matrix (nfreqs,timesout) of coherence magnitudes 
%       mcoh        = Vector of mean baseline coherence at each frequency
%                     see 'baseline' parameter.
%       timesout    = Vector of output latencies (window centers) (ms).
%       freqsout    = Vector of frequency bin centers (Hz).
%       cohboot     = Matrix (nfreqs,2) of [lower;upper] coher signif. limits
%                     if 'boottype' is 'trials',  (nfreqs,timesout, 2)
%       cohangle    = (nfreqs,timesout) matrix of coherence angles in radian
%       allcoher    = single trial coherence
%       alltfX      = single trial spectral decomposition of X
%       alltfY      = single trial spectral decomposition of Y
%
%Inputs- 
%       (EEG, 1, 1, 2)= EEG dataset
%       [-3000 2999]= time range of epoch to compute
%       [2 10]= number of wavelet cyles
%       'type', 'phasecoher'= type of coherence
%               other options- 'amp'- amplitude correlation
%       'title', 'Channel 1-2 Phase Coherence'- figure options
%       'padratio', 1= amount of padding