#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=16GB
#SBATCH -t 06:00:00
#SBATCH -A open
#SBATCH -o pileup_logs/bulk_tagpileup.log.out-%a
#SBATCH -e pileup_logs/bulk_tagpileup.log.err-%a
#SBATCH --array 1-9

# Cross all BED x all BAM to run Tag Pileup

set -exo
module load samtools

FDIR=../data/BAM/NormalizationFactors
BAMDIR=../data/BAM
BEDDIR=../data/BED

SCRIPTMANAGER=../bin/ScriptManager-v0.14.jar

# Script shortcuts
COMPOSITE=../bin/sum_Col_CDT.pl

# Determine BAM file for the current job array index
BAM=$(head -n $SLURM_ARRAY_TASK_ID ../00_Download_and_Preprocessing/bam_files.txt | tail -n 1)

# Process BAM file for each BED file in directory
for BED in ../data/RefPT/*.bed; do
	OUTDIR=../data/TagPileup/$(basename $BED _1100bp.bed)
	BASE=$(basename $BAM .bam)_$(basename $BED _1100bp.bed)
	[ -d $OUTDIR ] || mkdir $OUTDIR
	[ -d $OUTDIR/CDT ] || mkdir $OUTDIR/CDT
	java -jar $SCRIPTMANAGER read-analysis tag-pileup -o /dev/null -M $OUTDIR/CDT/$BASE $BED $BAM
	SCALING_FACTOR=$(cat $FDIR/$(basename $BAM .bam)_NFR_ScalingFactors.out)
	[ -d $OUTDIR/NormCDT ] || mkdir $OUTDIR/NormCDT
	java -jar $SCRIPTMANAGER read-analysis scale-matrix -s $SCALING_FACTOR -o $OUTDIR/NormCDT/$BASE\_sense_Normalized.cdt $OUTDIR/CDT/$BASE\_sense.cdt
	java -jar $SCRIPTMANAGER read-analysis scale-matrix -s $SCALING_FACTOR -o $OUTDIR/NormCDT/$BASE\_anti_Normalized.cdt $OUTDIR/CDT/$BASE\_anti.cdt
	[ -d $OUTDIR/Composites ] || mkdir $OUTDIR/Composites
	perl $COMPOSITE $OUTDIR/NormCDT/$BASE\_sense_Normalized.cdt $OUTDIR/Composites/$BASE.out
	perl $COMPOSITE $OUTDIR/NormCDT/$BASE\_anti_Normalized.cdt $OUTDIR/Composites/$BASE\_anti
	tail -n 1 $OUTDIR/Composites/$BASE\_anti >> $OUTDIR/Composites/$BASE.out
	rm $OUTDIR/Composites/$BASE\_anti
done
