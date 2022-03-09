#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH -t 4:00:00
#SBATCH --export=ALL
#SBATCH --mail-user=aditya.mahadevaniyer@jax.org
#SBATCH --mail-type=end
#SBATCH --mem-per-cpu=30G

module load singularity

cd $SLURM_SUBMIT_DIR

module load bedtools/2.9.2

### Define variables
BAMDIR=/projects/baker-lab/CutNTag/bams/sortedbams/
BEDDIR=/projects/baker-lab/CutNTag/scripts/
BAM1=H3K4me3_cnt_rmDup_combined.merged.sorted.bam
BAM2=/projects/baker-lab/mahada/CAST_KI_mm10/bams/H3K4ME3_CAST-KI_chip_merged.merged.sorted.bam
BED=H3K4me3_CnT_combined_pvalue_1e-1_macs_peaks.sorted.bed

# count reads
bedtools multicov -bams ${BAMDIR}${BAM1} ${BAM2} -bed ${BEDDIR}${BED} > CUTnTag_merged_k4me3chip_mm10_peakome.txt

# add header
#sed -i '1ichr\tstart\tend\tPeakScore\tcntrep1\tcntrep2' CUTnTag_rep1rep2_peakome.txt

echo 'Done with calculating read coverage at the bed file regions'
