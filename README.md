# efmviz
A MATLAB and R-based integrative workflow for graphically visualizing EFMs in a semi-automated way. This workflow offers a platform for comprehensive EFM analysis, starting with EFM selection followed by visualization and data mapping. 

This flexible workflow seamlessly integrates the existing toolboxes [COBRA (COnstraint-Based Reconstruction and Analysis Toolbox)](https://github.com/opencobra/cobratoolbox/) or [RAVEN (Reconstruction, Analysis and Visualization of Metabolic Networks)](https://github.com/SysBioChalmers/RAVEN) with [Cytoscape](https://cytoscape.org/), an open-source network visualization tool. Network manipulations in Cytoscape is carried out using the R environment with the  [RCy3](https://github.com/cytoscape/RCy3) library. [TreeEFM](https://academic.oup.com/bioinformatics/article/31/6/897/214785) has been used for EFM generation. Two use cases of the workflow are demonstrated using two genome-scale models, (1) iAF1260 (*E. coli*) and (2) Recon 2.2 (human). Currently, the workflow using COBRA toolbox is available here. 

This workflow is described in the study "An integrative workflow to visualize Elementary Flux Modes in genome-scale metabolic models" (Under preparation)

## Dependencies and Installation
Please follow the detailed instructions on the following pages for installation 
- [COBRA](https://github.com/opencobra/cobratoolbox/)
- [TreeEFM](https://academic.oup.com/bioinformatics/article/31/6/897/214785)
- [Cytoscape](https://cytoscape.org/), [cy3sbml](http://apps.cytoscape.org/apps/cy3sbml)
- [R](https://cran.r-project.org/), [RCy3](https://github.com/cytoscape/RCy3)


## How to run
Scripts analysis_ecoli.mlx and analysis_recon.mlx contain detailed instructions on the workflow

## How to cite
Will be updated shortly
