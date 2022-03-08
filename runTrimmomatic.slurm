#!/bin/bash
#SBATCH -J run_trimmomatic # job name
#SBATCH -N 1 # number of nodes
#SBATCH -n 1 # number of cores
#SBATCH –mem=4G # memory pool for all cores
#SBATCH -t 0-2:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR

module load singularity

cd $SLURM_SUBMIT_DIR

#module load python
module load trimmomatic

## Set directories
#DIR="$(dirname "$(pwd)")" ## Get current parent dir=project dir
FASTQDIR=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/fastq
ODIR=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/fastq/trimmed

## Get samples
R1=H3K4me3-CnT-HSPCs-50K-rep2_GT21-09226_CGAGGCTG-ACTGCATA_R1.fastq.gz
R2=H3K4me3-CnT-HSPCs-50K-rep2_GT21-09226_CGAGGCTG-ACTGCATA_R2.fastq.gz
 
## Run Trimmomatic
trimmomatic PE \
   -phred33 $FASTQDIR/$R1 $FASTQDIR/$R2 \
   $ODIR/$R1 $ODIR/unpaired_${R1} $ODIR/$R2 $ODIR/unpaired_${R2} \
   ILLUMINACLIP:/opt/bin/Trimmomatic-0.39/adapters/NexteraPE-PE.fa:2:30:10 \
   LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

## Chmod trimmed file
chmod -R 775 $ODIR
