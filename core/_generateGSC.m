function rxnTab = generateGSC(EFMRxns, EFMNum, model, GSCFileName)
% input
% output - 'rxn set1'

temp = 1;

for jj = 1:size(EFMRxns,1)
    for kk = 1:size(EFMRxns,2)

        if (EFMRxns(jj,kk) ~= 0)
            rxnTab(jj,kk) = model.rxns(EFMRxns(jj,kk)); 
            rxn(temp,:) = model.rxns(EFMRxns(jj,kk));
            set(temp,:) = cellstr('EFM');
            setNum(temp,:) = cellstr(num2str(EFMNum(jj)));
            temp = temp + 1;
        else 
            rxnTab(jj,kk) = cellstr('');
        end
    end
end

gsc = [rxn, set, setNum];

fi = fopen(GSCFileName, 'w');
for row = 1:size(gsc,1)
    fprintf(fi, '%s %s%s\n', gsc{row,:});
end
fclose(fi);
end