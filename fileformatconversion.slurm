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

module load samtools
module load bedtools

BAMDIR=/projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/bams
Sample=H3K4me3-CnT-HSPCs-50K-rep2_GT21-09226
chromSize=/projects/baker-lab/clbaker/genomes/mm10/mm10.chrom.sizes

#Filter and keep the mapped pairs
samtools view -bS -F 0x4 /projects/baker-lab/CutNTag/germ_cell_histonemarks_and_Trowbridge/bams/H3K4me3-CnT-HSPCs-50K-rep2_GT21-09226_bowtie2.sam > \
${BAMDIR}/${Sample}_bowtie2.mapped.bam

#Convert into bed file format
bedtools bamtobed -bedpe  -i ${BAMDIR}/${Sample}_bowtie2.mapped.bam > ${BAMDIR}/${Sample}_bowtie2.bed

#Keep the read pairs that are on the same chromosome and fragment length less than 1000bp
awk '$1==$4 && $6-$2 < 1000 {print $0}' ${BAMDIR}/${Sample}_bowtie2.bed > ${BAMDIR}/${Sample}_bowtie2.clean.bed

#Only extract the fragment related columns
cut -f 1,2,6 ${BAMDIR}/${Sample}_bowtie2.clean.bed | \
sort -k1,1 -k2,2n -k3,3n > ${BAMDIR}/${Sample}_bowtie2.fragments.bed

#Convert the bed files to bedgraph
bedtools genomecov -bg -i ${BAMDIR}/${Sample}_bowtie2.fragments.bed -g $chromSize > \
${BAMDIR}/${Sample}_bowtie2.fragments.normalized.bedgraph
