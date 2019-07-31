function [rxns, expressionRxns] = generateGSS_GPR_cobra(datauseCase1, model_irr, GSSFileName)
% input - genes, model
% initialize - rxnZScore, rxnPValue, genePValue
% output - file with 'rxn pval'


% import data
exprData.gene=datauseCase1.KEGGID;
exprData.value=datauseCase1.log2FC;
expressionRxns = mapExpressionToReactions(model, exprData, 'true');

rxns = model_irr.rxns(rxnInd);
writetable(table(rxns, expressionRxns), GSSFileName,'Delimiter',' ')