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

BAMDIR=/projects/baker-lab/CutNTag/bams/sortedbams/
gopeaks=/projects/baker-lab/CutNTag/scripts/gopeaks
chromSize=/projects/baker-lab/clbaker/genomes/mm10/mm10.chrom.sizes

${gopeaks} 
