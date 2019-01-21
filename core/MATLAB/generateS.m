function model_irr_woCof = generateS(model_irr, listOfAbundantMets, SFileName, fileNamePrefix)


%INCLUDE AND MODIFY THE LIST OF COFACTORS (AS PER THE MODEL) IF THEY NEED TO BE REMOVED

% This is a COBRA function to remove metabolites
model_irr_woCof = removeMetabolites(model_irr, listOfAbundantMets, false); 

verifyModel(model_irr_woCof,'simpleCheck', true); %1

%find the indices of reactions(column) each metabolite(row) is involved in
[r1, c1, v1]=find(model_irr_woCof.S);
f1=fopen(SFileName, 'w+');
for ii=1:size(r1)
    fprintf(f1, '%d, %d, %d\n', r1(ii), c1(ii), v1(ii));
    
end
fclose(f1);
disp(['File ', SFileName, ' has been created']);


modelFileName = strcat(fileNamePrefix, '_irr_woCof');
writeCbModel(model_irr_woCof, 'format','xlsx', 'fileName', modelFileName);
save(modelFileName, 'model_irr_woCof');
end