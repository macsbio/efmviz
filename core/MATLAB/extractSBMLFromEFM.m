function modelEFM = extractSBMLFromEFM(model, data) 
%This function takes an input array containing reaction indices of an EFM
%and extracts a model (SBML-non-COBRA) which can be visualised in Cytoscape

% INPUT
% data - array of reaction IDs after EFM processing

% OUTPUT
% modelEFM - submodel containing reactions, metabolites and genes in the
% EFM of interest

% USAGE
% data = [1 2 3 4 5]; % select first 5 reactions 
% modelEFM = extractSBMLFromEFM(model, data) ;

% Last modified: Chaitra Sarathy, 13 Aug 2019

%remove reactions other than those in EFM
rxnRemoveList = model.rxns(setdiff(1:length(model.rxns), data));

% write a model with the reactions (and corresponding metabolites) from the
% EFM
modelEFM = removeRxns(model, rxnRemoveList);

% the unused genes in the model do not get removed, so remove mannually
modelEFM = removeUnusedGenes(modelEFM);

% writeCbModel(modelEFM, 'format','sbml', 'fileName', outputFileName);

% success=['File ', outputFileName, ' has been created'];
% disp(success);
end

