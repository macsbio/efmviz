function metConnectionsTab = getMetaboliteConnections(model_irr)
% CODE FOR CALCULATING THE NUMBER OF REACTIONS EACH METABOLITE IS INVOLVED

s=model_irr.S;

%count the number of reactions per metabolite
[m,n]=size(s);
for row=1:m
    num=0;    
    for col=1:n;
         if s(row,col)~=0
             num=num+1;                       
        end
    end
    numReactions(row,1)=num;
end
[a, i]=sort(numReactions,'descend');
% sorted = model_irr.metNames(i);

metNames = cellstr(model_irr.mets(i));
metConnections = num2cell(a);
metConnectionsTab = table(metNames,metConnections);

end

