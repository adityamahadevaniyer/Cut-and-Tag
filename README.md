# Cut-and-Tag Data analysis

I had performed bulk Cut-and-Tag experiments with H3K4me3 histone mark antibodies in mouse germ cells and FACS-sorted HSPCs. These are the scripts for general Cut&Tag data analysis. We already have ChIP-seq datasets generated in these cell types for comparisons. We fine-tuned peak-calling parameters to see which parameter led to better overlap of Cut-and-Tag data with the published ChIP-seq datasets. 

Some of the downstream analysis included analyzing the profile of H3K4me3 at TSS, recombination hotspots and other regions of interest using Deeptools package. All the analyses were performed on Singularity HPC cluster of JAX.  
