# Molecular basis of global promoter sensing and nucleosome capture by the SWR1 chromatin remodeler

### Robert K. Louder <sup>1</sup>, Giho Park <sup>2</sup>, Ziyang Ye <sup>1</sup>†, Justin S. Cha <sup>3</sup>, Anne M. Gardner <sup>3</sup>, Qin Lei <sup>1</sup>, Anand Ranjan <sup>1</sup>, Eva Höllmüller <sup>4,5,6</sup>, Florian Stengel <sup>5,6</sup>, B. Franklin Pugh <sup>3</sup>, Carl Wu <sup>1,7</sup>

<sup>1</sup>Department of Biology, Johns Hopkins University, USA
<br>
<sup>2</sup>Biochemistry, Cellular and Molecular Biology Graduate Program, Johns Hopkins School of Medicine, USA
<br>
<sup>3</sup>Department of Molecular Biology and Genetics, Cornell University, USA
<br>
<sup>4</sup>Department of Chemistry, University of Konstanz, Germany
<br>
<sup>5</sup>Department of Biology, University of Konstanz, Germany
<br>
<sup>6</sup>Konstanz Research School Chemical Biology, University of Konstanz, Germany
<br>
<sup>7</sup>Department of Molecular Biology and Genetics, Johns Hopkins School of Medicine, USA
<br>
†Present Address: Department of Biology, Massachusetts Institute of Technology, USA

### Correspondence: wuc@jhu.edu

### PMID : [XXXXXXXX](https://pubmed.ncbi.nlm.nih.gov/XXXXXXXX/)
### GEO ID : [GSE275429](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE275429)

## Abstract
The SWR1 chromatin remodeling complex (SRCAP in humans) is recruited to +1 nucleosomes downstream of transcription start sites of eukaryotic promoters, where it exchanges histone H2A for the specialized variant H2A.Z. Here we use cryo-EM to resolve the structural basis of the SWR1 interaction with free DNA, revealing a distinct open conformation of the Swr1 ATPase that enables sliding from accessible DNA to nucleosomes. A complete structural model of the SWR1-nucleosome complex illustrates critical structure-function roles for Swc2 and Swc3 subunits in oriented nucleosome engagement by SWR1. Moreover, an extended DNA-binding α -helix within the Swc3 subunit enables sensing of nucleosome linker length and is essential for SWR1 promoter-specific recruitment and activity. The previously unresolved N-SWR1 subcomplex forms a flexible extended structure enabling multivalent recognition of acetylated histone tails by reader domains to further direct SWR1 towards the +1 nucleosome. Altogether, our findings provide a generalizable mechanism for promoter-specific targeting of chromatin and transcription complexes.

## Table of Contents

### data
Stores BAM, BigWig, Fastq, BED, and Occupancy composite files.

### bin
Stores scripts and executables that are not run directly but called by other scripts. In order to run other scripts, you must download [ScriptManager](https://github.com/CEGRcode/scriptmanager) with:
```
cd bin
./download_scriptmanager.sh
```

### 00_Download_and_Preprocessing
To download data and calculate normalization factors:
```
cd 00_Download_and_Preprocessing
./1_download_data.sh
mkdir norm_logs
sbatch 3_calculate_scaling_factors.slurm
```

### 02_Bulk_Processing
To process data:
```
cd 02_Bulk_Processing
mkdir pileup_logs
sbatch bulk_tagpileup.slurm
```
plot_composites.ipynb contains the code for creating composite plot svgs in 03_Composite_Results.

### 03_Composite_Results
Stores composite svg plots.