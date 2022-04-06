#!/bin/bash
#PBS -m e
#PBS -l nodes=1:ppn=1,walltime=4:00:00

cd $PBS_O_WORKDIR

module load MACS/1.4.2

BAMDIR=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/bams/sortedbams/
TREAT=H3K9ac-CnT-germ-50K_GT21-09224.sorted.bam
CONTROL=/projects/baker-lab/CutNTag/bams/sortedbams/IgG_rep_withDup.sorted.bam
ONAME=H3K9ac_withDup_pvalue_1e-1_macs14

# macs
macs14 -t ${BAMDIR}${TREAT} -c ${CONTROL} -f BAM -g mm -p 1e-1 -B -n ${ONAME}

# -t treatment file
# -c control file (i.e. input DNA)
# -f format
# -g genome size (mm=mouse)
# -p p-value cut off for detection
# -n experiment name
# -B bedgraph...tells macs to save pileup (takes longer)
