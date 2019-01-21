function model_irr = getModelIrr(model, fileNamePrefix)
%convert reversible reactions to irreversible ones
model_irr = convertToIrreversible(model); %COBRA function

%save unprocessed model as mat file

verifyModel(model_irr,'simpleCheck', true) %1

modelFileName = strcat(fileNamePrefix, '_irr');
writeCbModel(model_irr, 'format','xlsx', 'fileName', modelFileName);
save(modelFileName, 'model_irr');

end

