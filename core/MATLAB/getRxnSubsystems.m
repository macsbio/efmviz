function [subsysSummary, uniqSubsys_allEFMs, countSubPerEFM] = getRxnSubsystems(model, efmData)
% This function finds all unique subsystems in an efm

% INPUTS
% model - COBRA model that was used for EFM calculation
% efmData - matlab array containing reactions from 

% OUTPUTS
% subsysSummary - 
% uniqSubsys_allEFMs - 
% countSubPerEFM - 

% USAGE
% [subsysSummary, uniqSubsys_allEFMs, countSubPerEFM] = getRxnSubsystems(model, efmData)

% Last modified: Chaitra Sarathy, 13 Aug 2019
uniqSubsys_allEFMs = unique(string(model.subSystems(reshape(nonzeros(efmData), [], 1))));
uniqSubsys_allEFMs(find(cellfun('isempty', uniqSubsys_allEFMs)))=[];
subsysSummary = sortrows(tabulate(string(model.subSystems(reshape(nonzeros(efmData), [], 1)))),2, 'descend');
countSubPerEFM = zeros(length(uniqSubsys_allEFMs), size(efmData, 1));
for ii = 1:size(efmData, 1)
    singleEFM = nonzeros(efmData(ii,:));
    allSubsys = string(model.subSystems(singleEFM));
    for jj = 1:length(uniqSubsys_allEFMs)
        countSubPerEFM(jj,ii) = length(find(contains(allSubsys, uniqSubsys_allEFMs(jj))));
    end
end   

end
