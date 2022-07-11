# Lethrinus variegatus

---

Jordan Rodriguez

---

## Pre-processing Lva fq files for Shotgun Sequencing Libraries - SSL data

---

Steps below followed preprocessing protocol on https://github.com/philippinespire/pire_fq_gz_processing 

### FASTQC: Checking the quality of Lva data
---
I ran Fastqc and Multiqc simultneously using the [Multi_FASTQC.sh](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/Multi_FASTQC.sh) script. This ran for ~1hr.

```bash
Done on User@wahab.hpc.odu.edu
cd /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/lethrinus_variegatus
sbatch ../pire_fq_gz_processing/Multi_FASTQC.sh "fq.gz" "/home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/lethrinus_varigatus/fq_raw_shotgun"  
```

Files output to and results reported in multiqc_report_fq.gz.html in Multi_FASTQC dir

---

### First Trim: FastP
---
I ran [runFASTP_1st_trim.sbatch](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFASTP_1st_trim.sbatch) using the following code:

```bash
Done on User@wahab.hpc.odu.edu
cd /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/lethrinus_variegatus
sbatch ../pire_fq_gz_processing/runFASTP_1st_trim.sbatch fq_raw_shotgun fq_fp1
```
---

### Remove Duplicates: Clumpify
---
I ran [runCLUMPIFY_r1r2_array.bash](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runCLUMPIFY_r1r2_array.bash) using the following code:

```bash 
```

Files and results output to fq_fp1_clmparray_fp2

---

### Second Trim: FastP2 
---
I ran [runFASTP_2_ssl.sbatch](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFASTP_2_ssl.sbatch) using the following code:

```bash
```

Files and results output to fq_fp1_clmp_fp2

FastP2 was then run a second time, trimming the first 15 bp. I used the following code:

```bash
```

Files and results output to fq_fp1_clmp_fp2b

---

### Decontaminate Files: FastQScreen 

*Note: runFQSCRN_6.bash was executed for both f2p (untrimmed) and f2pb(trimmed) data 

I ran [runFQSCRN_6.bash](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFQSCRN_6.bash) using the following code:

f2p:
```bash
bash runFQSCRN_6.bash fq_fp1_clmp_fp2 fq_fp1_clmp_fp2_fqscrn 20
```
*Note: the number of nodes running simultaneously should not exceed that number of fq.gz files. For Lva, there is a total of 6 fq.gz files, so I ran this on 6 nodes.

f2pb:
```bash
```



Files output to fq_fp1_clmparray_fp2b_fqscrn for trimmed and fq_fp1_clmparray_fp2_fqscrn for untrimmed

## Step 4 Repair

runREPAIR.sbatch in https://github.com/philippinespire/pire_fq_gz_processing was run 

Files output to fq_fp1_clmparray_fp2b_fqscrn_repaired for trimmed and fq_fp1_clmparray_fp2_fqscrn_repaired for untrimmed

```bash 
```


## Step 5 Genome Assembly

a. Genome properties

I used [genomesize.com](https://www.genomesize.com/) to find the genome size of Lethrinus genus. 

I executed runJellyfish.sbatch using the decontaminated files. 

runJellyfish.sbatch in https://github.com/philippinespire/pire_fq_gz_processing was run on trimmed files first and then untrimmed files

Files output to fq_fp1_clmp_fp2b_fqscrn_rprd_jfsh and fq_fp1_clmp_fp2_fqscrn_rprd_jfsh respectively

Genome stats for Lva from Jellyfish/GenomeScope v1.0 and v2.0, k=21 for both versions:

version    |stat    |min    |max
------  |------ |------ |------
1  |Heterozygosity  |0.596741%       |0.609334% 
2  |Heterozygosity  |0.62143%       |0.635333%
1  |Genome Haploid Length   |867,877,709 bp |869,278,859 bp
2  |Genome Haploid Length   |899,850,172 bp |900,696,415 bp
1  |Model Fit       |93.9719%       |94.8156%
2  |Model Fit       |88.2079%      |95.4316%

Links to reports:
[GenomeScopev1.0](http://qb.cshl.edu/genomescope/analysis.php?code=yxsG2k3Q7PEZzj0M1YdO)
[GenomeScopev2.0](http://qb.cshl.edu/genomescope/genomescope2.0/analysis.php?code=mnBW14oWFT18lpGP8HSx)

I chose GenomeScope v2.0 due to the higher model fit percentage. Genome size estimate can be rounded to 901,000,000bp.

b. Assembling the Genome with SPAdes

```bash
Done on User@turing.hpc.odu.edu
sbatch /home/j1rodrig/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "j1rodrig" "Lva" "1" "decontam" "901000000" "/home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/lethrinus_variegatus" "fq_fp1_clmp_fp2b_fqscrn_repaired"
```
