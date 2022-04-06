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

module load samtools/1.5

### Define variables
NUM_THREADS=8
OPATH=/projects/baker-lab/CutNTag/bams/sortedbams/
IPATH=/projects/baker-lab/CutNTag/bams/sortedbams/
INPUT1=
INPUT2=/projects/baker-lab/clbaker/CAST_KI/mm10/bams/KI_merge_ChIP.mm10.sorted.bam
ONAME=H3K4me3_cnt_combinedreps

samtools merge ${OPATH}${ONAME}\.merged.bam ${IPATH}${INPUT1} ${IPATH}${INPUT2} | \
samtools sort -@ ${NUM_THREADS} - -o ${OPATH}${ONAME}\.merged.sorted.bam

#samtools index ${OPATH}${ONAME}\.merged.sorted.bam

echo 'Done with merging, sorting and indexing bam files'
