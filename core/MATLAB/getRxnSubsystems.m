function [subsysSummary, uniqSubsys_allEFMs, countSubPerEFM] = getRxnSubsystems(model_irr, efmData)
% getRxnSubsystems finds all unique subsystems in an efm
%   *********Detailed explanation goes here
uniqSubsys_allEFMs = unique(string(model_irr.subSystems(reshape(nonzeros(efmData), [], 1))));
uniqSubsys_allEFMs(find(cellfun('isempty', uniqSubsys_allEFMs)))=[];
subsysSummary = sortrows(tabulate(string(model_irr.subSystems(reshape(nonzeros(efmData), [], 1)))),2, 'descend');
countSubPerEFM = zeros(length(uniqSubsys_allEFMs), size(efmData, 1));
for ii = 1:size(efmData, 1)
    singleEFM = nonzeros(efmData(ii,:));
%     tabulate(string(model.subSystems(singleEFM)));
%     uniqSubsys = unique(string(model_irr.subSystems(singleEFM)));
    allSubsys = string(model_irr.subSystems(singleEFM));
    for jj = 1:length(uniqSubsys_allEFMs)
        countSubPerEFM(jj,ii) = length(find(contains(allSubsys, uniqSubsys_allEFMs(jj))));
    end
end   
% efmSub = table(uniqSubsys_allEFMs, countSubPerEFM);
%     uniqSubsys = unique([model.subSystems{singleEFM}]);
%     uniqSubsys = uniqSubsys(~cellfun('isempty',uniqSubsys));
%     efmSubsysString = strjoin(uniqSubsys, ', ');

end
