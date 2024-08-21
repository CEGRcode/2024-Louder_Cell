#!/bin/bash
#SBATCH -N 1
#SBATCH --mem=16GB
#SBATCH -t 00:10:00
#SBATCH -A open
#SBATCH -o norm_logs/3_calculate_scaling_factors.log.out-%a
#SBATCH -e norm_logs/3_calculate_scaling_factors.log.err-%a
#SBATCH --array 1-9

# Calculate NFR scaling factors for each BAM file
BED=NFR_03-04_50bp.bed
FDIR=../data/BAM/NormalizationFactors
BLACKLIST=../data/sacCer3_files/ChExMix_Peak_Filter_List_190612.bed

module load samtools

SCRIPTMANAGER=../bin/ScriptManager-v0.14.jar

# Set up output directories
[ -d $FDIR ] || mkdir $FDIR

# Determine BAM file for the current job array index
BAM=$(head -n $SLURM_ARRAY_TASK_ID bam_files.txt | tail -n 1)
[ -f $BAM.bai ] || samtools index $BAM

TEMP=$FDIR/$(basename $BAM)
mkdir $TEMP
java -jar $SCRIPTMANAGER read-analysis tag-pileup -s 15 -M $TEMP/temp_CDT -o $TEMP/temp_composite.out --combined $BED $BAM
perl ../bin/sum_Row_CDT.pl $TEMP/temp_CDT_combined.cdt $TEMP/temp_tagcount.cdt
sort -rnk2,2 $TEMP/temp_tagcount.cdt > $TEMP/temp_tagcount_sorted.cdt
NGENES=$(wc -l $BED | awk '{print $1}')
AVERAGE=$(cut -f2 $TEMP/temp_tagcount_sorted.cdt | awk -v n=$NGENES -v w=50 '{Total=Total+$1} END{print n/Total}')
echo $AVERAGE > $FDIR/$(basename $BAM .bam)_NFR_ScalingFactors.out
rm -r $TEMP
