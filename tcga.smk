import pandas as pd


run_data = pd.read_csv("data/run_metadata.tsv", sep="\t", header="infer")
sample_data = pd.read_csv("data/sample.tsv", sep="\t", header="infer")


run_data.set_index("run", inplace=True)
sample_data.set_index("sample", inplace=True)

def get_sample_run_paths(wildcards):
    run_ids = sample_data.loc[wildcards.sample, "runs"].split(",")
    return [run_data.loc[run_id, "file_path"] for run_id in run_ids]

rule filter_samples:
    input:
        run_paths=lambda wildcards: get_sample_run_paths(wildcards)
    output:
        filtered_file="generated_{sample}/filtered_{sample}.tsv"
    shell:
        """
        grep -E 'Primary Tumor|Solid Tissue Normal' {input.run_paths} > {output.filtered_file}
        """

rule extract_expression:
    input:
        filtered_file="generated_{sample}/filtered_{sample}.tsv"
    output:
        extracted_file="generated_{sample}/extracted_{sample}.tsv"
    shell:
        "python scripts/expression.py \"{input.filtered_file}\" \"{output.extracted_file}\""

rule plot_expression:
    input:
        extracted_file="generated_{sample}/extracted_{sample}.tsv"
    output:
        plot_file="generated_{sample}/NKX2-1_boxplot_{sample}.png"
    shell:
        "Rscript scripts/plot_expression.R \"{input.extracted_file}\" \"{output.plot_file}\""

