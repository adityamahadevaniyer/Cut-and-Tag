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

INPUT=/projects/baker-lab/CutNTag/bams
OUTPUT=/projects/baker-lab/CutNTag/bams/sortedbams
BAM=H3K4me3_rep2_withDup_bowtie2.mapped.bam
SAMPLE=H3K4me3_rep2_withDup

#Sorting the sam file
samtools sort -o ${OUTPUT}/${SAMPLE}.sorted.bam ${INPUT}/${BAM}

#Indexing the file
samtools index ${OUTPUT}/${SAMPLE}.sorted.bam
