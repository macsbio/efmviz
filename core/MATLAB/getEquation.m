function equation = getEquation(model, efmData)
%This function identifies the overall equation of all EFMs provided as
%input

% INPUTS
% model - COBRA model structure (use the same model that was used for EFM
% generation) (use model_irr_woCof if EFMs were computed without abundant metabolites)
% efmData - array of EFMs with each row representing an EFM
%
% OUTPUTS
% equation - ???
% Last modified: Chaitra Sarathy, 20 May 2019

% 27 May 2019
% Logic:
% find metabolites that whose reaction participation does not sum up to
% zero. separate out negative and positive stoichiometries
equation = strings(1,size(efmData,1));
for ii=1:size(efmData,1)
    efm = nonzeros(efmData(ii,:));
    modelEFM = extractSBMLFromEFM(model, efm, 1, 1);
    overallRxn = sum(modelEFM.S, 2);
    products = modelEFM.mets(sum(modelEFM.S, 2)>0);
    reactants =  modelEFM.mets(sum(modelEFM.S, 2)<0);
    lhs = '';
    rhs = '';
    for jj = 1:length(overallRxn)
        if overallRxn(jj) ~= 0 && overallRxn(jj)<0 
            if length(reactants)==1
                lhs = strcat(string(abs(overallRxn(jj))), string(modelEFM.mets(jj)), '');
            else
                lhs = strcat(lhs, string(abs(overallRxn(jj))), string(modelEFM.mets(jj)), '+');                
            end
        elseif overallRxn(jj) ~= 0 && overallRxn(jj)>0 
            if length(products)==1
                rhs = strcat(string(abs(overallRxn(jj))), string(modelEFM.mets(jj)), '');
            else
                rhs = strcat(rhs, string(abs(overallRxn(jj))), string(modelEFM.mets(jj)), '+');
            end            
        end
    end
    equation(ii) = strcat(lhs, '->', rhs);
% TO DO: 
% lhs and rhs are empty
% cases when either lhs or rhs are empty?
% remove trailing +
end

end

