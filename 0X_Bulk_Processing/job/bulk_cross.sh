#!/bin/bash

set -euo pipefail

print_usage() {
  printf "Usage: $0 -i {BAM FILE} -b {BED DIR} -o {OUTPUT DIR} -n {NORM DIR} -s {SCRIPTMANAGER COMMAND}\n"
}

SCRIPTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BASEDIR=$( dirname $( dirname $SCRIPTDIR ) )

SCRIPTMANAGER_CMD="scriptmanager"
BAMFILE=""
BEDDIR="$BASEDIR/data/BED"
OUTDIR="$BASEDIR/tag_pileup"
NORMDIR="$BASEDIR/normalization_factors"
COMPOSITE="$SCRIPTDIR/sum_Col_CDT.pl"

while getopts 'i:b:o:n:s:' flag; do
  case "$flag" in
    i) BAMFILE="$OPTARG" ;;
    b) BEDDIR="$OPTARG" ;;
    o) OUTDIR="$OPTARG" ;;
    n) NORMDIR="$OPTARG" ;;
    s) SCRIPTMANAGER_CMD="$OPTARG" ;;
    *) print_usage
       exit 1 ;;
  esac
done

if [[ ! -f $BAMFILE ]]; then
  printf "Input bam file \"$BAMFILE\" does not exist\n"
  print_usage
  exit 1
fi

BAM=$( basename $BAMFILE ".bam" )
TYPE=$( echo $BAM | cut -d "_" -f2 )
[[ -d $OUTDIR ]] || mkdir $OUTDIR

# Process BAM file for each BED file in directory
for BEDFILE in $( ls $BEDDIR/*.bed ); do
  BED=$( basename $BEDFILE ".bed" )
  DIR=$OUTDIR/$BED
  [[ -d $DIR ]] || mkdir $DIR
  [[ -d $DIR/CDT ]] || mkdir $DIR/CDT
  [[ -d $DIR/COMPOSITES ]] || mkdir $DIR/COMPOSITES
  [[ -d $DIR/NormComposites ]] || mkdir $DIR/NormComposites
  [[ -d $DIR/Heatmap/STRAND ]] || mkdir -p $DIR/Heatmap/STRAND
  [[ -d $DIR/Occupancy ]] || mkdir $DIR/Occupancy
  if [[ $TYPE == "H2B" ]] || [[ $TYPE == "H2BK123ub" ]] || [[ $TYPE == "H3" ]] || [[ $TYPE == "H3K14ac" ]] || [[ $TYPE == "H3K9ac" ]] || [[ $TYPE == "Htz1" ]]; then
    echo "Run Nucleosome"
    BASE=$BAM\_$BED
    FACTOR=$( grep 'BOTH:' $NORMDIR/$BAM.NFR_ScalingFactor.out | awk -F " " '{print $2}' )

    $SCRIPTMANAGER_CMD read-analysis tag-pileup --cpu 4 $BEDFILE $BAMFILE -s 15 --combined -o $DIR/COMPOSITES/$BASE.out -M $DIR/CDT/$BASE
    $SCRIPTMANAGER_CMD read-analysis scale-matrix $DIR/CDT/$BASE\_combined.cdt -s $FACTOR -o $DIR/CDT/$BASE\_combined_Normalized.cdt
    $SCRIPTMANAGER_CMD figure-generation heatmap -p 0.95 --black $DIR/CDT/$BASE\_combined_Normalized.cdt -o $DIR/Heatmap/STRAND/$BASE\_combined_treeview.png

    $SCRIPTMANAGER_CMD read-analysis tag-pileup $BEDFILE $BAMFILE -o $DIR/COMPOSITES/$BASE.out -M $DIR/CDT/$BASE\_read1
    $SCRIPTMANAGER_CMD read-analysis scale-matrix $DIR/CDT/$BASE\_read1_anti.cdt -s $FACTOR -o $DIR/CDT/$BASE\_read1_anti_Normalized.cdt
    $SCRIPTMANAGER_CMD read-analysis scale-matrix $DIR/CDT/$BASE\_read1_sense.cdt -s $FACTOR -o $DIR/CDT/$BASE\_read1_sense_Normalized.cdt

    perl $COMPOSITE $DIR/CDT/$BASE\_read1_anti_Normalized.cdt $DIR/CDT/$BASE\_ANTI
    perl $COMPOSITE $DIR/CDT/$BASE\_read1_sense_Normalized.cdt $DIR/CDT/$BASE\_SENSE
    cat $DIR/CDT/$BASE\_SENSE <(tail -1 $DIR/CDT/$BASE\_ANTI) > $DIR/NormComposites/$BASE\_Normalized.out
    rm $DIR/CDT/$BASE\_SENSE $DIR/CDT/$BASE\_ANTI
  else
    echo "Run classic TF pileup"
    BASE=$BAM\_$BED\_read1
    FACTOR=$( grep 'Scaling factor' $NORMDIR/$BAM.NCIS_ScalingFactors.out | awk -F " " '{print $3}' )

    $SCRIPTMANAGER_CMD read-analysis tag-pileup --cpu 4 $BEDFILE $BAMFILE -o $DIR/COMPOSITES/$BASE.out -M $DIR/CDT/$BASE
    $SCRIPTMANAGER_CMD read-analysis scale-matrix $DIR/CDT/$BASE\_anti.cdt -s $FACTOR -o $DIR/CDT/$BASE\_anti_Normalized.cdt
    $SCRIPTMANAGER_CMD read-analysis scale-matrix $DIR/CDT/$BASE\_sense.cdt -s $FACTOR -o $DIR/CDT/$BASE\_sense_Normalized.cdt
    $SCRIPTMANAGER_CMD figure-generation heatmap -p 0.95 --blue $DIR/CDT/$BASE\_sense_Normalized.cdt -o $DIR/Heatmap/STRAND/$BASE\_sense_treeview.png
    $SCRIPTMANAGER_CMD figure-generation heatmap -p 0.95 --red $DIR/CDT/$BASE\_anti_Normalized.cdt -o $DIR/Heatmap/STRAND/$BASE\_anti_treeview.png
    $SCRIPTMANAGER_CMD figure-generation merge-heatmap $DIR/Heatmap/STRAND/$BASE\_sense_treeview.png $DIR/Heatmap/STRAND/$BASE\_anti_treeview.png -o $DIR/Heatmap/$BASE\_merge.png

    perl $COMPOSITE $DIR/CDT/$BASE\_anti_Normalized.cdt $DIR/CDT/$BASE\_ANTI
    perl $COMPOSITE $DIR/CDT/$BASE\_sense_Normalized.cdt $DIR/CDT/$BASE\_SENSE
    cat $DIR/CDT/$BASE\_SENSE <(tail -1 $DIR/CDT/$BASE\_ANTI) > $DIR/NormComposites/$BASE\_Normalized.out
    rm $DIR/CDT/$BASE\_SENSE $DIR/CDT/$BASE\_ANTI
  fi
done
