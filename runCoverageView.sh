#PBS -l nodes=1:ppn=4,walltime=01:00:00

cd $PBS_O_WORKDIR

module load R/3.5.1

Rscript /projects/baker-lab/CutNTag/scripts/CoverageView_CutNTag_atac_cast_aditya.R
