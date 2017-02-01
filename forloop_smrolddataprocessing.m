%% Setup Matlab
clearvars
close all
clc
warning off %turns off annoying warning messages
%% Set paths
mainpath='D:\JH\ephys\8.2015_Barolo4AEP\'; %update this with your path
%mainpath='C:\Users\Madineh\Dropbox\Julie\'; %update this with your path
filepath='D:\JH\ephys\8.2015_Barolo4AEP\txt files\'; % a subfolder inside the main fodler that holds the .edf (and produced) .mat files

cd(mainpath);
addpath(genpath(mainpath));
%% Let's start wth a sample file

files=[dir('*.txt')]; %find all the .txt files in folder
nfiles=length(files); %number of files in folder
%myfilename=zeros(length(files),1);
%data=(20000000,4);

for k=1:nfiles
    myfilename = (files(k,1).name); %DO NOT DELETE
    x = importdata(myfilename); %DO NOT DELETE
    x(k) = [x] %DO NOT DELETE
    x = x(1,k).data;
    x(any(isnan(x),2),:) = [];
    filename = [' ' num2str(myfilename) '.txt'];
    filename = filename(1:end-8);
    filename = [filename, '.mat'];
    save(filename, 'x')
    %save('.mat', 'x'); 
    
    
    %myfilename = sprintf('%s.txt', k);
    %x(k) = x(1,k).data;
    %x(any(isnan(x),2),:) = [];
    %x = x(1,k).data;
    %x(any(isnan(x),2),:) = [];
    
   
    %files{k} = importdata(myfilename);
    %x = ans.data;
    %ans.data is the channel data which is needed to open the file in EEGlab
    %x(any(isnan(x),2),:) = [];
    %this operation finds the areas with no EEG data, listed as NaN (not a
    %number) and removes those rows from the file. 
end
myfilename
% for i=1:length(files)
%eval(['load ' files(i).name ' -ascii']);

%%
for k=1:nfiles
    load('*.txt');
end
