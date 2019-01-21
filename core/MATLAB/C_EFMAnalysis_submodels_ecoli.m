function [efmSummaryTab, efmData, efm_filtered] = C_EFMAnalysis_submodels_ecoli(parentPath, fileSeparator, result_efmGeneration_Path, efmFileName, dataFolder, dataFileName, model_irr_woCof, efmSummaryFileName)

% import the generated efms 
efmData = getAllEFMs([parentPath fileSeparator result_efmGeneration_Path fileSeparator], efmFileName);
save('efmData.mat', 'efmData');
% EFM Selection: containing another reaction of interest
% Here, among the EFMs that take up glucose, select EFMs that also release
% lactate
selRxnInd = 2594; % index of the selected reaction
[g1, ~] = find(efmData == selRxnInd);
efm_filtered = efmData(g1,:); %5
save('efm_filtered.mat', 'efm_filtered');

% Import data to calculate data-related features
% In this case, import gene exp data & simulated fluxes
sheetNum = 1;
columns = 'A:C';
textEndCol = 1;
geneDataTab = loadDataForSelection([parentPath fileSeparator dataFolder fileSeparator], dataFileName, sheetNum, columns, textEndCol);

% calculate efm features:
efmSummaryTab = efmFeatures_ecoli(efm_filtered, model_irr_woCof, geneDataTab);
writetable(efmSummaryTab, efmSummaryFileName);


end

