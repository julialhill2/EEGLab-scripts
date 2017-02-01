# EEGLab-scripts
Scripts used for processing data in EEGLab

The .m files contained in this folder all contain scripts for processing data semi-automatically using EEGLab. 

For EEG data recorded in Spike 2, the files entitled "ERPSpike2dataprocessing" 1 and 2 will take that data and assist you at getting it into EEGLab. "forloop_smrolddataprocessing" is a script I wrote for the BDNFe4 paper which is probably better to use than the step1 of the spike2 files, as it will do batch processing. 

Data recorded in Sirenia Acquisition can be processed usng the "EEGprocessing_masterscript". This file is a pretty in-depth guide at which also has instructions on how the data has to be pre-processed to use with the script. This script will put the data into epoched format and perform component analysis once the data is in studyset format. Script "EEGLAB_extractingtimefrequencyanalysis_results.m" will allow for exporting ERSP and ITC analysis to excel. 

"batch_freezing_extractingepochs.m"- An example of how you can take continuous data from a behavior file and use an event stored in its own channel to epoch the data. Will work across multiple files in a folder. 

"creating_continuousdataforPACplugin.m" will take epoched EEGLAB data and turn it back into a continuous data format. It's necessary to do this for phase amplitude coupling, but it's generally useful anytime you need continuous data. 

"multipledataset_phasecoherence.m" allows for cross channel coherence analysis across multiple datasets loaded in EEGLAB. 

"ITCpeaklatency" is a script I wrote for processing the TCF4 data. It's based on the component analysis technique. I calculated the theta averages for each animal, and then this script within a given time range will find the peak theta ITC, as well as its latency. 
