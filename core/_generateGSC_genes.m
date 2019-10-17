function rxnTab = generateGSC_genes(data, rowIndex, model_irr, GSCFileName, setPrefix)
% input
% output - 'rxn set1'

temp = 1;

for jj = 1:size(data,1)
    for kk = 1:size(data,2)

        if (data(jj,kk) ~= 0)
            rxnTab(jj,kk) = model_irr.genes(data(jj,kk)); 
            geneID(temp,:) = model_irr.genes(data(jj,kk));
            genesetPrefix(temp,:) = cellstr(setPrefix);
            setID(temp,:) = cellstr(num2str(rowIndex(jj)));
            temp = temp + 1;
%         else 
            rxnTab(jj,kk) = cellstr('');
        end
    end
end

gsc = [geneID, genesetPrefix, setID];

fi = fopen(GSCFileName, 'w');
for row = 1:size(gsc,1)
    fprintf(fi, '%s %s%s\n', gsc{row,:});
end
fclose(fi);