# This is code to replicate (part of) the analyses and figures from the paper titled "An integrative workflow to visualize Elementary Flux Modes in genome-scale metabolic models"
# Publication details here (will be added after published)

# This script contains two functions (one each for E. coli and Recon2.2 networks) and some basic network operations.
# Basic network operations include deleting networks which are of no interest after SBML file is loaded and renaming the desired network
# prior to all network manipulations.

# Author: Chaitra Sarathy, last updated 28 Jan 2019

# Open Cytoscape now!

# Install packages if not already present and import
if("RCy3" %in% rownames(installed.packages()) == FALSE) {install.packages("RCy3")}
if("readxl" %in% rownames(installed.packages()) == FALSE) {install.packages("readxl")}
if("RColorBrewer" %in% rownames(installed.packages()) == FALSE) {install.packages("RColorBrewer")}
if("rstudioapi" %in% rownames(installed.packages()) == FALSE) {install.packages("rstudioapi")}

library(RCy3)
# library(tidyverse)
library(readxl)
library(RColorBrewer)
library(rstudioapi)

# check connection to Cytoscape
cytoscapePing() #must return "You are connected to Cytoscape!"


# MANUAL STEP 1. Set the name of the network, usually same as the SBML filename
# for one SBML file at a time, open in Cytoscape, set the name below before running rest of the code
nwName = 'ecoli_glcUp_acRel_filteredEFM3' 


scriptPath = rstudioapi::getActiveDocumentContext()$path #if not sourcing this script, set this path manually
dirPath = dirname(scriptPath)

usecase1_fileName = "C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/githubVersion/data/data_useCase_1.xlsx"
usecase2_fileName = "C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/githubVersion/data/data_useCase_2.xlsx"
styleName = "efmviz_style"

importVisualStyles(filename = paste(dirPath, "/", styleName,".xml", sep=""))

parentFolder = sub("efmviz.*","",dirPath)
dataFolder = paste(parentFolder, "/efmviz/data/", sep="")
usecase1_fileName = paste(dataFolder,"data_useCase_1.xlsx",sep="")
usecase2_fileName = paste(dataFolder,"data_useCase_2.xlsx",sep="")
 

# retain "Base" network and rename it
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
# function for E. coli networks
loadEcoliData = function(){
  nodeTab = getTableColumns(table = "node", columns = c("label", "name","sbml type", "cyId"))

  # #import external data - ecoli gene names
  # ecoli_kegg = read_excel(usecase1_fileName, sheet = 2)
  # 
  # 
  # # Add gene label in dataframe
  # nodeTab[,"nodeLabels"] = character()
  # nodeTab$nodeLabels = nodeTab$label
  # nodeTab$nodeLabels[which(nodeTab$label %in% ecoli_kegg$geneID)] = ecoli_kegg$geneAbbr[which(ecoli_kegg$geneID %in% nodeTab$label)]
  # 
  # # Remove rxn label
  # nodeTab$nodeLabels[which(nodeTab$`sbml type` == "reaction")] = ""
  # 
  # loadTableData(data = nodeTab, data.key.column = "label", table = "node", table.key.column = "label")
  # 
  # # Add data
  # data_ecoli = read_excel(usecase1_fileName, sheet = 1)
  # 
  # #merge both tables
  # nodeTab_withData = merge(x=nodeTab, y=data_ecoli, by.x = "label", by.y="KEGGID", all.x=T)
  # nodeTab_withData = nodeTab_withData[!is.na(nodeTab_withData$log2FC),]
  # 
  # 
  # # Export table to cytoscape
  # loadTableData(data = nodeTab_withData, data.key.column = "label", table = "node", table.key.column = "label")
  # setNodeColorMapping('log2FC', c(-2,0,2), c("#3182bd","#f5f5f5","#de2d26"), style.name=styleName)

  # apply style
  setVisualStyle(style.name = styleName)

  # #remap node labels to new label
  # updateStyleMapping(style.name = styleName, mapVisualProperty('node label', 'nodeLabels','p'))
  
  # color reaction nodes as green
  clearSelection()
  setNodeColorBypass(node.names = getSelectedNodes(selectNodes(nodes = "reaction", by.col = "sbml type")), new.colors = "#00FF00" )
  clearSelection()
  
  # ----
  cancerFlux <- read_excel(usecase1_fileName, sheet = 3)
  
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
  edgeTab$fluxData_anaer <- signif(edgeTab$fluxData_anaer,2)


  loadTableData(data = edgeTab, data.key.column = "edgeID", table = "edge", table.key.column = "SUID")
  setEdgeLineWidthMapping('fluxData_anaer', c(0,25), c(2,10), style.name=styleName)
  setEdgeColorDefault("#969696", style.name=styleName)
  #setEdgeColorMapping('fluxData_anaer', c(-1000,-1,0,1,1000), c("#3182bd","#eff3ff","#969696","#fee5d9","#de2d26"), style.name=styleName)


}

loadHumanData = function(){
  # apply style
  setVisualStyle(style.name = styleName)


  nodeTab = getTableColumns(table = "node", columns = c("label", "sbml type", "name", "cyId"))
  # nodeTab = data.frame(nodeTab, stringsAsFactors = F)


  #import gene symbol information
  human_geneNames = read_excel(usecase2_fileName, sheet = 2)


  # Add gene label in df
  nodeTab[,"nodeLabels"] = character()
  nodeTab$nodeLabels = nodeTab$label
  nodeTab$nodeLabels[which(nodeTab$label %in% human_geneNames$HGNCID)] = human_geneNames$GeneSymbol[which(human_geneNames$HGNCID %in% nodeTab$label)]

  # Remove rxn label
  nodeTab$nodeLabels[which(nodeTab$`sbml type` == "reaction")] = ""

  loadTableData(data = nodeTab, data.key.column = "label", table = "node", table.key.column = "label")

  #remap node labels to new label
  updateStyleMapping(style.name = styleName, mapVisualProperty('node label', 'nodeLabels','p'))


  # write.csv(nodeTab, file="test.csv", sep=",", col.names = T)

  # Add data
  # LOAD IT MANUALLY
  cancerGEx = read_excel(usecase2_fileName, sheet = 1)
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


  # cancerFlux <- read_excel(usecase2_fileName, sheet = 4)
  # 
  # # nodeTab = getTableColumns(table = "node", columns = c("name",  "cyId"))
  # 
  # # get all reaction nodes
  # edgeTab = getTableColumns(table = "edge", columns = c("interaction type"))
  # edgeTab$edgeID = rownames(edgeTab)
  # edgeTab[,"edgeName"] = character()
  # 
  # rxnNodes = getSelectedNodes(selectNodes(nodes = "reaction", by.col = "sbml type"))
  # clearSelection()
  # # for each reaction node, get associated edges
  # # for each edge if interaction is not association_reaction, add the reaction id to them
  # for (ii in rxnNodes){
  #   rxnEdges = selectEdgesAdjacentToSelectedNodes(selectNodes(nodes = ii, by.col = "shared name"))$edges
  #   for (jj in rxnEdges){
  #     ind = which(edgeTab$edgeID == jj)
  #     if (edgeTab$`interaction type`[ind] == "reaction-product" || edgeTab$`interaction type`[ind] == "reaction-reactant"){
  #       edgeTab$edgeName[ind] = nodeTab$cyId[match(ii, nodeTab$name)]
  #     }
  #   }
  #   clearSelection()
  # }
  # edgeTab$edgeName = gsub("^R_", "",  edgeTab$edgeName)
  # 
  # # edgeTab[,"fluxData_aer"] = numeric()
  # # edgeTab$fluxData_aer = cancerFlux$flux_aer[match(edgeTab$edgeName, cancerFlux$rxnID)]
  # # edgeTab[which(is.na(edgeTab$fluxData_aer)), 4] = 0
  # 
  # edgeTab[,"fluxData_anaer"] = numeric()
  # edgeTab$fluxData_anaer = cancerFlux$fluxVector[match(edgeTab$edgeName, cancerFlux$rxnID)]
  # edgeTab[which(is.na(edgeTab$fluxData_anaer)), 4] = 0
  # 
  # 
  # 
  # loadTableData(data = edgeTab, data.key.column = "edgeID", table = "edge", table.key.column = "SUID")
  # setEdgeLineWidthMapping('fluxData_anaer', c(-1000,0,1000), c(10,2,10), style.name=styleName)
  # setEdgeColorDefault("#969696", style.name=styleName)
  # setEdgeColorMapping('fluxData_anaer', c(-1000,-1,0,1,1000), c("#3182bd","#eff3ff","#969696","#fee5d9","#de2d26"), style.name=styleName)

  # setEdgeLineWidthMapping('fluxData_anaer', table.column.values = c(min(edgeTab$fluxData_anaer, na.rm = T), 2, max(edgeTab$fluxData_anaer, na.rm = T)), widths = c(10,0,10), mapping.type = "c", style.name=styleName)
  # setEdgeLineWidthMapping('fluxData_anaer', table.column.values = c(min(edgeTab$fluxData_anaer, na.rm = T), 2, max(edgeTab$fluxData_anaer, na.rm = T)), colors = c("#d7191c","#f7f7f7","#0571b0"), mapping.type = "c", style.name=styleName)



  # color reaction nodes as red
  setNodeColorBypass(node.names = getSelectedNodes(selectNodes(nodes = "reaction", by.col = "sbml type")), new.colors = "#FF0000" )
  clearSelection()

  #remap node labels to new label
  updateStyleMapping(style.name = styleName, mapVisualProperty('node label', 'nodeLabels','p'))
}

# -----------------------------------------------

# Finally, MANUAL STEP 2. apply yFiles Orthogonal layout IN Cytoscape