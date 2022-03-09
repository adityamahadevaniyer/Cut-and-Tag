#Ran this script interactively -- Ran line one by one

singularity shell /projects/baker-lab/containers/deeptools/3.3.2.sif/deeptools_3.3.2.sif

bamCoverage -b H3K36me3-CnT-germ-50K_GT21-09222.sorted.bam -o H3K36me3-CnT-germ-50K_GT21-09222_raw.bw

bamCoverage -b H3K27ac-CnT-germ-50K_GT21-09223.sorted.bam -o H3K27ac-CnT-germ-50K_GT21-09223_raw.bw

bamCoverage -b H3K9ac-CnT-germ-50K_GT21-09224.sorted.bam -o H3K9ac-CnT-germ-50K_GT21-09224_raw.bw

bamCoverage -b H3K4me3-CnT-HSPCs-50K-rep1_GT21-09225.sorted.bam -o H3K4me3-CnT-HSPCs-50K-rep1_GT21-09225_raw.bw

bamCoverage -b H3K4me3-CnT-HSPCs-50K-rep2_GT21-09226.sorted.bam -o H3K4me3-CnT-HSPCs-50K-rep2_GT21-09226_raw.bw
