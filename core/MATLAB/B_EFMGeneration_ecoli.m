function label = B_EFMGeneration_ecoli(result_preprocess_Path, SFileName, fileSeparator, result_efmGeneration_Path, treeefmPath)
%% STEP B: EFM GENERATION

% This function generates EFMs taking up glucose in the Recon 2.2 model
% The code below sets parameters for running TreeEFM
% For more details, please refer to:
% https://academic.oup.com/bioinformatics/article/31/6/897/214785


inputFileFullPath = ['-i ' result_preprocess_Path fileSeparator SFileName ' ' ];

% glucose uptake reaction
% reaction index: 10757, reaction name: EX_glc(e)_b	D-Glucose exchange	 -> glc_D[e] 
reactionIndex = '729';
activeReaction = ['-r ' reactionIndex ' ' ];

% precision
precisionFlag = '-z 1e-6 ' ; %default

% stop condition
stopEFMs = '10000' ;
stopEFMFlag = ['-e ' stopEFMs ' '] ;

% resulting file name prefix
metaboliteLabel = 'acetate' ;
label = [metaboliteLabel '-E' stopEFMs  '-' reactionIndex];
labelFlag = ['-l ' label ' '];

% the flag that allows generation of a text file containing the active reactions of every EFM
activeRxnFlag = '-a ';

% mode of operating TreeEFM: deterministic or random
modeFlag = '-d drop 100 ';

% folder for rseults
outputFolderFlag = ['-o ' result_efmGeneration_Path ' ' ];

% log file with results of TreeEFM
logFile = ['> ' result_efmGeneration_Path fileSeparator 'OUT-' metaboliteLabel '-E' stopEFMs  '-R' reactionIndex '.txt' ];


EFMparameters = [activeReaction inputFileFullPath precisionFlag labelFlag stopEFMFlag activeRxnFlag modeFlag outputFolderFlag logFile];
FluxVectorParameters = ['-b ' result_efmGeneration_Path fileSeparator 'FV-' label '.dat'];

system([treeefmPath '\TreeEFMseq.exe ' EFMparameters]);
system([treeefmPath '\TreeEFMseq.exe ' FluxVectorParameters]);

end
