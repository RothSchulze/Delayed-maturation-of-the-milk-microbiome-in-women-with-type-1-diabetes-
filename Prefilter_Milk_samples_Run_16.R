library("phyloseq")
library("ggplot2")
library("devtools")
#library("metagMisc")
#library("metagenomeSeq")

parse_phyloseq_taxonomy <- function(taxonomy_df) {
  # Ensure the input is a data frame and has the necessary columns
  if (!is.data.frame(taxonomy_df) || !"Taxon" %in% colnames(taxonomy_df)) {
    stop("Input must be a data frame with a 'Taxon' column.")
  }
  
  # Split the Taxon column into individual ranks
  tax_split <- strsplit(as.character(taxonomy_df$Taxon), split = "; ")
  
  # Parse the taxonomy into a matrix
  tax_matrix <- do.call(rbind, lapply(tax_split, function(x) {
    # Remove prefixes (e.g., "d__", "p__") and fill missing ranks with NA
    ranks <- sub("^[a-z]__", "", x)
    c(ranks, rep(NA, 7 - length(ranks))) # Ensure 7 ranks (Kingdom to Species)
  }))
  
  # Assign column names for taxonomic ranks
  colnames(tax_matrix) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")
  
  # Retain FeatureName as row names
  rownames(tax_matrix) <- rownames(taxonomy_df)
  
  # Return as a matrix for phyloseq compatibility
  as.matrix(tax_matrix)
}

####################################################################
##                                                               ###
##            IMPORT AND SUBSET DATA                             ###
##             DATA WITH TAXA INFO                               ###
####################################################################

setwd("~/Documents/ENDIA Project/Data and analyses/ENDIA Projects analysis/2025 Sequencing processing with qiime2 2024.10/Milk Project 2025/")

### Import data Non Filtered but already with wells merged
Mother_Milk <- import_biom("./table-dada2_QR16G.biom", parseFunction = parse_taxonomy_greengenes)
## Metadata
New_sample_data <- read.table(file="./Run_16_Mapping_file_Run16_Good.csv", fill=TRUE, header=TRUE, sep="\t", row.names=1) #In runs 16 and 22, taxonomy had to be added within phyloseq

### Making a phyloseq object 
Mother_Milk_F <- phyloseq(otu_table(Mother_Milk),  sample_data(New_sample_data))

## Merge the wells based on the SubjectID and trimester (well replicates) ##
Mother_Milk_FM <-merge_samples(Mother_Milk_F, "Merging", fun = sum)
### Recover sample data after merging
New_sample_data2 <- read.table(file="./Run_16_Mapping_file_Run16_Merged_Good.csv", fill=TRUE, header=TRUE, sep="\t", row.names=1)
New_SD_df <- as.data.frame(New_sample_data2)
sample_data(Mother_Milk_FM) <- sample_data(New_SD_df)

# Write table to get a Biome file and add metadata to get into qiime2
#write.table(t(otu_table(Mother_Milk_FM)), file = "./Milk_FTM_nonFilt.txt", quote = FALSE, sep = "\t", row.names = TRUE)

#Parse taxonomy
Tax <- data.frame(read.table(file="./Taxonomy_QR16.tsv", header=TRUE, sep="\t", row.names=1))
as.character(Tax$Taxon)
taxonomy_table <- parse_phyloseq_taxonomy(Tax)
taxonomy_table

Mother_Milk_16 <- phyloseq(otu_table(Mother_Milk_FM),  tax_table(taxonomy_table), sample_data(Mother_Milk_FM))

## To save the object that contains the table with features with the new and complete sample data. Phylogenetic tree will be added when working on the merged phyloseq object.
save(Mother_Milk_16, file="./Run_16_Milk_Features_Phyloseq_Obj_Unfiltered.RData")


