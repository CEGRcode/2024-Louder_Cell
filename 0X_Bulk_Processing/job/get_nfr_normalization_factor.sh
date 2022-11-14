#!/bin/bash

set -euo pipefail

print_usage() {
  printf "Usage: $0 -i {BAM FILE} -b {BED FILE} -o {OUTPUT DIR} -s {SCRIPTMANAGER COMMAND}\n"
}

SCRIPTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BASEDIR=$( dirname $( dirname $SCRIPTDIR ) )

SCRIPTMANAGER_CMD="scriptmanager"
BAMFILE=""
BEDFILE="$SCRIPTDIR/../normalization_reference_files/NFR_03-TFO_04-UNB_50bp.bed"
OUTDIR="$BASEDIR/normalization_factors"
SUM="$SCRIPTDIR/sum_Row_CDT.pl"

while getopts 'i:b:o:s:' flag; do
  case "$flag" in
    i) BAMFILE="$OPTARG" ;;
    b) BEDFILE="$OPTARG" ;;
    o) OUTDIR="$OPTARG" ;;
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

[[ -d $OUTDIR ]] || mkdir $OUTDIR
TEMP="$OUTDIR/$BAM.NFR"
[[ -d $TEMP ]] || mkdir $TEMP

WINDOW=50

SF_FILE=$TEMP\_ScalingFactor.out
echo $'Sample file:\t'$BAMFILE > $SF_FILE
echo $'Scaling type:\tNFR_median' >> $SF_FILE
echo $'Window size(bp):\t'$WINDOW >> $SF_FILE

BASE=$TEMP/both
$SCRIPTMANAGER_CMD read-analysis tag-pileup $BEDFILE $BAMFILE -s 15 --combined -o $BASE\_composite.out -M $BASE\_CDT
perl $SUM $BASE\_CDT_combined.cdt $BASE\_tagcount.cdt
sort -rnk2,2 $BASE\_tagcount.cdt > $BASE\_tagcount_sorted.cdt
NGENES=$( wc -l $BEDFILE | awk '{print $1}' )
AVERAGE=$( cut -f2 $BASE\_tagcount_sorted.cdt | awk -v n=$NGENES -v w=$WINDOW '{Total=Total+$1} END{print n/Total}' )
echo $'BOTH:\t'$AVERAGE >> $SF_FILE

rm -r $TEMP
