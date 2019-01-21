function efmSummaryTab = efmFeatures_ecoli(efmData, model_irr_woCof, geneDataTab)


for aa = 1:size(efmData, 1)
    efmIndex(aa,1) = aa;
    numRxns(aa,1) = length(find(efmData(aa,:)));
    [totalNumGene(aa,1), numTotalGeneMatch(aa,1), numGeneDiffExp(aa,1), relGeneMatch(aa,1)] = getGeneStats_ecoli(model_irr_woCof, efmData(aa,:), geneDataTab);
    % find all unique subsystems in an efm
    efmSubsysString{aa} = getRxnSubsystems(model_irr_woCof, efmData(aa,:));
end

%3. exchange rxns
[selExc,selUpt] = findExcRxns(model_irr_woCof,'false','true');

[efmSet_Exc, efmSet_Upt] = getExchangeRxnsFromEFMs(efmData, selExc, selUpt);

metc_exc = extractExMetsForEachEFM(model_irr_woCof, efmSet_Exc);
metc_up = extractExMetsForEachEFM(model_irr_woCof, efmSet_Upt);

% summary = table(efmNum, efmLength);
% summary = sortrows(summary, 2);
efmSubsysString = efmSubsysString';
efmSummaryTab = table(efmIndex, numRxns, totalNumGene, numTotalGeneMatch, numGeneDiffExp, relGeneMatch, efmSubsysString, metc_exc, metc_up);
efmSummaryTab = sortrows(efmSummaryTab,  [6 2], {'descend' 'ascend'});


end

