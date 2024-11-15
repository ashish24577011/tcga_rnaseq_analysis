This project analyzes gene expression data for a cancer type and visualizes it with a boxplot for the NKX2-1 gene. To get started, download the required files from here and place them in the data/ directory. Unzip the tcga_data.tar.gz file using tar -zxvf tcga_data.tar.gz.

The data/ directory also contains two files: sample.tsv and run_metadata.tsv, which are created from gdc_sample_sheet.tsv. The scripts/ directory contains Python and R scripts for TPM extraction and plotting.

The Snakemake file tcga.smk defines the workflow. The first rule filters data for a specific cancer type, the second extracts TPM values for the gene (default: NKX2-1), and the third generates the boxplot. To run the pipeline, snakemake --snakefile tcga.smk generated_demo/NKX2-1_boxplot_demo.png -j1
