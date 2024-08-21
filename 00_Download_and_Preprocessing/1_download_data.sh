FQDIR=$(dirname $(dirname $(realpath $0)))/data/FQ
BAMDIR=$(dirname $(dirname $(realpath $0)))/data/BAM
BWDIR=$(dirname $(dirname $(realpath $0)))/data/BigWig

[ -d $FQDIR ] || mkdir $FQDIR
echo "Downloading FASTQ files to $FQDIR"
wget -q -O $FQDIR/32892_Htz1_M8823_Louder1_-_YPDad__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/c242d3a529a61a6c/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32893_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/eecd51a1f85fe52f/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32895_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/93bf32e3772a7a0d/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32954_Htz1_M8823_Louder1_-_YPDad__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/16ff82fba12cc3c5/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32957_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/9ac513e7d42b61c6/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32959_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/7e60948b233d9b77/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/33878_Swr1_i5006_W303_SWR1-TAP_YPD__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/d8f22af638102592/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/33882_Swr1_i5006_W303_swc3delta--NatMx--SWR1-TAP_YPD__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/117b76cc7bf3edb3/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/33883_Swr1_i5006_W303_swc3-177-255delta--SWR1-TAP_YPD__XO_R1.fq.gz https://hyperion.cac.cornell.edu/datasets/c1b4b7b087490746/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32892_Htz1_M8823_Louder1_-_YPDad__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/3b864c718f34cbe6/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32893_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/53c3fda25ca03b08/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32895_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/564bd7bae6fd63bb/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32954_Htz1_M8823_Louder1_-_YPDad__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/fa4e213dc8eb46b2/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32957_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/4dfafee65b09fedb/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/32959_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/6373be7f971bb662/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/33878_Swr1_i5006_W303_SWR1-TAP_YPD__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/384920f6d8959894/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/33882_Swr1_i5006_W303_swc3delta--NatMx--SWR1-TAP_YPD__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/51835572070949a8/display?to_ext=fastqsanger.gz
wget -q -O $FQDIR/33883_Swr1_i5006_W303_swc3-177-255delta--SWR1-TAP_YPD__XO_R2.fq.gz https://hyperion.cac.cornell.edu/datasets/a23c882f5d901e65/display?to_ext=fastqsanger.gz

[ -d $BAMDIR ] || mkdir $BAMDIR
echo "Downloading BAM files to $BAMDIR"
wget -q -O $BAMDIR/32892_Htz1_M8823_Louder1_-_YPDad__XO.bam https://hyperion.cac.cornell.edu/datasets/80fb5ba5a44c5b78/display?preview=False
wget -q -O $BAMDIR/32893_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO.bam https://hyperion.cac.cornell.edu/datasets/6153aa444a25640c/display?preview=False
wget -q -O $BAMDIR/32895_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO.bam https://hyperion.cac.cornell.edu/datasets/c654737cf5d70e7a/display?preview=False
wget -q -O $BAMDIR/32954_Htz1_M8823_Louder1_-_YPDad__XO.bam https://hyperion.cac.cornell.edu/datasets/78732aa9eeaff50e/display?preview=False
wget -q -O $BAMDIR/32957_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO.bam https://hyperion.cac.cornell.edu/datasets/ad32330df49a0814/display?preview=False
wget -q -O $BAMDIR/32959_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO.bam https://hyperion.cac.cornell.edu/datasets/7a3d64a0ab9a6abc/display?preview=False
wget -q -O $BAMDIR/33878_Swr1_i5006_W303_SWR1-TAP_YPD__XO.bam https://hyperion.cac.cornell.edu/datasets/09d983f3d2205205/display?preview=False
wget -q -O $BAMDIR/33882_Swr1_i5006_W303_swc3delta--NatMx--SWR1-TAP_YPD__XO.bam https://hyperion.cac.cornell.edu/datasets/71bcde4102b9a340/display?preview=False
wget -q -O $BAMDIR/33883_Swr1_i5006_W303_swc3-177-255delta--SWR1-TAP_YPD__XO.bam https://hyperion.cac.cornell.edu/datasets/d4c30931fe5c9ebf/display?preview=False

[ -d $BWDIR ] || mkdir $BWDIR
echo "Downloading BigWig files to $BWDIR"
wget -q -O $BWDIR/32892_Htz1_M8823_Louder1_-_YPDad__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/1f6c419ec9493bbe/display?to_ext=bigwig
wget -q -O $BWDIR/32893_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/fbd0174f43d9ef57/display?to_ext=bigwig
wget -q -O $BWDIR/32895_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/7b38fc9fc7ef4c19/display?to_ext=bigwig
wget -q -O $BWDIR/32954_Htz1_M8823_Louder1_-_YPDad__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/41672ac8c30a7531/display?to_ext=bigwig
wget -q -O $BWDIR/32957_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/ab55ce590a5a0afd/display?to_ext=bigwig
wget -q -O $BWDIR/32959_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/78358eee6cf45a63/display?to_ext=bigwig
wget -q -O $BWDIR/33878_Swr1_i5006_W303_SWR1-TAP_YPD__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/eeaf1f77847d8e25/display?to_ext=bigwig
wget -q -O $BWDIR/33882_Swr1_i5006_W303_swc3delta--NatMx--SWR1-TAP_YPD__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/a854a941d5785e03/display?to_ext=bigwig
wget -q -O $BWDIR/33883_Swr1_i5006_W303_swc3-177-255delta--SWR1-TAP_YPD__XO.forward.bw https://hyperion.cac.cornell.edu/datasets/9b45915da1cc2750/display?to_ext=bigwig
wget -q -O $BWDIR/32892_Htz1_M8823_Louder1_-_YPDad__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/37b5e2624d3f50ce/display?to_ext=bigwig
wget -q -O $BWDIR/32893_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/7f3f52b3772601eb/display?to_ext=bigwig
wget -q -O $BWDIR/32895_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/29e49778669b3fb6/display?to_ext=bigwig
wget -q -O $BWDIR/32954_Htz1_M8823_Louder1_-_YPDad__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/741123b76149adc6/display?to_ext=bigwig
wget -q -O $BWDIR/32957_Htz1_M8823_Louder3_Swc3-177-255D-Swr1-Halo_YPDad__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/b621c1c3a792d2de/display?to_ext=bigwig
wget -q -O $BWDIR/32959_Htz1_M8823_Louder5_swc3D-Swr1-Halo_YPDad__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/74574605861d344f/display?to_ext=bigwig
wget -q -O $BWDIR/33878_Swr1_i5006_W303_SWR1-TAP_YPD__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/accdce22feb4e55e/display?to_ext=bigwig
wget -q -O $BWDIR/33882_Swr1_i5006_W303_swc3delta--NatMx--SWR1-TAP_YPD__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/9aee9cdc73a8aa2c/display?to_ext=bigwig
wget -q -O $BWDIR/33883_Swr1_i5006_W303_swc3-177-255delta--SWR1-TAP_YPD__XO.reverse.bw https://hyperion.cac.cornell.edu/datasets/34d713f60cc57366/display?to_ext=bigwig

echo "Downloading control BAM file to $BAMDIR"
wget -q -O $BAMDIR/masterNoTag_20180928.zip https://www.datacommons.psu.edu/download/eberly/pughlab/yeast-epigenome-project/masterNoTag_20180928.zip
unzip $BAMDIR/masterNoTag_20180928.zip -d $BAMDIR
rm $BAMDIR/masterNoTag_20180928.zip