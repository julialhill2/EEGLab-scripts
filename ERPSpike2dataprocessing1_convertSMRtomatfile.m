% ERP Processing- script to take raw .smr files from animals subject to ERP
% testing and prepares them for processing in EEGlab.
% ------------------------------------------------


%importdata('filenamehere.txt');
%imports the file as a matlab variable without opening it
%x = ans.data;
%ans.data is the channel data which is needed to open the file in EEGlab
%x(any(isnan(x),2),:) = [];
%this operation finds the areas with no EEG data, listed as NaN (not a
%number) and removes those rows from the file. 
%save('adaptedfilenamehere.txt', x)

importdata('Barolo4 NT#2 KI  paired tone ERP 1-3-12.txt');
%imports the file as a matlab variable without opening it
x = ans.data;
%ans.data is the channel data which is needed to open the file in EEGlab
x(any(isnan(x),2),:) = [];
%this operation finds the areas with no EEG data, listed as NaN (not a
%number) and removes those rows from the file. 

%% ERP proccesing part 2- Importing the matlab file into EEGLab, removing the event tags for sound
% 2, and then epoching the data. 
% ------------------------------------------------

EEG = eeg_checkset( EEG );
EEG = pop_chanevent(EEG, 2,'edge','leading','edgelen',0);
%adds the event info from channel 2
EEG = eeg_checkset( EEG );
%EEG = pop_select( EEG,'nochannel',[1:3 5] );
%EEG.setname='EEG2 only';
%deletes all data but EEG2
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'delete',1,'delete',1,'delete',2,'delete',3,'delete',4,'delete',5,'delete',6,'delete',7,'delete',8,'delete',9,'delete',10,'delete',11,'delete',12,'delete',13,'delete',14,'delete',15,'delete',16,'delete',17,'delete',18,'delete',19,'delete',20,'delete',21,'delete',22,'delete',23,'delete',24,'delete',25,'delete',26,'delete',27,'delete',28,'delete',29,'delete',30,'delete',31,'delete',32,'delete',33,'delete',34,'delete',35,'delete',36,'delete',37,'delete',38,'delete',39,'delete',40,'delete',41,'delete',42,'delete',43,'delete',44,'delete',45,'delete',46,'delete',47,'delete',48,'delete',49,'delete',50,'delete',51,'delete',52,'delete',53,'delete',54,'delete',55,'delete',56,'delete',57,'delete',58,'delete',59,'delete',60,'delete',61,'delete',62,'delete',63,'delete',64,'delete',65,'delete',66,'delete',67,'delete',68,'delete',69,'delete',70,'delete',71,'delete',72,'delete',73,'delete',74,'delete',75,'delete',76,'delete',77,'delete',78,'delete',79,'delete',80,'delete',81,'delete',82,'delete',83,'delete',84,'delete',85,'delete',86,'delete',87,'delete',88,'delete',89,'delete',90,'delete',91,'delete',92,'delete',93,'delete',94,'delete',95,'delete',96,'delete',97,'delete',98,'delete',99,'delete',99);
%deletes the second sound events so only sound 1 tag remains
EEG = eeg_checkset( EEG );
EEG = pop_epoch( EEG, {  'chan2'  }, [-0.5           1], 'newname', 'EEG2 only epochs', 'epochinfo', 'yes');
%epoch the data around sound 1
EEG = eeg_checkset( EEG );
EEG = pop_rmbase( EEG, [-500    0]);
%defines the baseline
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 1, 1, 1);
%plots the data
