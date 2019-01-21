function efmData = getAllEFMs(fileLocation, efmFileName)
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

