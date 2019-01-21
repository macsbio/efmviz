function metcomp = extractExMetsForEachEFM(model, efmSet_exchInd)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% convert array to cell
temp = num2cell(efmSet_exchInd);

% replace zeros with empty string
temp = cellfun(@(x) nonzeros(x), temp, 'UniformOutput', false);

%get rxns from cell
% r = cellfun(@(x) iAdipocyte1809_ex_irr_woCof.rxns(x), temp, 'UniformOutput', false);

% get index/indices of reactant/product metabolites in exchange rxns
sind = cellfun(@(x) find(model.S(:,x)), temp, 'UniformOutput', false);

% get names and compartment of exchanged metabolites and concatenate them
% in the format - 'metName[metComp]'
metcomp = cellfun(@(x) model.mets(x), sind, 'UniformOutput', false);
% mc = cellfun(@(x) model.comps(model.metComps(x)), sind, 'UniformOutput', false);
% metcomp = cellfun(@(x,y) strcat(x, '[', y, ']'), met, mc, 'UniformOutput', false);

end

