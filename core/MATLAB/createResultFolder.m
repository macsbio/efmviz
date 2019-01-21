function resultPath = createResultFolder(resultFolder,fileSeparator, useCaseFolder, workfloStepFolder)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

resultPath = [resultFolder fileSeparator useCaseFolder fileSeparator workfloStepFolder]; 
if (exist(resultPath, 'dir') == 0), mkdir(resultPath); end

end

