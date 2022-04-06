#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH -t 6:00:00
#SBATCH --export=ALL
#SBATCH --mail-user=aditya.mahadevaniyer@jax.org
#SBATCH --mail-type=end
#SBATCH --mem-per-cpu=10G

module load singularity

cd $SLURM_SUBMIT_DIR

singularity exec /projects/baker-lab/containers/encode_TSS.sif \
  python encode_cutntag_tss.pAtn5_test.py 
