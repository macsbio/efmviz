function uniqueSubsystems(model,efmData)
%%This function identifies the subsystems of all EFMs provided as
%input

% INPUTS

% OUTPUTS

% Last modified: Chaitra Sarathy, 20 May 2019

% first, get all the unique reactions
rxnInd = unique(efmData);
rxnInd = rxnInd(rxnInd~=0);

% get subsystems from the model
rxnSubsys = model.subSystems(rxnInd);

% return frequency table of unique subsystems

end

