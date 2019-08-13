function filteredEFMs = filterEFMs(efmData, roi)
% This function returns a set of EFMs to cnotain a desired reaction of
% interest

% INPUTS
% efmData - matlab array containing reactions in EFMs (each row is an EFM 
            % and every entry indicates the reaction IDs in the EFM) 
% roi - ID of reaction of interest as in the input model

% OUTPUTS
% filteredEFMs - subset of EFMs containing reaction of interest

% USAGE
% filteredEFMs = filterEFMs(efmData, 729);
% 729 is the ID for acetate release reaction in the iAF1260 model

% Last modified: Chaitra Sarathy, 13 Aug 2019
[row, ~] = find(efmData == roi);
filteredEFMs = efmData(row, :);
end

