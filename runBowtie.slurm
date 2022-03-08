#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH -t 24:00:00
#SBATCH --export=ALL
#SBATCH --mail-user=aditya.mahadevaniyer@jax.org
#SBATCH --mail-type=end
#SBATCH --mem-per-cpu=30G
module load singularity

cd $SLURM_SUBMIT_DIR

## Set directories
FASTQDIR=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/fastq/trimmed
BAMDIR=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/bams

## Define variables
NUM_THREADS=16
P2REF=/projects/baker-lab/clbaker/genomes/mm10/bowtie2/mm10
R1=H3K36me3-CnT-germ-50K_GT21-09222_CTCTCTAC-AAGGAGTA_R1.fastq.gz
R2=H3K36me3-CnT-germ-50K_GT21-09222_CTCTCTAC-AAGGAGTA_R2.fastq.gz
BAM=H3K36me3-CnT-germ-50K_GT21-09222-no-unal-trimmed

#Map with Bowtie2
singularity exec /projects/baker-lab/containers/bowtie2/2.4.2/bowtie2_2.4.2.sif bowtie2 --end-to-end --very-sensitive --no-unal --no-mixed --no-discordant \
   --phred33 -I 10 -X 700 -p ${NUM_THREADS} -x ${P2REF} \
   -1 $FASTQDIR/$R1 -2 $FASTQDIR/$R2 \
   -S $BAMDIR/${BAM}_bowtie2.sam &> $BAMDIR/${BAM}_bowtie2.txt

