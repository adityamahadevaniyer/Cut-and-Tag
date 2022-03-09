#!/bin/bash
#SBATCH --job-name=Coverage_view      # job name
#SBATCH --partition=compute               # ==queue
#SBATCH --nodes=1                         # number of nodes
#SBATCH --ntasks=4                        # number of cores
#SBATCH --mem-per-cpu=4G
#SBATCH --time=1:00:00                    # time (HH:MM:SS)
#SBATCH --output=%x.o%A_%a                # stdout and stderr
#SBATCH --mail-user=aditya.mahadevaniyer@jax.org

cd $SLURM_SUBMIT_DIR

module load singularity

singularity exec /projects/baker-lab/containers/R/3.6.3/R \
  /usr/bin/Rscript --vanilla 18012021_CoverageView_Script_CAST_cnt_atac.R

chmod 775 -R
