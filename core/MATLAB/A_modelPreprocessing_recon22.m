function [model, model_irr, model_irr_woCof] = A_modelPreprocessing_recon22(modelFileLocation, SFileName, fileNamePrefix)
% This script performs all the preprocessing steps required for generating
% EFMs using TreeEFM

% Inputs:

% Outputs:


%% STEP 0 - Read model file
model = readCbModel(modelFileLocation);
%save unprocessed model as excel file
writeCbModel(model, 'format','xlsx', 'fileName', fileNamePrefix);
save(fileNamePrefix, 'model');

%% model preprocessing and generation of text file of stoichiometry

% STEP A1 - REACTION CONVERSION: Convert reversible reactions to irreversible reactions
model_irr = getModelIrr(model, fileNamePrefix);

% STEP A2 - COFACTOR REMOVAL 
% Cofactor selection - find number of connections
metConnectionsTab = getMetaboliteConnections(model_irr);
metConnectionsFile = strcat('metConnections_', fileNamePrefix, '.xlsx');
writetable(metConnectionsTab, metConnectionsFile);

% Mmanual selection of cofactors/ abundant metabolites to remove
selectedMets = {'h';'h2o';'na1';'atp';'datp';'hco3';'pi';'adp';'dadp';'nadp';'nadph';'coa';'o2';'nad';'nadh';'ppi';'pppi';'amp';'so4';'fad';'fadh2';'udp';'dudp';'co2';'h2o2';'nh4';'ctp';'utp';'gtp';'cdp';'gdp';'dcdp';'dgdp';'dtdp';'dctp';'dttp';'dutp';'dgtp';'cmp';'gmp';'ump';'dcmp';'dtmp';'dgmp';'dump';'damp';'cl'};
[~, uniqComps] = getCompartment(model.mets);
temp = cellfun(@(x) strcat(x, '[', uniqComps, ']'), selectedMets,'UniformOutput' ,0);
listOfAbundantMets = vertcat(temp{:});
%----

% STEP A4 - MODIFIED S MATRIX FILE
% the abundant metabolites selected above are removed and S matrix is
% written
model_irr_woCof = generateS(model_irr, listOfAbundantMets, SFileName, fileNamePrefix);


end

