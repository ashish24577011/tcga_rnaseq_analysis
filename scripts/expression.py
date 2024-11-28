import sys
import pandas as pd
import os


filtered_file = sys.argv[1]
output_file = sys.argv[2]


samples = pd.read_csv(filtered_file, sep='\t', header=None, names=[
    'File_ID', 'File_path', 'Data_category', 'Data_type', 'Project_ID', 'Case_ID', 'Sample_ID', 'Sample_Type'
])


gene_data = []


base_path = os.path.expanduser("~/projecto/tcga_analysis/data/")
for _, row in samples.iterrows():
    file_id = row['File_ID']
    file_path = os.path.join(base_path, file_id, row['File_path'])
    
    if os.path.exists(file_path):
        with open(file_path, 'r') as file:
            for line in file:
                columns = line.strip().split('\t')
                if len(columns) > 6 and columns[1] == "NKX2-1":
                    expression_value = float(columns[6]) + 1  # Adding 1 for TPM normalization
                    gene_data.append({
                        'Sample_Type': row['Sample_Type'],
                        'Expression_TPM': expression_value
                    })
                    break


gene_df = pd.DataFrame(gene_data)
gene_df.to_csv(output_file, index=False)

