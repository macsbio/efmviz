function [numFlux, relFlux] = getFluxStats(singleEFM, data)
%getFluxStats: This function computes flux stats for a given set of efms
%  ** Detailed explanation goes here **

singleEFM = singleEFM(singleEFM~=0);
numRxns = length(singleEFM);

%% 
% match = ismember(data.rxnID, model_irr_woCof.rxns(singleEFM));
numFlux = sum(data.fluxVector(singleEFM) ~= 0);
relFlux = numFlux/numRxns * 100;

end

 