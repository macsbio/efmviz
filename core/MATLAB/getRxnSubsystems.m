function efmSubsysString = getRxnSubsystems(model_irr_woCof, singleEFM)
% getRxnSubsystems finds all unique subsystems in an efm
%   *********Detailed explanation goes here
    singleEFM = singleEFM(singleEFM ~= 0);
    uniqSubsys = unique([model_irr_woCof.subSystems{singleEFM}]);
    uniqSubsys = uniqSubsys(~cellfun('isempty',uniqSubsys));
    efmSubsysString = strjoin(uniqSubsys, ', ');

end
