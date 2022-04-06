# Look at read pile-ups at TSS's for H3K4me3, two H3K4me3 CutNTag replicates and Igg rep of germ cells

#Please run this command on your terminal, and then launch R

#qsub -I -l procs=10,mem=150gb,walltime=8:00:00 -q interactive

#Please do not that the first -I is capital letter “I for Income” and the second -l is small letter “l for letter”. Then run 

####################
# R
#module load R/3.5.1
# Start R and run on commandline
### Making a coverage matrix using R
library(CoverageView)
library(data.table)

# Bed files to set coordinates for the plots (TSS or hotspots)
cfile = "/projects/baker-lab/clbaker/CoverageView/E_binding_sites_R.mm10.bed"
setwd("/projects/baker-lab/CutNTag/bams/sortedbams/")
#list.files(pattern="bam.10")
# Start with H3K4me3
#k4me3.bam <- CoverageBamFile("/projects/baker-lab/clbaker/CAST_KI/mm10/bams/KI_merge_ChIP.mm10.sorted.bam")
#k4me3.df <- cov.matrix(k4me3.bam, coordfile=cfile,extend=1000, bin_width=10, normalization = "rpm")
# Cut-N-Tag of H3K4me3 rep1
#cnt.rep1.bam <- CoverageBamFile("/projects/baker-lab/CutNTag/bams/sortedbams/H3K4me3_rep1_rmDup.sorted.bam")
#cnt.bam.rep1.df <- cov.matrix(cnt.rep1.bam, coordfile=cfile,extend=1000, bin_width=10, normalization = "rpm")
# Cut-N-Tag of H3K4me3 rep2
cnt.rep2.bam <- CoverageBamFile("/projects/baker-lab/CutNTag/bams/sortedbams/H3K4me3_rep2_rmDup.sorted.bam")
cnt.bam.rep2.df <- cov.matrix(cnt.rep2.bam, coordfile=cfile,extend=1000, bin_width=10, normalization = "rpm")
# Cut-N-Tag of IgG rep
#cnt.igg.rep.bam <- CoverageBamFile("/projects/baker-lab/CutNTag/bams/sortedbams/IgG_rep_rmDup.sorted.bam")
#cnt.bam.igg.df <- cov.matrix(cnt.igg.rep.bam, coordfile=cfile,extend=1000, bin_width=10, normalization = "rpm")
# ATAC13 data
#atac13.bam <- CoverageBamFile("/projects/baker-lab/clbaker/ATAC/ATAC13/trimmomatic/bowtie/2015-DS033-LIB-33001-ATAC13-TAAGGCGA_S1_LaneALL_mm10_sorted_rmdup_shifted_sorted.bam")
#atac13.df <- cov.matrix(atac13.bam, coordfile=cfile,extend=1000, bin_width=10, normalization = "rpm")
#ATAC14 data
atac14.bam <- CoverageBamFile("/projects/baker-lab/clbaker/ATAC/ATAC14/trimmomatic/bowtie/2015-DS033-LIB-33002-ATAC14-CGTACTAG_S2_LaneALL_mm10_sorted_rmdup_shifted_sorted.bam")
atac14.df <- cov.matrix(atac14.bam, coordfile=cfile,extend=1000, bin_width=10, normalization = "rpm")

# Combine together
df2 <- rbind(cnt.bam.rep2.df,atac14.df)
df2 <- data.frame(t(df2))

# Calculate H3K4me3 signal and sort by maximum value
df2$sum <- rowSums(df2[,1:200])
df2 <- df2[order(-df2$sum),]
CutNTag <- df2[,1:200]
ATAC <- df2[,201:400]
#cnt.rep2 <- df2[,401:600]
#cnt.igg <- df2[,601:800]
#atac13.germ <- df2[,801:1000]
#atac14.germ <- df2[,1001:1200]

# Print table for treeview
#setwd("./coverageview")
#fwrite(me3, "CovView_k4sorted.txt", col.names = F, row.names = F)
#fwrite(cnt.rep1, "cnt_k4me3_rep1_CovView_k4sorted.txt", col.names = F, row.names = F)
fwrite(CutNTag, "cnt_k4me3_rep_CovView_k4sorted.txt", col.names = F, row.names = F)
#fwrite(cnt.igg, "cnt_igg_CovView_k4sorted.txt", col.names = F, row.names = F)
fwrite(ATAC, "atac_germ_CovView_k4sorted.txt", col.names = F, row.names = F)
#fwrite(atac14.germ, "atac14_germ_CovView_k4sorted.txt", col.names = F, row.names = F)
