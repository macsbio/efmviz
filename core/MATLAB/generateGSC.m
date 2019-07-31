function rxnTab = generateGSC(uniqueUptakeEFMs, EFMNum, model_irr, GSCFileName)
% input
% output - 'rxn set1'

temp = 1;

for jj = 1:size(uniqueUptakeEFMs,1)
    for kk = 1:size(uniqueUptakeEFMs,2)

        if (uniqueUptakeEFMs(jj,kk) ~= 0)
            rxnTab(jj,kk) = model_irr.rxns(uniqueUptakeEFMs(jj,kk)); 
            rxn(temp,:) = model_irr.rxns(uniqueUptakeEFMs(jj,kk));
            set(temp,:) = cellstr('EFM');
            setNum(temp,:) = cellstr(num2str(EFMNum(jj)));
            temp = temp + 1;
        else 
            rxnTab(jj,kk) = cellstr('');
        end
    end
end

gsc = [rxn, set, setNum];

% UNCOMMENT THIS CODE FOR O/P FILE FOR PIANO
fi = fopen(GSCFileName, 'w');
for row = 1:size(gsc,1)
    fprintf(fi, '%s %s%s\n', gsc{row,:});
end
fclose(fi);


% DOESNOT WORK, GO TO THE BOTTOM OF THIS SCRIPT TO PRINT rxnTab TO A FILE
% writetable(table(setNum, rxnTab), 'gSCformatted_val_S-C_uniqueUptake.txt','Delimiter',',');



















%-----------------------------------------------------------

% temp = 1;
% 
% for jj = 1:size(uniqueUptakeEFMs,1)
% % for jj = 1:3
%     for kk = 1:size(uniqueUptakeEFMs,2)
% %     for kk = 1:size(uniqueUptakeEFMs,2)
% %         if (uniqueEFMs(jj,kk) ~= 0)
% %             rxn(temp,:) = model_irr.rxns(uniqueEFMs(jj,kk));
% %             set(temp,:) = cellstr('EFM');
% %             setNum(temp,:) = cellstr(num2str(kk));        
% %             temp = temp + 1;
% %         end
%         if (uniqueUptakeEFMs(jj,kk) ~= 0)
%             rxnTab(jj,kk) = model_irr.rxns(uniqueUptakeEFMs(jj,kk)); 
%             rxn(temp,:) = model_irr.rxns(uniqueUptakeEFMs(jj,kk));
%             set(temp,:) = cellstr('EFM');
%             setNum(temp,:) = cellstr(num2str(EFMNum(jj)));
% %             setNum(temp,:) = cellstr(num2str(jj));        
%             temp = temp + 1;
%         else 
%             rxnTab(jj,kk) = cellstr('');
%         end
%     end
% end
% 
% gsc = [rxn, set, setNum];
% 
% fi = fopen(GSCFileName, 'w');
% for row = 1:size(gsc,1)
%     fprintf(fi, '%s %s%s\n', gsc{row,:});
% end
% fclose(fi);
% 

% ----------------DONT TOUCH - uncomment this code for printing rxnTab into a file (FOR GAGE) ------------------------------------------------------
% final = [cellstr(num2str(EFMNum)) rxnTab];
% fi = fopen(GSCFileName, 'w');
% for row = 1:size(final,1)
%     col = find(~cellfun(@isempty,final(row,:)));
%     text = strcat('EFM', strjoin(final(row, col),','));
%     fprintf(fi, '%s', text);
%     fprintf(fi, '\n');
% end
% fclose(fi);
% ----------------------------------------------------------------------