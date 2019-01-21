function dataTab = loadDataForSelection(fileLocation, dataFileName, sheetNum, columns, textEndCol)


[numData, text] = xlsread([fileLocation dataFileName], sheetNum, columns);
header = text(1, :);

dataTab = text(2:end, 1:textEndCol);

dataTab = [dataTab array2table(numData)];
dataTab.Properties.VariableNames = header;


end

