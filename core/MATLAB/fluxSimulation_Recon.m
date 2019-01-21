function fluxSimulation_Recon(parentPath, fileSeparator, result_preprocess_Path, unprocessedModelName, processedModelName, model, gxData, simFluxesFileName)

    %This script simulates fluxes using FBA for use case 2

    %% FBA
    % First, a cancer-specific model is obtained using gene expression data.
    % Then FBA is performed for maximizing lactate production under anaerobic
    % conditions

    % Setting up working directory


    % Change solver for the present simulation
    changeCobraSolver('glpk','all');

    % Import the recon22 model
    load([parentPath fileSeparator result_preprocess_Path  fileSeparator unprocessedModelName]);

    % Make sure upper and lower bounds are not infinity
    model.lb(model.lb == -Inf) = -1000;
    model.ub(model.ub == Inf) = 1000;

    % Simulate RPMI media conditions
    RPMImediumSimulation;

    % Import the gene expression data

    % Create an index of all genes with expression of 0
    index = string(table2array(gxData(:,3))) == '0';

    % Remove genes with 0 expression from model
    genesToRemove = intersect(table2cell(gxData(index,2)), modelRPMI.genes);
    [modelRPMIcancer, hasEffect, constrRxnNames, deletedGenes] =... 
        deleteModelGenes(modelRPMI, genesToRemove);


    % Perform FBA for maximizing lactate production under anaerobic conditions
    modelRPMIcancer.lb(contains(modelRPMIcancer.rxns, 'EX_lac_L(e)')) = -1000;
    modelanaerobicC = changeObjective(modelRPMIcancer, 'EX_lac_L(e)');
    FBAanaerobicC = optimizeCbModel(modelanaerobicC, 'max');

    %% Map simulated fluxes from the unprocessed model to the processed model

    % Import the model used for EFM Generation, i.e., 
    % with irreversible reactions and cofactors removed
    load([parentPath fileSeparator result_preprocess_Path  fileSeparator processedModelName]);

    % Get the indices of the reversed reactions
    [modelIrrev, matchRev] = convertToIrreversible(model);

    % Assign positive flux to forward rxn and neg flux to backward reaction
    % Vector containing mapped fluxes
    fluxVector = zeros(length(model_irr_woCof.rxns),1);

    % for each rxn in the processed model,
    for ii = 1:length(model.rxns)
        % copy flux for the forward reactions
        fluxVector(ii) = FBAanaerobicC.x(ii);
        % if a backward reaction and flux exists, copy opposite sign of flux to
        % the backward reaction, else copy as is 
        if (matchRev(ii) ~= 0)
            if (FBAanaerobicC.full(ii) ~= 0)
                fluxVector(matchRev(ii)) = -FBAanaerobicC.x(ii);
            else
                fluxVector(matchRev(ii)) = FBAanaerobicC.x(ii);
            end
        end
    end
    rxnID = model_irr_woCof.rxns;
    simfluxData = table(rxnID, fluxVector);
    writetable(simfluxData, simFluxesFileName);

end


