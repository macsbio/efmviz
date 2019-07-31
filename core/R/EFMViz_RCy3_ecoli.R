usecase1_fileName = "C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/githubVersion/data/data_useCase_1.xlsx"
usecase2_fileName = "C:/Users/chaitra.sarathy/Dropbox/Chaitra/Analysis/EFM/visualizationOfEFMs/githubVersion/data/data_useCase_2.xlsx"
styleName = "efmviz_style"
sheetNum = 4

nodeTab = getTableColumns(table = "node", columns = c("label", "name","sbml type", "cyId"))

# Get node table of the network and create new label without reaction IDs
nodeTab[,"nodeLabels"] = character()
nodeTab$nodeLabels = nodeTab$label
# Remove reaction label
nodeTab$nodeLabels[which(nodeTab$`sbml type` == "reaction")] = ""

# Load the updated node table into Cytoscape 
loadTableData(data = nodeTab, data.key.column = "label", table = "node", table.key.column = "label")

# Apply style
setVisualStyle(style.name = styleName)

# Remap node labels to new label
updateStyleMapping(style.name = styleName, mapVisualProperty('node label', 'nodeLabels','p'))

# Color reaction nodes as green
clearSelection()
setNodeColorBypass(node.names = getSelectedNodes(selectNodes(nodes = "reaction", by.col = "sbml type")), new.colors = "#00FF00" )

# Hide genes and GPR relation nodees
clearSelection()
hideNodes(node.names = getSelectedNodes(selectNodes(nodes = "fbc_geneProduct", by.col = "sbml type")))
clearSelection()
hideNodes(node.names = getSelectedNodes(selectNodes(nodes = "fbc_and", by.col = "sbml type")))
clearSelection()
hideNodes(node.names = getSelectedNodes(selectNodes(nodes = "fbc_or", by.col = "sbml type")))
clearSelection()

# Map reaction flux
# Load reaction flux
reactionFlux <- read_excel(usecase1_fileName, sheet = sheetNum)

# Get the edge table
edgeTab = getTableColumns(table = "edge", columns = c("interaction type"))
edgeTab$edgeID = rownames(edgeTab)
edgeTab[,"edgeName"] = character()

# Get all reaction nodes
rxnNodes = getSelectedNodes(selectNodes(nodes = "reaction", by.col = "sbml type"))
clearSelection()

# for each reaction node, get associated edges
# for each edge if interaction type is is reaction-product or reaction-reaction, add the reaction id to them
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

# Convert flux data in edge table to numeric
edgeTab[,"fluxData"] = numeric()
edgeTab$fluxData = reactionFlux$fluxVector[match(edgeTab$edgeName, reactionFlux$rxnID)]
edgeTab[which(is.na(edgeTab$fluxData)), 4] = 0
edgeTab$fluxData <- signif(edgeTab$fluxData,2)

# Load the modified edge table back to Cytoscape
loadTableData(data = edgeTab, data.key.column = "edgeID", table = "edge", table.key.column = "SUID")

# Map the flux data on the edges, set edge color and edge weight
setEdgeLineWidthMapping('fluxData', c(0,30), c(2,15), style.name=styleName)
setEdgeColorDefault("#969696", style.name=styleName)
setEdgeColorMapping('fluxData', c(0,1,30), c("#999999","#FFCCCC","#FF0000"), style.name=styleName)
