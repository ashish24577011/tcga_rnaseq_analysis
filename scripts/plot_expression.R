library(ggplot2)

# Command-line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]

# Load extracted data
gene_data <- read.csv(input_file)

# Plot expression values
ggplot(gene_data, aes(x = Sample_Type, y = log2(Expression_TPM))) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(
    title = "NKX2-1 Expression Boxplot (Log2(TPM + 1))",
    x = "Sample Type",
    y = "Log2(Expression TPM)"
  ) +
  theme_minimal(base_size = 15) +
  theme(
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white"),
    panel.grid.major = element_line(color = "gray"),
    panel.grid.minor = element_blank()
  )

# Save plot to file
ggsave(output_file)

