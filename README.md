# Metfrag-Vis
Version: 0.1

## Short Description

Visualize MetFrag results.

## Description

This tool uses MetFrag generated result CSV files and its parameter files to generate a summary PDF file which contains a specified number of top candidates retrieved from each result file. The output PDF includes also compound images and a URL to the MetFragWeb tool with the used parameters for each query. This enables the rerun of the specified MetFrag query.

## Functionality

- Post-processing

## Approaches

- Metabolomics
  
## Instrument Data Types

- LC-MS/MS

## Tool Authors

- Christoph Ruttkies (IPB-Halle)

## Container Contributors

- [Christoph Ruttkies](https://github.com/c-ruttkies) (IPB-Halle)

## Git Repository

- https://github.com/c-ruttkies/MetFragRelaunched


## Installation 

```bash
docker build -t container-metfrag-vis .
```
Alternatively, pull from repo:
```bash
docker pull container-registry.phenomenal-h2020.eu/phnmnl/metfrag-vis
```

## Usage Instructions
On a PhenoMeNal Cloud Research Environment Galaxy environment, go to MS tool category or type metfrag-vis in the search tools text field, and then click on metfrag-vis and select the inputs for MetFrag result and parameter files generated in a previous step, then press run.
