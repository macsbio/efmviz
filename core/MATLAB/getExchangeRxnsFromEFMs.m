function [efmSet_Exc, efmSet_Upt] = getExchangeRxnsFromEFMs(efmSetIndices, exchangeRxnsIndices, exchangeRxnsIndices_up)

for ii = 1:size(efmSetIndices, 1)
% for ii = 124
    temp_exc = find(ismember(efmSetIndices(ii,:), find(exchangeRxnsIndices))==1);
%     if (~isempty(temp_exc)) 
        efmSet_Exc(ii, 1:length(temp_exc)) = efmSetIndices(ii,temp_exc);
%     end
        
    temp_upt = find(ismember(efmSetIndices(ii,:), find(exchangeRxnsIndices_up))==1);
%     if(~isempty(temp_upt)) 
        efmSet_Upt(ii, 1:length(temp_upt)) = efmSetIndices(ii,temp_upt);
%     end
    
end

end
