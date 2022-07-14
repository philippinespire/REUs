# Shotgun Data Processing Log - SSL data

Copy and paste this into a new species dir and fill in as steps are accomplished. Following the [pire_fq_gz_processing](https://github.com/philippinespire/pire_fq_gz_processing) and [pire_ssl_data_processing](https://github.com/philippinespire/pire_ssl_data_processing) roadmaps. 

---

## **A. Pre-Processing Section** 

Step 0. Rename the raw fq.gz files

Files were already renamed, so skipping this step.

---

## Step 1. Check quality of data with fastqc

Ran [`Multi_FASTQC.sh`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/Multi_FASTQC.sh). Specify out directory to write the output to. 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba/shotgun_raw_fq

#Multi_FastQC.sh "<indir>" "file extension"
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FastQC.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba/shotgun_raw_fq" "fq.gz"
```

[Report](https://github.com/philippinespire/REUs/blob/master/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba/shotgun_raw_fq/fastqc_report.html) written out to `shotgun_raw_fq` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.* 

Potential issues:
  * % duplication -
    * 22.9%
  * gc content -
    * 46.2%
  * quality -
    * 36
  * number of reads -
    * 245.7M

---

## Step 2.  First trim with fastp

Ran [`runFASTP_1st_trim.sbatch`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFASTP_1st_trim.sbatch). 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#sbatch runFASTP_1st_trim.sbatch <INDIR/full path to files> <OUTDIR/full path to desired outdir>
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_1st_trim.sbatch shotgun_raw_fq fq_fp1 
``` 

[Report](https://github.com/philippinespire/REUs/blob/master/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba/fq_fp1/1st_fastp_report.html) written out to `fq_fp1` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.* 

Potential issues:
  * % duplication -
    * 16.4%
  * gc content -
    * 45.1%
  * passing filter -
    * 95.4%
  * % adapter -
    * 27.2%
  * number of reads -
    * 450M ---

## Step 3. Clumpify

Ran [`runCLUMPIFY_r1r2_array.bash`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runCLUMPIFY_r1r2_array.bash) in a 3 node array on Wahab. 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba 

bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runCLUMPIFY_r1r2_array.bash fq_fp1 fq_fp1_clmp /scratch/r3clark 3 
``` 

Checked the output with [`checkClumpify_EG.R`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/checkClumpify_EG.R). 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba 

salloc 
enable_lmod 
module load container_env mapdamage2 

crun R < /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/checkClumpify_EG.R --no-save 
``` 

Clumpify worked succesfully! Moved all `*out` files to the `logs` directory. 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

mv *out logs 
``` 

---

## Step 4. Run fastp2

Ran [`runFASTP_2_ssl.sbatch`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFASTP_2_ssl.sbatch). 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#runFASTP_2_ssl.sbatch <indir> <outdir> do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_2_ssl.sbatch fq_fp1_clmp fq_fp1_clmp_fp2 
``` 

[Report](https://github.com/philippinespire/2022_PIRE_omics_workshop/blob/main/salarias_fasciatus/fq_fp1_clmp_fp2/2nd_fastp_report.html) written 
out to `fq_fp1_clmp_fp2` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.* 

Potential issues:
  * % duplication -
    * 3.8%
  * gc content -
    * 44.4%
  * passing filter -
    * 65.7%
  * % adapter -
    * 0.4%
  * number of reads
    * 380M 
 
---

## Step 5. Run fastq_screen

Ran [`runFQSCRN_6.bash`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFQSCRN_6.bash). 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#runFQSCRN_6.bash <indir> <outdir> <number of nodes to run simultaneously> do not use trailing / in paths
bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFQSCRN_6.bash fq_fp1_clmp_fp2 fq_fp1_clmp_fp2_fqscrn 6 
``` 

Checked output for errors. 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

ls fq_fp1_clmp_fp2_fqscrn/*tagged.fastq.gz | wc -l 
ls fq_fp1_clmp_fp2_fqscrn/*tagged_filter.fastq.gz | wc -l 
ls fq_fp1_clmp_fp2_fqscrn/*screen.txt | wc -l 
ls fq_fp1_clmp_fp2_fqscrn/*screen.png | wc -l 
ls fq_fp1_clmp_fp2_fqscrn/*screen.html | wc -l

#checked for errors in all out files at once
grep 'error' slurm-fqscrn.*out grep 'No reads in' slurm-fqscrn.*out
#No errors!
``` 

Have to run Multiqc separately. 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#runMULTIQC.sbatch <indir> <report name> do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runMULTIQC.sbatch fq_fp1_clmp_fp2_fqscrn fastqc_screen_report 
``` 

[Report](https://github.com/philippinespire/2022_PIRE_omics_workshop/blob/main/salarias_fasciatus/fq_fp1_clmp_fp2_fqscrn/fastqc_screen_report.html) written out to `fq_fp1_clmp_fp2_fqscrn` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.* 

Potential issues:
  * one hit, one genome, no ID ~95.75% -
  * no one hit, one genome to any potential contaminators (bacteria, virus, human, etc) ~2.5% 
  
Cleaned-up logs again. 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

mv *out logs/ 
``` 

---

## Step 6. Repair fastq_screen paired end files

Ran [`runREPAIR.sbatch`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runREPAIR.sbatch). 

```sh 
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba

#runREPAIR.sbatch <indir> <outdir> <threads> do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runREPAIR.sbatch fq_fp1_clmp_fp2_fqscrn fq_fp1_clmp_fp2_fqscrn_repaired 40 
``` 

This went smoothly. Have to run Fastqc-Multiqc separately. 

``` 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#Multi_FastQC.sh "<indir>" "file_extension"
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba/fq_fp1_clmp_fp2_fqscrn_repaired" "fq.gz" 
``` 

[Report](https://github.com/philippinespire/2022_PIRE_omics_workshop/blob/main/salarias_fasciatus/fq_fp1_clmp_fp2_fqscrn_repaired/fastqc_report.html) written out to `fq_fp1_clmp_fp2_fqscrn_repaired` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.* 

Potential issues:
  * % duplication -
    * XX%
  * gc content -
    * XX%
  * number of reads
    * XX% 
    
---

## Step 7. Calculate the percent of reads lost in each step

Ran [`read_calculator_ssl.sh`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/read_calculator_ssl.sh). 

```sh 
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba

#sbatch read_calculator_ssl.sh <species home dir> do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/read_calculator_ssl.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba" 
``` 

Generated the [percent_read_loss](https://github.com/philippinespire/2022_PIRE_omics_workshop/blob/main/salarias_fasciatus/preprocess_read_change/readLoss_table.tsv) and [percent_reads_remaining](https://github.com/philippinespire/2022_PIRE_omics_workshop/blob/main/salarias_fasciatus/preprocess_read_change/readsRemaining_table.tsv) tables. 

Reads lost:
  * fastp1 dropped 4.7% of the reads
  * 17.2% of reads were duplicates and were dropped by clumpify
  * fastp2 dropped 12% of the reads after deduplication Reads remaining: 88%
  * Total reads remaining: 64.3% 

---

## **B. Genome Assembly Section** 

## Step 1. Genome Properties

*Species name* does (or does not) have a genome available at either genomesize.com or NCBI Genome databases.
 
We will still estimate the genome size of *Species name* using Jellyfish to remain consistent with all the other species. 

Executed `runJellyfish.sbatch` using the decontaminated files. 

```sh 
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#runJellyfish.sbatch <Species 3-letter ID> <indir>
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runJellyfish.sbatch "Sfa" "fq_fp1_clmp_fp2_fqscrn_repaired"
``` 

The Jellyfish kmer-frequency [histogram file](https://github.com/philippinespire/REUs/blob/master/2022_REU/marial_malabag/encrasicholina_pseudoheteroloba/fq_fp1_clmp_fp2_fqscrn_repaired/Eps_all_reads.histo) was uploaded into [GenomeScope v1.0](http://qb.cshl.edu/genomescope/) and [GenomeScope v2.0](http://qb.cshl.edu/genomescope/genomescope2.0/) to generate the [v1.report](http://genomescope.org/analysis.php?code=LxPaCiK7cELrIKJd3QOC) and [v2.report](http://genomescope.org/genomescope2.0/analysis.php?code=EakXqJkKDl3tTJEYsQtS). 

Genome stats for Sfa from Jellyfish/GenomeScope v1.0 & v2.0
stat    |min    |max    
------  |------ |------
Heterozygosity v1.0|3.94786%       |4.00483%       
Heterozygosity v2.0|4.62952%       |4.97878%       
Genome Haploid Length v1.0|1,030,746,004 bp    |1,037,679,402 bp 
Genome Haploid Length v2.0|1,439,839,810 bp    |1,458,202,121 bp 
Model Fit   v1.0|92.8928%       |96.8057%       
Model Fit   v2.0|60.9765%       |95.3059%       

*Mention any red flags here, otherwise state "No red flags".* 

We will use the max value from V2 rounded up to ***insert value here*** bp. 

GenomeScopev1 for 1B: http://genomescope.org/analysis.php?code=ad25IBQHV8mLBRnZp9TJ 

GenomeScopev2 for 1B: http://genomescope.org/genomescope2.0/analysis.php?code=LkdH8CJlQldxq3fYSxQh 

GenomeScopev1 for 2A: http://qb.cshl.edu/genomescope/analysis.php?code=5aTtkXKH28qOd1EuqVJJ 

GenomeScopev2 for 2A: http://genomescope.org/genomescope2.0/analysis.php?code=Ci4J9W5NFL8Yaqn0mDBT 

GenomeScopev1 for 2H: http://qb.cshl.edu/genomescope/analysis.php?code=DRkcEA4LfN0P1DQAsWNU 

GenomeScopev2 for 2H: http://genomescope.org/genomescope2.0/analysis.php?code=sI5d1rtIPm6nNPWbjUMY 

---

## Step 2. Assemble the Genome Using [SPAdes](https://github.com/ablab/spades#sec3.2)

Executed [runSPADEShimem_R1R2_noisolate.sbatch](https://github.com/philippinespire/pire_ssl_data_processing/blob/main/scripts/runSPADEShimem_R1R2_noisolate.sbatch) for each library and for all the libraries combined.

```sh
#new window
ssh username@turing.hpc.odu.edu
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#runSPADEShimem_R1R2_noisolate.sbatch <your user ID> <3-letter species ID> <contam | decontam> <genome size in bp> <species dir>
#do not use trailing / in paths

#1st library
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "e1garcia" "Sfa" "1" "decontam" "635000000" "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/yourname" "fq_fp1_clmp_fp2_fqscrn_repaired"

#2nd library
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "e1garcia" "Sfa" "2" "decontam" "635000000" "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/yourname" "fq_fp1_clmp_fp2_fqscrn_repaired"

#3rd library
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "e1garcia" "Sfa" "3" "decontam" "635000000" "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/yourname" "fq_fp1_clmp_fp2_fqscrn_repaired"

#all libraries combined
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "e1garcia" "Sfa" "all_3libs" "decontam" "635000000" "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/yourname" "fq_fp1_clmp_fp2_fqscrn_repaired"
```
 
JOB IDs:

```
[e1garcia@turing1 salarias_fasciatus]$ sq
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           9767803     himem     Sp8s e1garcia  R       0:01      1 coreV4-21-himem-003
           9767802     himem     Sp8s e1garcia  R       0:16      1 coreV4-21-himem-002
           9767801     himem     Sp8s e1garcia  R       0:27      1 coreV2-23-himem-004
           9767800     himem     Sp8s e1garcia  R       1:11      1 coreV2-23-himem-003
```

Libraries for each assembly:

Assembly  |  Library
--- | ---
A | 1G
B | 1H
C | 2A

This SPAdes scripts automatically runs `QUAST` but have to run `BUSCO` separately.

## Step 3. Running BUSCO

Executed [runBUCSO.sh](https://github.com/philippinespire/pire_ssl_data_processing/blob/main/scripts/runBUSCO.sh) on both the `contigs` and `scaffolds` files.

```sh
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#runBUSCO.sh <species dir> <SPAdes dir> <contigs | scaffolds>
#do not use trailing / in paths

#1st library - contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_Sfa-CBas-A_decontam_R1R2_noIsolate" "contigs"

#2nd library -contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_Sfa-CBas-B_decontam_R1R2_noIsolate" "contigs"

#3rd library - contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_Sfa-CBas-C_decontam_R1R2_noIsolate" "contigs"

#all libraries - contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_allLibs_decontam_R1R2_noIsolate" "contigs"

#1st library -scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_Sfa-CBas-A_decontam_R1R2_noIsolate" "scaffolds"

#2nd library - scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_Sfa-CBas-B_decontam_R1R2_noIsolate" "scaffolds"

#3rd library - scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_Sfa-CBas-C_decontam_R1R2_noIsolate" "scaffolds"

#all libraries - scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "SPAdes_allLibs_decontam_R1R2_noIsolate" "scaffolds"
```

## Step 4. Fill in QUAST and BUSCO Values

### Summary of QUAST (using GenomeScope v.2 <enter genome length> estimate) and BUSCO Results

Species    |Assembly    |DataType    |SCAFIG    |covcutoff    |genome scope v.    |No. of contigs    |Largest contig    |Total lenght    |% Genome size completeness    |N50    |L50    |Ns per 100 kbp    |BUSCO single copy
------  |------  |------ |------ |------ |------  |------ |------ |------ |------ |------  |------ |------ |------
Sfa  |A  |decontam       |contgs       |off       |X       |  XX  | XX  | XX  | XX% | XX  |  XX  |  0  | XX%
Sfa  |A  |decontam       |scaffolds       |off       |X    |  XX  |  XX  |   XX  |  XX% | XX  | XX  | XX  | XX%
Sfa  |B  |decontam       |contgs       |off       |X       |  XX |  XX  |   XX  |  XX% |  XX  |  XX  |  0  | XX%
Sfa  |B  |decontam       |scaffolds       |off       |X    |  XX  |  XX  |   XX  |  XX% |  XX  |  XX  |  XX  | XX%
Sfa  |C  |decontam       |contgs       |off       |X       |  XX  |  XX  |  XX  | XX% | XX  | XX  |  0  |  XX%
Sfa  |C  |decontam       |scaffolds       |off       |X    |  XX  |  XX  |   XX  | XX% |  XX  |  XX  | XX | XX%
Sfa  |allLibs  |decontam       |contigs       |off       |X    |  XX | XX |  XX  |  XX% |  XX  | XX  | xx  | XX%
Sfa  |allLibs  |decontam       |scaffolds       |off       |X   | XX | XX |  XX  |  XX% | XX  |  XX  | XX | XX%

## Step 5. Identify Best Assembly

What is the best assembley? Note here. Include the assembly and the corresponding library.

Note additional remarks if necessary

## Step 6. Assemble Contaminated Data From the Best Library

```sh
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

#runSPADEShimem_R1R2_noisolate.sbatch <your user ID> <3-letter species ID> <library: all_2libs | all_3libs | 1 | 2 | 3> <contam | decontam> <genome size in bp> <species dir>
#do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "e1garcia" "Sfa" "2" "contam" "635000000" "/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus" "fq_fp1_clmp_fp2_fqscrn_repaired"
```

--- 

## **C. Probe Design - Regions for Probe Development**

From the species directory: made probe directory, renamed assembly, and copied scripts.

```sh
cd /home/e1garcia/shotgun_PIRE/REUs/marial_malabag/encrasicholina_pseudoheteroloba

mkdir probe_design
cp /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/WGprobe_annotation.sb probe_design
cp /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/WGprobe_bedcreation.sb probe_design
cp SPAdes_SgC0072C_contam_R1R2_noIsolate/scaffolds.fasta probe_design #copy best assembly
 
# list the busco dirs
ls -d busco_*
# identify the busco dir of best assembly, copy the treatments (starting with the library)
# Example,the busco dir for the best assembly for Sgr is `busco_scaffolds_results-SPAdes_SgC0072C_contam_R1R2_noIsolate`

 # I then provide the species 3-letter code, scaffolds, and copy and paste the parameters from the busco dir after "SPAdes_" 
cd probe_design
mv scaffolds.fasta Sgr_scaffolds_B_contam_R1R2_noIsolate.fasta
```

Execute the first script
```sh
#WGprobe_annotation.sb <assembly name> 
sbatch WGprobe_annotation.sb "Sgr_scaffolds_SgC0072C_contam_R1R2_noIsolate.fasta"
```

Execute the second script
```sh
#WGprobe_annotation.sb <assembly base name> 
sbatch WGprobe_bedcreation.sb "Sgr_scaffolds_SgC0072C_contam_R1R2_noIsolate"
```

The longest scaffold is XX

The upper limit used in loop is XX

A total of XX regions have been identified from XX scaffolds


Moved out files to logs
```sh
mv *out ../logs
```

## Step 12. Fetching genomes for closest relatives

```sh
nano closest_relative_genomes_your_species.txt

Closest genomes:
1. Salarias fascistus - https://www.ncbi.nlm.nih.gov/genome/7248
2. Parablennius parvicornis - https://www.ncbi.nlm.nih.gov/genome/69445
3. Petroscirtes breviceps - https://www.ncbi.nlm.nih.gov/genome/7247
4. Ecsenius bicolor - https://www.ncbi.nlm.nih.gov/genome/41373
5. Gouania willdenowi - https://www.ncbi.nlm.nih.gov/genome/76090

Used Betancour et al. 2017 (All Blenniiformes)
```
