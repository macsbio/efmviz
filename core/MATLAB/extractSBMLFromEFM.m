function modelEFM = extractSBMLFromEFM(model, data, efmNum, efmReacNum) 
%This function takes an input array containing reaction indices of an EFM
%and extracts a model (SBML-non-COBRA) which can be visualised in Cytoscape

% INPUT
% data - array of reaction IDs after EFM processing
% efmNum - the index of EFM in the output of TreeEFM
% efmREacNum - the reaction ID for which the EFMs were generated

outputFileName = strcat(efmReacNum, '_', 'efm', efmNum, '.xml');

%remove reactions other than those in EFM
rxnRemoveList = model.rxns(setdiff(1:length(model.rxns), data));

% write a model with the reactions (and corresponding metabolites) from the
% EFM
modelEFM = removeRxns(model, rxnRemoveList);

% the unused genes in the model do not get removed, so remove mannually
modelEFM = removeUnusedGenes(modelEFM);

writeCbModel(modelEFM, 'format','sbml', 'fileName', outputFileName);

success=['File ', outputFileName, ' has been created'];
disp(success);
end

