#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH -t 4:00:00
#SBATCH --export=ALL
#SBATCH --mail-user=aditya.mahadevaniyer@jax.org
#SBATCH --mail-type=end
#SBATCH --mem-per-cpu=30G

module load singularity

Datasets important for my work:
H3K4ME3_chip=/projects/baker-lab/clbaker/CAST_KI/mm10/bedgraph/KI_merge_ChIP_raw.bw
TSS=/projects/baker-lab/clbaker/genomes/mm10/mm10_gencode_tss_unique.bed
CASTHotspots=/projects/baker-lab/clbaker/CoverageView/E_binding_sites_R.mm10.bed
B6Hotspots=/projects/baker-lab/clbaker/b6/mm10/H3K4me3_B6_merge_e-5_noCtoP_uncommons.mm10.bed

ATAC13=/projects/baker-lab/clbaker/ATAC/ATAC13/trimmomatic/bowtie/ATAC13-TAAGGCGA_S1_LaneALL_mm10_sorted_rmdup_shifted_raw.bw
ATAC14=/projects/baker-lab/clbaker/ATAC/ATAC14/trimmomatic/bowtie/2015-DS033-LIB-33002-ATAC14-CGTACTAG_S2_LaneALL_mm10_sorted_rmdup_shifted_raw.bw

#cd $SLURM_SUBMIT_DIR
##########Try all these scripts interactively on an interactive node;; Copy and paste the below script seperately#################################
####The script below takes a bit of time (~15 mins), leave it and get a coffee break :)
module load singularity
singularity shell /projects/baker-lab/containers/deeptools/3.3.2.sif/deeptools_3.3.2.sif

IPATH=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/bams/sortedbams/
OPATH=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/bams/sortedbams/deeptools/
MATRIX=H3K36_K27me3_K27ac_k4me3rep1_k4me3_rep2_at_TSS

computeMatrix reference-point -S ${IPATH}H3K36me3-CnT-germ-50K_GT21-09222_raw.bw \
				 ${IPATH}H3K27ac-CnT-germ-50K_GT21-09223_raw.bw \
				 ${IPATH}H3K9ac-CnT-germ-50K_GT21-09224_raw.bw \
				 ${IPATH}H3K4me3-CnT-HSPCs-50K-rep1_GT21-09225_raw.bw \
				 ${IPATH}H3K4me3-CnT-HSPCs-50K-rep2_GT21-09226_raw.bw \
				-R /projects/baker-lab/clbaker/genomes/mm10/mm10_gencode_tss_unique.bed \
			      --skipZeros -o ${OPATH}${MATRIX}.mat.gz \
			      -p 8 -a 1500 -b 1500

plotHeatmap -m ${OPATH}${MATRIX}.mat.gz -out ${OPATH}${MATRIX}_heatmap.png --sortUsing sum \
				--startLabel "Peak Start" --endLabel "Peak End" --xAxisLabel "" \
				--regionsLabel "Peaks" \
				--refPointLabel "TSS"

	
