# Ahr TEAD motif analysis

  

Analysis repository regarding review comments for:

"Cell-intrinsic Aryl Hydrocarbon Receptor signalling is required for the resolution of injury-induced colonic stem cells"

## Prerequisites

- Linux/Unix platform (macOS supported)
- Conda installed

## Installation

Clone this repository, navigate to the folder using the command line and install the conda environment using 
```
conda env create -f environment.yml
```

## Generating base data
To generate the bed files which are consumed by the downstream analysis, run `generate_beds.sh`

## Performing downstream analysis
To view the downstream analysis just click on `analysis.ipynb` in the browser on github.

To re-run the analysis, start jupyter by typing `jupyter lab` from the root repository folder, then open either `analysis` or `ucsc_export` and re-run the steps.

### UCSC Export
This script will format and normalise the data for display in UCSC browser. All bed files can be directory uploaded from `_ucsc_export` to the browser as custom tracks. 

### Analysis
This script contains all the steps to generate the figures and stats used in answering the relevant reviewer questions. 