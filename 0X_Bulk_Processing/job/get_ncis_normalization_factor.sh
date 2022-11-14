#!/bin/bash

set -euo pipefail

print_usage() {
  printf "Usage: $0 -i {BAM FILE} -c {CONTROL FILE} -b {BLACKLIST} -o {OUTPUT DIR} -s {SCRIPTMANAGER COMMAND}\n"
}

SCRIPTDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BASEDIR=$( dirname $( dirname $SCRIPTDIR ) )

SCRIPTMANAGER_CMD="scriptmanager"
BAMFILE=""
CONTROLFILE="$SCRIPTDIR/../normalization_reference_files/masterNoTag_20180928.bam"
BLACKLIST="$SCRIPTDIR/../normalization_reference_files/ChexMix_Peak_Filter_List_190612.bed"
OUTDIR="$BASEDIR/normalization_factors"

while getopts 'i:c:b:o:s:' flag; do
  case "$flag" in
    i) BAMFILE="$OPTARG" ;;
    c) CONTROLFILE="$OPTARG" ;;
    b) BLACKLIST="$OPTARG" ;;
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

$SCRIPTMANAGER_CMD read-analysis scaling-factor $BAMFILE -f $BLACKLIST --ncis -c $CONTROLFILE -w 500 -o $OUTDIR/$BAM.NCIS
