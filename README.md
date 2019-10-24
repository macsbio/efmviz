# About efmviz
Efmviz is a MATLAB-based integrative workflow for graphically visualizing Elementary Flux Modes (EFMs) in a semi-automated way. This workflow offers a platform for comprehensive EFM analysis, starting with EFM selection followed by visualization and data mapping. 

## Features
- Visualization of EFMs as a graphical network
- Semi-automated and customizable
- Applicable on EFMs generated from any tool/method
- Integrates existing toolboxes [COBRA (COnstraint-Based Reconstruction and Analysis Toolbox)](https://github.com/opencobra/cobratoolbox/) or [RAVEN (Reconstruction, Analysis and Visualization of Metabolic Networks)](https://github.com/SysBioChalmers/RAVEN) with [Cytoscape](https://cytoscape.org/), an open-source network visualization tool
- Enables mapping omics data (such as gene expression, fluxomics) on the network 

## Example applications
Two use cases of the workflow are demonstrated using two genome-scale models, (1) iAF1260 (*E. coli*) and (2) Recon 2.2 (human) which are respectively described in the MATLAB tutorials, tutorial_efmviz_ecoli.mlx and tutorial_efmviz_recon.mlx. Currently, the workflow using COBRA toolbox is available here. All the funtions and input files for the use cases are provided under core/inputs

This workflow is described in the study "An integrative workflow to visualize Elementary Flux Modes in genome-scale metabolic models" Sarathy et al., 2019 (Under preparation)

## Dependencies and Installation
Please follow the detailed instructions on the following pages for installation 
- MATLAB (currently has been tested on R2017b)
- [COBRA](https://github.com/opencobra/cobratoolbox/)
- [Cytoscape](https://cytoscape.org/)
- Cytoscape apps (can be installed from Cytoscape GUI): [cy3sbml](http://apps.cytoscape.org/apps/cy3sbml), [yFiles](https://apps.cytoscape.org/apps/yfileslayoutalgorithms)
- (optional) [R](https://cran.r-project.org/), [RCy3](https://github.com/cytoscape/RCy3)

## Inputs
- the text file containing EFMs 
- the genome-scale metabolic model used for generating EFMs
- optional data to filter EFMs and to map on the visualized network

## Expected Outcome
EFMs selected from the MATLAB tutorial are visualized in Cytoscape as a network of genes, reactions and metabolites with gene expression or reaction fluxes mapped respectively on the gene nodes and reactions in the network.

## Start here
- Download this repository and unzip the folder 
- Open MATLAB with <your-computer-location>/efmviz/core as the working directory
- Run the live scripts (tutorial_efmviz_ecoli.mlx and tutorial_efmviz_recon.mlx) section by section. Each tutorial walks you through all the steps in the workflow necessary to reproduce main results from Sarathy et al., (2019) and can also be adapted to visualize EFMs from your own analysis.

## How to cite
Sarathy C, Kutmon M, Lenz M et al. An integrative workflow to visualize Elementary Flux Modes in genome-scale metabolic models [version 1; not peer reviewed]. F1000Research 2019, 8(ISCB Comm J):1573 (poster) (doi: 10.7490/f1000research.1117453.1) https://f1000research.com/posters/8-1573
