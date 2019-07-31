function filteredEFMs = filterEFMs(efmData, roi)
% This function returns a set of EFMs to cnotain a desired reaction of
% interest

% INPUTS
% 
% roi - reaction of interest

% OUTPUTS
% filteredEFMs - ???

% Last modified: Chaitra Sarathy, 20 May 2019
[row, ~] = find(efmData == roi);
filteredEFMs = efmData(row, :);
end

