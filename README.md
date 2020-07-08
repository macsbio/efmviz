<img src="EFMviz_logo.png" width="180" align="right" />

# EFMviz [![DOI](https://zenodo.org/badge/218839057.svg)](https://zenodo.org/badge/latestdoi/218839057) 
EFMviz is a MATLAB-based integrative workflow for graphically visualizing Elementary Flux Modes (EFMs). This workflow offers a platform for comprehensive EFM analysis, starting with EFM selection followed by visualization and data mapping. 

## Features
- Visualization of EFMs as a graphical network
- Customizable workflow
- Applicable on EFMs generated from any tool/method
- Integrates existing toolboxes [COBRA (COnstraint-Based Reconstruction and Analysis Toolbox)](https://github.com/opencobra/cobratoolbox/) or [RAVEN (Reconstruction, Analysis and Visualization of Metabolic Networks)](https://github.com/SysBioChalmers/RAVEN) with [Cytoscape](https://cytoscape.org/), an open-source network visualization tool
- Enables mapping omics data (such as gene expression, fluxomics) on the network 

## Example applications
Two use cases of the workflow are demonstrated using two genome-scale models, (1) iAF1260 (*E. coli*) and (2) Recon 2.2 (human) which are respectively described in the MATLAB tutorials, tutorial_efmviz_ecoli.mlx and tutorial_efmviz_recon.mlx. Currently, the workflow using COBRA toolbox is available here. All the funtions and input files for the use cases are provided under core/inputs

This workflow is described in the study "An integrative workflow to visualize Elementary Flux Modes in genome-scale metabolic models" Sarathy et al., 2019 (Under preparation) 

## Dependencies and Installation
Please follow the detailed instructions on the following pages for installation 
- MATLAB (currently has been tested on R2017b and 2018b)
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
- Run the live scripts (tutorial_efmviz_ecoli.mlx and tutorial_efmviz_recon.mlx) section by section. Each tutorial walks you through all the steps in the workflow necessary to reproduce the main results from Sarathy et al., (2020, see below for the paper) and can also be adapted to visualize EFMs from your own analysis.

## How to cite
- EFMviz paper: Sarathy, C.; Kutmon, M.; Lenz, M.; Adriaens, M.E.; Evelo, C.T.; Arts, I.C. EFMviz: A COBRA Toolbox extension to visualize Elementary Flux Modes in Genome-Scale Metabolic Models. Metabolites 2020, 10, 66. https://doi.org/10.3390/metabo10020066
- EFMviz software: https://doi.org/10.5281/zenodo.3524474
