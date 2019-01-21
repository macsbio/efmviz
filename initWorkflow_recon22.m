% This script performs the first step of the workflow - Model Preprocessing

clear;

%% Variable declarations
% CHANGE THIS SECTION BASED ON THE USE CASE & MODEL 

% directory corresponding to use case where results will be saved
useCaseFolder = 'useCase2'; 

% name of the model file in xml or mat formats
modelFile = 'recon22.xml';

% prefix used for the resulting files after preprocessing
resultsFileNamePrefix = 'recon2_2';

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
dataFileName = 'data_useCase_2.xlsx';
simFluxesFileName = 'simFluxes_recon22_cancer.xlsx';
efmSummaryFileName = 'efmSsummary.xlsx';
efmLabel = '-glcUp';
submodelLabel = [resultsFileNamePrefix efmLabel];

parentPath = fileparts(mfilename('fullpath'));
modelFileFullPath = [parentPath fileSeparator modelFolder fileSeparator modelFile];

result_preprocess_Path = createResultFolder(resultFolder, fileSeparator, useCaseFolder, preprocessFolder);
cd([parentPath fileSeparator result_preprocess_Path]);


%% A. Preprocessing
[model, model_irr, model_irr_woCof] = A_modelPreprocessing_recon22(modelFileFullPath, SFileName, resultsFileNamePrefix);

%% B. EFM Generation
cd(parentPath);
result_efmGeneration_Path = createResultFolder(resultFolder, fileSeparator, useCaseFolder, efmGenerationFolder);
treeefmPath = [parentPath treeEFMFolder];
label = B_EFMGeneration_recon22(result_preprocess_Path, SFileName, fileSeparator, result_efmGeneration_Path, treeefmPath);

%% C. EFM Analysis - Submodel creation
result_efmAnalysis_submodels_Path = createResultFolder(resultFolder, fileSeparator, useCaseFolder, efmAnalysis_submodelsFolder);
cd([parentPath fileSeparator result_efmAnalysis_submodels_Path]);
efmFileName = ['EFM-' label '.txt'];
unprocessedModelName = [resultsFileNamePrefix '.mat'];
processedModelName = [resultsFileNamePrefix '_irr_woCof.mat'];
[efmSummaryTab, efmData, efm_filtered] = C_EFMAnalysis_submodels_recon22(parentPath, fileSeparator, result_preprocess_Path, result_efmGeneration_Path, unprocessedModelName, processedModelName, efmFileName, dataFolder, dataFileName, model_irr_woCof, efmSummaryFileName, simFluxesFileName);

efmIndex = 2;
modelEFM1 = extractSBMLFromEFM(model_irr_woCof, efm_filtered(efmIndex,:), num2str(efmIndex), submodelLabel); 
cd(parentPath);

