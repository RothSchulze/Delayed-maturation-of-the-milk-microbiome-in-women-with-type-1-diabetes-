# Delayed-maturation-of-the-milk-microbiome-in-women-with-type-1-diabetes-
Maternal T1D is associated with delayed early maturation of the breastmilk microbiome. This could potentially contribute to sub-optimal development of the infant’s gut and immune system. 

This repository contains a file describing the specific commands used to process the microbiome raw data from manuscript " Delayed maturation of the milk microbiome in women with type 1 diabetes" using Qiime2 version 2024.10 and the mapping files used for this. The raw sequences can be found in NCBI SRA https://www.ncbi.nlm.nih.gov/sra (project number PRJNA135652). It also contains files with the R code used for analysing the samples along with R objects and metadata used as input.
QIIME2 files

## 2025 QIIME2 2024 Breast Milk microbiome project: Document containing the description and commands of the Qiime2 pipeline used for processing the raw sequences until obtaining taxonomic per sample table. Also, with these, representative sequences and phylogenetic trees were obtain. In this document it is also explained how the qiime2 files were transformed into biom files for input to phyloseq in R.

The following metadata files were used in that pipeline:
•	Mapping_file_Seq_11-Run.csv
•	Mapping_file_Seq_16-Run.csv
•	Mapping_file_Seq_22-Run.csv

## R code files and objects

The documents containing the R code for the different runs’ formatting (3 files) and diversity with statistical analyses are contained are as follows..

### 1) Prefilter_Milk_samples_Run_11.R:

#### Contains the code used to format the results from Qimme2 for the breast milk microbiome run 11 in which the input files are:

- table-dada2_QR11G.biom: This contains the bacterial features without taxonomic classification for run 11
- Run_11_Mapping_file_Run11_Good.csv: This contains the initial sequence metadata for run 11
- Run_11_Mapping_file_Run11_Merged_Good.csv: Contains the metadata used to merged samples that were sequenced in duplicate for run 11.
- Taxonomy_QR11.tsv: Contains taxonomy to parse for feature table in run 11

#### Output file for prefilter of run 11 sequences: Contains the ASV per sample count table with taxonomy and metadata.

- Run_11_Milk_Features_Phyloseq_Obj_Unfiltered.RData

### 2) Prefilter_Milk_samples_Run_16.R:

#### Contains the code used to format the results from Qimme2 for the breast milk microbiome run 16 in which the input files are:

- table-dada2_QR16G.biom: This contains the bacterial features without taxonomic classification for run 16
- Run_16_Mapping_file_Run16_Good.csv: This contains the initial sequence metadata for run 16
- Run_16_Mapping_file_Run16_Merged_Good.csv: Contains the metadata used to merged samples that were sequenced in duplicate for run 16.
- Taxonomy_QR16.tsv: Contains taxonomy to parse for feature table in run 16

#### Output file for prefilter of run 16 sequences: Contains the ASV per sample count table with taxonomy and metadata.

- Run_16_Milk_Features_Phyloseq_Obj_Unfiltered.RData

### 3) Prefilter_Milk_samples_Run_22.R:

#### Contains the code used to format the results from Qimme2 for the breast milk microbiome run 22 in which the input files are:

- table-dada2_QR22G.biom: This contains the bacterial features without taxonomic classification for run 22
- Run_22_Mapping_file_Run22_Good.csv: This contains the initial sequence metadata for run 22
- Run_22_Mapping_file_Run22_Merged_Good.csv: Contains the metadata used to merged samples that were sequenced in duplicate for run 22.
- Taxonomy_QR22.tsv: Contains taxonomy to parse for feature table in run 22

#### Output file for prefilter of run 22 sequences: Contains the ASV per sample count table with taxonomy and metadata.

- Run_22_Milk_Features_Phyloseq_Obj_Unfiltered.RData

### 4) Milk_microbiome_statistical_analysis_wNew_Metadata upload.Rmd

#### Contains the code used to analyse the alpha and beta diversity and differential abundance of the breast milk microbiome in the context of T1D status and collection timepoint. Input data:

- Run_11_Milk_Features_Phyloseq_Obj_Unfiltered.RData (which is the output of R code 1 above)
- Run_16_Milk_Features_Phyloseq_Obj_Unfiltered.RData (which is the output of R code 2 above)
- Run_22_Milk_Features_Phyloseq_Obj_Unfiltered.RData (which is the output of R code 3 above)
- rooted-tree_QMilk11_16_22.nwk: This contains the phylogenetic tree generated in qimme2 when features/ASVs from runs 11, 16 and 22 were merged in a single file.
- rep-seqs-dada2_QMilk11_16_22.fasta: This contains the Fasta file with representative sequences/ASVs from runs 11, 16 and 22 were merged in a single file
- Metadata_Milk_Project_Updated_Formatted_Dic_2024_2.csv: Metadata for al samples in run 11, 16 and 22.

#### Output 1 code 4: 

- All_Runs_Milk_OTU_Phyloseq_Obj_Filter1.RData: This contains the phyloseq object containing all samples in runs 11, 16 and 22 together with taxonomy and metadata agglomerated to a Copernic distance of h=0.03 (“species level”) and for which all OTUs below relative abundance of 0.01% were removed. This file was used to continue the statistical analysis. From here, everything else in within the Markdown R code.

