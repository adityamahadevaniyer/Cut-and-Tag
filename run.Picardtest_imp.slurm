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

module load samtools
module load bedtools
module load picard

NUM_THREADS=16
inputPath=/projects/baker-lab/CutNTag/bams
outputPath=$inputPath
filename=ATAC178_H3K4me3_CutNTag_rep2

#Sort by coordinates
picard SortSam I=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_bowtie2.sam \
O=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_bowtie2.sorted.sam SORT_ORDER=coordinate 

#Mark the duplicates
picard MarkDuplicates I=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_bowtie2.sorted.sam \
O=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_bowtie2.sorted.dupMarked.sam \
METRICS_FILE=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_bowtie2.picard.dupMark.txt

#Remove the duplicates
picard MarkDuplicates I=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_bowtie2.sorted.sam \
O=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_bowtie2.sorted.rmDup.sam \
REMOVE_DUPLICATES=true \
METRICS_FILE=/projects/baker-lab/CutNTag/bams/ATAC178_GT20-17911_CGTACTAG-AGAGGATA_S2_picard.rmDup.txt

chmod 775 ${inputPath}/*
