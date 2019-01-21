library(RCy3)
library(tidyverse)
library(readxl)
library(RColorBrewer)
cytoscapePing()


nwName = 'iAF1260-acRel_efm1'
useCaseDir = ''
styleName = "efmviz_style"

setwd(dirname(getActiveDocumentContext()$path))

workingDir = ''

# ------------ basicNwOperations ----------
# Get all networks
if (getNetworkCount()==3){
  nL = getNetworkList()
  for (ii in nL){
    # Delete all and kinetic
    if(startsWith(getNetworkName(getNetworkSuid(ii)), "All") | startsWith(getNetworkName(getNetworkSuid(ii)), "Kinetic")){
      deleteNetwork(network = getNetworkSuid(ii))
    }
    else{
      setCurrentNetwork(network = getNetworkSuid(ii))
    }
  }
}

# Rename base = filename
renameNetwork(nwName)



# ------ Network modification with data -----------
loadEcoliData = function(){
  nodeTab = getTableColumns(table = "node", columns = c("label", "sbml type"))
  
  # nodeTab = data.frame(nodeTab, stringsAsFactors = F)
  
  
  #import external data - ecoli gene names
  ecoli_kegg = read_excel("C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/analysis_github/data/data_useCase_1.xlsx", sheet = 2)
  
  
  # Add gene label in df
  nodeTab[,"nodeLabels"] = character()
  nodeTab$nodeLabels = nodeTab$label
  nodeTab$nodeLabels[which(nodeTab$label %in% ecoli_kegg$geneID)] = ecoli_kegg$geneAbbr[which(ecoli_kegg$geneID %in% nodeTab$label)]
  
  # Remove rxn label
  nodeTab$nodeLabels[which(nodeTab$`sbml type` == "reaction")] = ""
  
  loadTableData(data = nodeTab, data.key.column = "label", table = "node", table.key.column = "label")
  
  # write.csv(nodeTab, file="test.csv", sep=",", col.names = T)
  
  # Add data 
  data_ecoli = read_excel("C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/analysis_github/data/data_useCase_1.xlsx", sheet = 1)
  
  #merge both tables
  nodeTab_withData = merge(x=nodeTab, y=data_ecoli, by.x = "label", by.y="KEGGID", all.x=T)
  nodeTab_withData = nodeTab_withData[!is.na(nodeTab_withData$log2FC),]
  
  
  # Export table to cytoscape
  loadTableData(data = nodeTab_withData, data.key.column = "label", table = "node", table.key.column = "label")
  setNodeColorMapping('log2FC', c(-2,0,2), c("#3182bd","#f5f5f5","#de2d26"), style.name=styleName)
}

loadHumanData = function(){
  setVisualStyle(style.name = styleName)
  nodeTab = getTableColumns(table = "node", columns = c("label", "sbml type", "name", "cyId"))
  # nodeTab = data.frame(nodeTab, stringsAsFactors = F)
  
  
  #import gene symbol information
  human_geneNames = read_excel("C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/analysis_github/data/data_useCase_2.xlsx", sheet = 2)


  # Add gene label in df
  nodeTab[,"nodeLabels"] = character()
  nodeTab$nodeLabels = nodeTab$label
  nodeTab$nodeLabels[which(nodeTab$label %in% human_geneNames$HGNCID)] = human_geneNames$GeneSymbol[which(human_geneNames$HGNCID %in% nodeTab$label)]
  
  # Remove rxn label
  nodeTab$nodeLabels[which(nodeTab$`sbml type` == "reaction")] = ""
  
  loadTableData(data = nodeTab, data.key.column = "label", table = "node", table.key.column = "label")
  
  # write.csv(nodeTab, file="test.csv", sep=",", col.names = T)
  
  # Add data 
  # LOAD IT MANUALLY
  cancerGEx = read_excel("C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/analysis_github/data/data_useCase_2.xlsx", sheet = 1)
  cancerGEx[,"HGNCID"] = character()
  cancerGEx$HGNCID[which(cancerGEx$GeneID %in% human_geneNames$EnsemblID)] = human_geneNames$HGNCID[which(human_geneNames$EnsemblID %in% cancerGEx$GeneID)]
  
  
  #merge both tables
  nodeTab_withData = merge(x=nodeTab, y=cancerGEx, by.x = "label", by.y="HGNCID", all.x=T)
  #node fill
  # min_cancer_expr = min(nodeTab_withData$log2FC,na.rm=TRUE)
  # max_cancer_expr = max(nodeTab_withData$log2FC,na.rm=TRUE)
  # data.values = c(min_cancer_expr,0,max_cancer_expr)
  
  nodeTab_withData = nodeTab_withData[!is.na(nodeTab_withData$log2FC),]
  
  # Export table to cytoscape
  # loadTableData(data = cancerGEx, data.key.column = "GeneName", table = "node", table.key.column = "nodeLabels")
  loadTableData(data = nodeTab_withData, data.key.column = "label", table = "node", table.key.column = "label")
  
  # display.brewer.all(length(data.values), colorblindFriendly=TRUE, type="div") # div,qual,seq,all
  # node.colors <- c("#7b3294", "#f7f7f7", "#008837")
  # 
  setNodeColorMapping('log2FC', c(-2,0,2), c("#3182bd","#f5f5f5","#de2d26"), style.name=styleName)
  
  # show gene pvalue on edge weight
  # createColumnFilter(filter.name = "geneEx_sigPVal", column = "P.Value", criterion = 0.05, predicate = "LESS_THAN", caseSensitive = FALSE)
  # setNodeBorderWidthBypass(node.names = getSelectedNodes(), new.widths = 8)
  
  
  cancerFlux <- read_excel("C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/analysis_github/data/data_useCase_2.xlsx", sheet = 4)
  # cancerFlux = read.table("C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/results/useCase2/recon22/fluxData.txt", header = T)

  # nodeTab = getTableColumns(table = "node", columns = c("name",  "cyId"))

  # get all reaction nodes
  edgeTab = getTableColumns(table = "edge", columns = c("interaction type"))
  edgeTab$edgeID = rownames(edgeTab)
  edgeTab[,"edgeName"] = character()

  rxnNodes = getSelectedNodes(selectNodes(nodes = "reaction", by.col = "sbml type"))
  clearSelection()
  # for each reaction node, get associated edges
  # for each edge if interaction is not association_reaction, add the reaction id to them
  for (ii in rxnNodes){
    rxnEdges = selectEdgesAdjacentToSelectedNodes(selectNodes(nodes = ii, by.col = "shared name"))$edges
    for (jj in rxnEdges){
      ind = which(edgeTab$edgeID == jj)
      if (edgeTab$`interaction type`[ind] == "reaction-product" || edgeTab$`interaction type`[ind] == "reaction-reactant"){
        edgeTab$edgeName[ind] = nodeTab$cyId[match(ii, nodeTab$name)]
      }
    }
    clearSelection()
  }
  edgeTab$edgeName = gsub("^R_", "",  edgeTab$edgeName)
  
  # edgeTab[,"fluxData_aer"] = numeric()
  # edgeTab$fluxData_aer = cancerFlux$flux_aer[match(edgeTab$edgeName, cancerFlux$rxnID)]
  # edgeTab[which(is.na(edgeTab$fluxData_aer)), 4] = 0
  
  edgeTab[,"fluxData_anaer"] = numeric()
  edgeTab$fluxData_anaer = cancerFlux$fluxVector[match(edgeTab$edgeName, cancerFlux$rxnID)]
  edgeTab[which(is.na(edgeTab$fluxData_anaer)), 4] = 0
  

  
  loadTableData(data = edgeTab, data.key.column = "edgeID", table = "edge", table.key.column = "SUID")
  setEdgeLineWidthMapping('fluxData_anaer', c(-1000,0,1000), c(10,2,10), style.name=styleName)
  setEdgeColorDefault("#969696", style.name=styleName)
  setEdgeColorMapping('fluxData_anaer', c(-1000,-1,0,1,1000), c("#3182bd","#eff3ff","#969696","#fee5d9","#de2d26"), style.name=styleName)
  
  # setEdgeLineWidthMapping('fluxData_anaer', table.column.values = c(min(edgeTab$fluxData_anaer, na.rm = T), 2, max(edgeTab$fluxData_anaer, na.rm = T)), widths = c(10,0,10), mapping.type = "c", style.name=styleName)
  # setEdgeLineWidthMapping('fluxData_anaer', table.column.values = c(min(edgeTab$fluxData_anaer, na.rm = T), 2, max(edgeTab$fluxData_anaer, na.rm = T)), colors = c("#d7191c","#f7f7f7","#0571b0"), mapping.type = "c", style.name=styleName)
}

# -----------------------------------------------

#& apply style
setVisualStyle(style.name = styleName)

# MANUALLY apply layout

setNodeColorBypass(node.names = getSelectedNodes(selectNodes(nodes = "reaction", by.col = "sbml type")), new.colors = "#FF0000" )
clearSelection()

# setNodeWidthBypass(node.names = getSelectedNodes(selectNodes(nodes = "fbc_geneProduct", by.col = "sbml type")), new.widths = 8)

#remap node labels to new label
updateStyleMapping(style.name = "efmviz_style", mapVisualProperty('node label', 'nodeLabels','p'))


# edge weight map to fluxes

#edge length of start and end rxns?







