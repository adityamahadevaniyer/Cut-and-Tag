#!/bin/bash
#SBATCH -J run_fastQC # job name
#SBATCH -N 1 # number of nodes
#SBATCH -n 1 # number of cores 
#SBATCH –mem=4G # memory pool for all cores
#SBATCH -t 0-2:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR

module load singularity

cd $SLURM_SUBMIT_DIR

module load fastqc

## Set directories
FASTQDIR=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/fastq

## Run FastQC
fastqc $FASTQDIR/* -o fastqc/

## Chmod fastQC file
chmod -R 775 $FASTQDIR

