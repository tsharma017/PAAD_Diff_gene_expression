
#load libraries
library(DESeq2)
library(tidyverse)
library(airway)
# step 1 : preparing count data -----


# read in counts data 
healthy_data <- read.csv('Getex_pancreas.csv') # I took it from Getex
# read in sample info
PAAD_data <- read.csv("paad_gene_count_TCGA.csv")
rownames(PAAD_data) <- PAAD_data[,2]
PAAD_data <- PAAD_data[,-2]
PAAD_data <- PAAD_data[,-1]
PAAD_data <-t(PAAD_data)
rownames(healthy_data) <- healthy_data$Name
healthy_data <- healthy_data[,-1:-3]
#### Reducing data dimension
#PAAD_data <- PAAD_data[,1:183]
#healthy_data <- healthy_data[,1:5]

conts_data =read.csv('merged_Padd_Healthy_data.csv')
rownames(conts_data) <- conts_data$X
conts_data <- conts_data[,-1]  # Remove the first column after setting it as row names


#PAAD_data$RowName <- rownames(PAAD_data)
#healthy_data$RowName <- rownames(healthy_data)


# Merge the dataframes based on the RowName column
#merged_df <- merge(PAAD_data, healthy_data, by = 'RowName')

# If you want to remove the RowName column after the merge, you can do so
#merged_df$RowName <- NULL
# step2 Construct a DESeqDataSet object ----
#all((colnames(sample_info)) %in% rownames(conts_data)
rownames(conts_data) <- conts_data$X
count_matrix = conts_data[,-1]
r = colnames(count_matrix)
sample_info = DataFrame(row.names = r)
lis <- c(rep('PAAD',183),rep('Healthy',328))
sample_info$status <- lis
dds <- DESeqDataSetFromMatrix(countData = count_matrix,
                              colData = sample_info,
                              design = ~ status)


    
    