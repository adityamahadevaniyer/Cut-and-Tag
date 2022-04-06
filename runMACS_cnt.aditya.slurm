#!/bin/bash

#SBATCH -N 1
#SBATCH -t 04:00:00
#SBATCH --mail-user=aditya.mahadevaniyer@jax.org
#SBATCH --mail-type=end
#SBATCH --job-name=macs2
#SBATCH --export=ALL

module load singularity
module load macs2

cd $SLURM_SUBMIT_DIR

CHIP=/projects/baker-lab/CutNTag/bams/sortedbams/H3K4me3_rep2_rmDup.sorted.bam
CONTROL=/projects/baker-lab/CutNTag/bams/sortedbams/IgG_rep_rmDup.sorted.bam

macs2 callpeak -t ${CHIP} -c ${CONTROL} -f BAM -g mm -n H3K4me3_rep2_q0.1_cnt -B -q 0.1 --nomodel --extsize 147


