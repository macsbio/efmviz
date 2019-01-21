function [totalNumGene, numGeneMatch, countdiffExp, rel_countGenes] = getGeneStats_recon22(modelIrr, singleEFM, data)
%getGeneStats This function computes gene stats for a given set of efms
%  ** Detailed explanation goes here **

modelIrr = buildRxnGeneMat(modelIrr); %added on 4Sep18: model doesn't have the field 'rxnGeneMat'
singleEFM = singleEFM(singleEFM~=0);

[~, genes] = find(modelIrr.rxnGeneMat(singleEFM,:));
totalNumGene = length(unique(genes));

%% use this code for selected data sheet in data-use-case1.xlsx
match = find(ismember(data.modelID, modelIrr.genes(unique(genes))));
numGeneMatch = length(match);

countdiffExp = sum(abs(data.log2FC(match)) > 0.58);
rel_countGenes = countdiffExp/numGeneMatch*100;

end