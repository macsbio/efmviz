% load model - irr or irr_woCof? trying irr
load('C:\Users\chaitra.sarathy\Dropbox\Chaitra\Analysis\EFM\visualizationOfEFMs\efmviz-master\efmviz-master\results\useCase1\A_modelPreprocessing\iAF1260_irr.mat')
% load EFMs
load('C:\Users\chaitra.sarathy\Dropbox\Chaitra\Analysis\EFM\visualizationOfEFMs\efmviz-master\efmviz-master\results\useCase1\C_EFMAnalysis_Submodels\efmData.mat')
% select EFMs - optional

% generate GSC from unique and filtered EFMs
rxnInd = unique(efmData);
rxnInd = rxnInd(rxnInd~=0);

GSCFileName = strcat('GSC-', 'reconTest', '.txt');  %%%
rxnTab = generateGSC(efmData, [1:length(efmData)], model_irr, GSCFileName);
% load data file

% generate GSS file
exprData.gene=datauseCase1.KEGGID;
exprData.value=datauseCase1.log2FC;
exprData.gene=datauseCase2.modelID;
exprData.value=datauseCase2.log2FC;

expressionRxns = mapExpressionToReactions(model_irr, exprData, 'true');
expressionRxns(find(expressionRxns)==-1)=0;

exprData.value = datauseCase2.PValue;
expressionRxns_p = mapExpressionToReactions(model_irr, exprData);
expressionRxns_p(find(expressionRxns_p)==-1)=0;

GSSFileName = strcat('GSS-', 'reconTest', '.txt');  %%%

rxns = model_irr.rxns(rxnInd);
writetable(table(model_irr.rxns, expressionRxns, expressionRxns_p), GSSFileName,'Delimiter',' ')