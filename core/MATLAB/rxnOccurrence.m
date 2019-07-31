function reactionOcc = rxnOccurrence(efmData)
% This function calculates the number of times a given reaction is present in the EFMs

% INPUTS

% OUTPUTS

% Last modified: Chaitra Sarathy, 20 May 2019
reactionOcc = sortrows(tabulate(reshape(efmData,[],1)),2,'descend');% TO DO: check previous scripts
end

