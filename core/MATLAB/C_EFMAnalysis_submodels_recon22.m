function [efmSummaryTab, efmData, efm_filtered] = C_EFMAnalysis_submodels_recon22(parentPath, fileSeparator, result_preprocess_Path, result_efmGeneration_Path, unprocessedModelName, processedModelName, efmFileName, dataFolder, dataFileName, model_irr_woCof, efmSummaryFileName, simFluxesFileName)

% import the generated efms 
efmData = getAllEFMs([parentPath fileSeparator result_efmGeneration_Path fileSeparator], efmFileName);
save('efmData.mat', 'efmData');
% EFM Selection: containing another reaction of interest
% Here, among the EFMs that take up glucose, select EFMs that also release
% lactate
selRxnInd = 6613; % index of the selected reaction
[g1, ~] = find(efmData == selRxnInd);
efm_filtered = efmData(g1,:); %5
save('efm_filtered.mat', 'efm_filtered');

% Simulate Fluxes which are subsequently used for calculating data-related features of
% EFMs
sheetNum = 3;
columns = 'A:C';
% set the column where the numbers start
textEndCol = 2; 
gxData = loadDataForSelection([parentPath fileSeparator dataFolder fileSeparator], dataFileName, sheetNum, columns, textEndCol);
fluxSimulation_Recon(parentPath, fileSeparator, result_preprocess_Path, unprocessedModelName, processedModelName, model_irr_woCof, gxData, simFluxesFileName)
% fluxSimulation_Recon;

% Import data to calculate data-related features
% In this case, import gene exp data & simulated fluxes
sheetNum = 1;
columns = 'A:B';
% set the column where the numbers start
textEndCol = 1; 
fluxDataTab = loadDataForSelection([], simFluxesFileName, sheetNum, columns, textEndCol);
sheetNum = 1;
columns = 'A:F';
textEndCol = 3;
geneDataTab = loadDataForSelection([parentPath fileSeparator dataFolder fileSeparator], dataFileName, sheetNum, columns, textEndCol);

% calculate efm features:
efmSummaryTab = efmFeatures_recon22(efm_filtered, model_irr_woCof, fluxDataTab, geneDataTab);
writetable(efmSummaryTab, efmSummaryFileName);


end

