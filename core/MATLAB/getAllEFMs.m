function efmData = getAllEFMs(fileLocation, efmFileName)
% This function reads the file containing all EFMs
% INPUTS
% fileLocation - location of the file containing all EFMs
% efmFileName - name of the file containing all EFMs <name.txt>

% OUTPUTS
% efmData - matlab array containing reactions from 

% USAGE
% efmData = getAllEFMs('C:/Analysis/', 'test.txt');
% efmData = getAllEFMs('', 'test.txt'); % when the file is in the current
% directory

% Last modified: Chaitra Sarathy, 13 Aug 2019
fid = fopen([fileLocation efmFileName]);
    
data = fgetl(fid);    
numEFMs = 1;
while ischar(data)
    temp = str2num(data);
    efmData(numEFMs,1:size(temp, 2)) = temp;
    data = fgetl(fid);
    numEFMs = numEFMs+1;
end
fclose(fid);
end

