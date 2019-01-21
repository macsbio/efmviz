% This script performs the first step of the workflow - Model Preprocessing

clear;

%% Variable declarations
% CHANGE THIS SECTION BASED ON THE USE CASE & MODEL 

% directory corresponding to use case where results will be saved
useCaseFolder = 'useCase1'; 

% name of the model file in xml or mat formats
modelFile = 'iAF1260.xml';

% prefix used for the resulting files after preprocessing
resultsFileNamePrefix = 'iAF1260';

% name of the stoichiometric file that will be generated after
% preprocessing
SFileName = [resultsFileNamePrefix '_irr_woCof_S.txt']; 

%% Setting up dierctories
fileSeparator = '\';
modelFolder = 'model';
resultFolder = 'results'; 
treeEFMFolder = '\core\TreeEFM' ;
dataFolder = '\data';
preprocessFolder = 'A_modelPreprocessing';
efmGenerationFolder = 'B_EFMGeneration' ;
efmAnalysis_submodelsFolder = 'C_EFMAnalysis_Submodels';
dataFileName = 'data_useCase_1.xlsx';
efmSummaryFileName = 'efmSsummary.xlsx';
efmLabel = '-acRel';
submodelLabel = [resultsFileNamePrefix efmLabel];

parentPath = fileparts(mfilename('fullpath'));
modelFileFullPath = [parentPath fileSeparator modelFolder fileSeparator modelFile];

result_preprocess_Path = createResultFolder(resultFolder, fileSeparator, useCaseFolder, preprocessFolder);
cd([parentPath fileSeparator result_preprocess_Path]);


%% A. Preprocessing
[model, model_irr, model_irr_woCof] = A_modelPreprocessing_ecoli(modelFileFullPath, SFileName, resultsFileNamePrefix);

%% B. EFM Generation
cd(parentPath);
result_efmGeneration_Path = createResultFolder(resultFolder, fileSeparator, useCaseFolder, efmGenerationFolder);
treeefmPath = [parentPath treeEFMFolder];
label = B_EFMGeneration_ecoli(result_preprocess_Path, SFileName, fileSeparator, result_efmGeneration_Path, treeefmPath);

%% C. EFM Analysis - Submodel creation
result_efmAnalysis_submodels_Path = createResultFolder(resultFolder, fileSeparator, useCaseFolder, efmAnalysis_submodelsFolder);
cd([parentPath fileSeparator result_efmAnalysis_submodels_Path]);
efmFileName = ['EFM-' label '.txt'];
[efmSummaryTab, efmData, efm_filtered] = C_EFMAnalysis_submodels_ecoli(parentPath, fileSeparator, result_efmGeneration_Path, efmFileName, dataFolder, dataFileName, model_irr_woCof, efmSummaryFileName);

efmIndex = 1;
modelEFM1 = extractSBMLFromEFM(model_irr_woCof, efm_filtered(efmIndex,:), num2str(efmIndex), submodelLabel); 
efmIndex = 1;
modelEFM2 = extractSBMLFromEFM(model_irr, efm_filtered(efmIndex,:), num2str(efmIndex), [submodelLabel '_wCoF']); 
efmIndex = 214;
modelEFM3 = extractSBMLFromEFM(model_irr_woCof, efm_filtered(efmIndex,:), num2str(efmIndex), submodelLabel); 
efmIndex = 214;
modelEFM1 = extractSBMLFromEFM(model_irr, efm_filtered(efmIndex,:), num2str(efmIndex), [submodelLabel '_wCoF']); 

cd(parentPath);

