# Shotgun Data Processing Log - SSL data <i> 

Following the [pire_fq_gz_processing](https://github.com/philippinespire/pire_fq_gz_processing) and [pire_ssl_data_processing](https://github.com/philippinespire/pire_ssl_data_processing) roadmaps.

---

## **A. Pre-Processing Section**

## Step 0. Rename the raw fq.gz files

Used decode file from Sharon Magnuson.

```
salloc
bash

cd /home/e1garcia/shotgun_PIRE/2022_REU/Allison/corythoichthys_haematopterus/

#run renameFQGZ.bash first to make sure new names make sense
bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Sfa_ProbeDevelopmentLibraries_SequenceNameDecode.tsv

#run renameFQGZ.bash again to actually rename files
#need to say "yes" 2x
bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/renameFQGZ.bash Sfa_ProbeDevelopmentLibraries_SequenceNameDecode.tsv rename
```

---

## Step 1. Check quality of data with fastqc

Ran [`Multi_FASTQC.sh`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/Multi_FASTQC.sh). 
Specify out directory to write the output to: /home/e1garcia/shotgun_PIRE/2022_REU/Allison/corythoichthys_haematopterus/

```
cd /home/e1garcia/shotgun_PIRE/REUs/home/e1garcia/shotgun_PIRE/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq

#Multi_FastQC.sh "<indir>" "file extension"
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh  "/home/e1garcia/shotgun_PIRE/REUs/home/e1garcia/shotgun_PIRE/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq" "fq.gz"
```

[Report]
 (https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq/fastqc_report.html) written out to `shotgun_raw_fq` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.*

Potential issues:
  * % duplication -
    * Avg 75.53% | Low 70.9% |High 79.7%
  * gc content -
    * Avg 43.33% | Low 42% | High 45%
  * quality -
    * High (Between about 33.76 to 36.59)
  * % adapter -
    * Exponential: reaches (138,2)
  * number of reads - total of all six fastQC
    * 175,634,191 unique | 547,135,225 duplicate

---

## Step 2.  First trim with fastp

Ran [`runFASTP_1st_trim.sbatch`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFASTP_1st_trim.sbatch).

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#sbatch runFASTP_1st_trim.sbatch <INDIR/full path to files> <OUTDIR/full path to desired outdir>
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_1st_trim.sbatch shotgun_raw_fq fq_fp1
```

[Report](https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/fq_fp1/1st_fastp_report.html) written out to `fq_fp1` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.*

Potential issues:  
  * % duplication -  
    * 74.06% Avg | 71.0% Low | 76.3% High
  * gc content - 
    * 43.33% Avg | 42.6% Low | 44.0% High
  * passing filter - 
    * 97.5% Avg | 96.7% Low | 98.0% High
  * % adapter -  
    * 5.77% Avg | 5.5% Low | 6.0% High
  * number of reads - 
    * 704 M Passed filter (704,274,690) | 16,566,434 Low Quality | 63,728 Too Many N | 1,161,410 Too short
---

## Step 3. Clumpify

Ran [`runCLUMPIFY_r1r2_array.bash`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runCLUMPIFY_r1r2_array.bash) in a 3 node array on Wahab.

```
cd /home/e1garcia/shotgun_PIRE/REUs/home/e1garcia/shotgun_PIRE/2022_REU/Allison/corythoichthys_haematopterus/

bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runCLUMPIFY_r1r2_array.bash fq_fp1 fq_fp1_clmp /scratch/your_wahab_user_name 3
```

Checked the output with [`checkClumpify_EG.R`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/checkClumpify_EG.R).

```
cd /home/e1garcia/shotgun_PIRE/REUs/home/e1garcia/shotgun_PIRE/2022_REU/Allison/corythoichthys_haematopterus/

salloc
enable_lmod
module load container_env mapdamage2

crun R < /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/checkClumpify_EG.R --no-save
```

Clumpify worked succesfully!

Moved all `*out` files to the `logs` directory.

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

mv *out logs
```

---

## Step 4. Run fastp2

Ran [`runFASTP_2_ssl.sbatch`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFASTP_2_ssl.sbatch).

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#runFASTP_2_ssl.sbatch <indir> <outdir> 
#do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFASTP_2_ssl.sbatch fq_fp1_clmp fq_fp1_clmp_fp2
```

[Report](https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/fq_fp1_clmp_fp2/2nd_fastp_report.html) written out to `fq_fp1_clmp_fp2` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.*

Potential issues:  
  * % duplication - 
    * 29.57% Avg | 26.2% Low | 31.1% High
  * gc content - 
    * 42.83% Avg | 42.2% Low | 43.4% High
  * passing filter - 
    * 78.97% Avg | 78.1% Low | 80.1% High
  * % adapter - 
    * 0.6% Avg | 0.6% Low | 0.6% High
  * number of reads
    * 201,878,690 total passed filter | 53,816,562 too short | 0 low quality | 0 too many N

---

## Step 5. Run fastq_screen

Ran [`runFQSCRN_6.bash`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runFQSCRN_6.bash).

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus

#runFQSCRN_6.bash <indir> <outdir> <number of nodes to run simultaneously>
#do not use trailing / in paths
bash /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runFQSCRN_6.bash fq_fp1_clmp_fp2 fq_fp1_clmp_fp2_fqscrn 6
```

Checked output for errors.

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

ls fq_fp1_clmp_fp2_fqscrn/*tagged.fastq.gz | wc -l
ls fq_fp1_clmp_fp2_fqscrn/*tagged_filter.fastq.gz | wc -l 
ls fq_fp1_clmp_fp2_fqscrn/*screen.txt | wc -l
ls fq_fp1_clmp_fp2_fqscrn/*screen.png | wc -l
ls fq_fp1_clmp_fp2_fqscrn/*screen.html | wc -l

#checked for errors in all out files at once
grep 'error' slurm-fqscrn.*out
grep 'No reads in' slurm-fqscrn.*out

#No errors!
```

Have to run Multiqc separately.

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#runMULTIQC.sbatch <indir> <report name>
#do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runMULTIQC.sbatch fq_fp1_clmp_fp2_fqscrn fastqc_screen_report
```

[Report](https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/fq_fp1_clmp_fp2_fqscrn/fastqc_screen_report.html) written out to `fq_fp1_clmp_fp2_fqscrn` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.*

Potential issues:
  * one hit, one genome, no ID ~XX% - 94.50% Average
  * no one hit, one genome to any potential contaminators (bacteria, virus, human, etc)  ~5.5% Average

Cleaned-up logs again.

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

mv *out logs/
```

---

## Step 6. Repair fastq_screen paired end files

Ran [`runREPAIR.sbatch`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/runREPAIR.sbatch).

```sh
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#runREPAIR.sbatch <indir> <outdir> <threads>
#do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runREPAIR.sbatch fq_fp1_clmp_fp2_fqscrn fq_fp1_clmp_fp2_fqscrn_repaired 40
```

This went smoothly.

Have to run Fastqc-Multiqc separately.

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#Multi_FastQC.sh "<indir>" "file_extension"
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "/home/e1garcia/shotgun_PIRE/REUs/your_dir/species_dir/fq_fp1_clmp_fp2_fqscrn_repaired" "fq.gz" 
```

[Report](https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/fq_fp1_clmp_fp2_fqscrn_repaired/fastqc_report.html) written out to `fq_fp1_clmp_fp2_fqscrn_repaired` directory. *To visualize, click "view raw" and then add "[https://htmlpreview.github.io/?](https://htmlpreview.github.io/?)" to the beginning of the URL.*

Potential issues:  
  * % duplication - 
    * 23.61% Avg | 21.2% Low | 25.1% High
  * gc content - 
    * 41.6% Avg | 41% Low | 42% High
  * number of reads
    * 142 M Unique (141,673,534) | 44 M Duplicate (43,800,664)

---

## Step 7. Calculate the percent of reads lost in each step

Ran [`read_calculator_ssl.sh`](https://github.com/philippinespire/pire_fq_gz_processing/blob/main/read_calculator_ssl.sh).

```sh
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/


#sbatch read_calculator_ssl.sh <species home dir> 
#do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/read_calculator_ssl.sh "https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus"
```

Generated the [percent_read_loss](https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/readLoss_table.tsv) and [percent_reads_remaining](https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/readsRemaining_table.tsv) tables.
#Go back
Reads lost:
  * fastp1 dropped [200.651% Low | 250.014% Avg | 330.649% High] of the reads
  * [60.482 Low 453.84% Avg | 643.149% High] of reads were duplicates and were dropped by clumpify
  * fastp2 dropped [199.075% Low | 210.591% Avg 219.419% High] of the reads after deduplication

Reads remaining:
  * Total reads remaining: |236.209% Low |258.3% Avg |253.864% High

---

## **B. Genome Assembly Section**

## Step 1. Genome Properties

Corythoichthys haematopterus does does not have a genome available at either genomesize.com or NCBI Genome databases. 
 
We will still estimate the genome size of Corythoichthys haematopterus using Jellyfish to remain consistent with all the other species.

Executed `runJellyfish.sbatch` using the decontaminated files.

```sh
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#runJellyfish.sbatch <Species 3-letter ID> <indir>
sbatch /home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/runJellyfish.sbatch "Cha" "fq_fp1_clmp_fp2_fqscrn_repaired"
```

The Jellyfish kmer-frequency [histogram file](https://github.com/philippinespire/REUs/blob/master/2022_REU/Allison/corythoichthys_haematopterus/fq_fp1_clmp_fp2_fqscrn_repaired/Sfa_all_reads.histo) 
was uploaded into [GenomeScope v1.0](http://qb.cshl.edu/genomescope/) and [GenomeScope v2.0](http://qb.cshl.edu/genomescope/genomescope2.0/) to generate the [v1.report](http://genomescope.org/analysis.php?code=d2sRmgVsGOpAPLJF2t1y) and [v2.report](http://qb.cshl.edu/genomescope/genomescope2.0/analysis.php?code=D5gJlbN5zkc50f2WT7NO). 

Genome stats for Sfa from Jellyfish/GenomeScope v1.0 & v2.0
stat    |min    |max    
------  |------ |------
Heterozygosity v1.0|NA       |NA      
Heterozygosity v2.0|5.75072%       |8.10213%       
Genome Haploid Length v1.0|NA   |NA
Genome Haploid Length v2.0|331,154,892 bp    |341,940,767 bp 
Model Fit   v1.0|NA       |NA       
Model Fit   v2.0|45.5045%      |86.4415%        

Red flags: Genomescope 1 unconverged. 
We will use the max value from V2 rounded up to 342 M bp.

---

## Step 2. Assemble the Genome Using [SPAdes](https://github.com/ablab/spades#sec3.2)

Executed [runSPADEShimem_R1R2_noisolate.sbatch](https://github.com/philippinespire/pire_ssl_data_processing/blob/main/scripts/runSPADEShimem_R1R2_noisolate.sbatch) for each library and for all the libraries combined.

```sh
#new window
ssh username@turing.hpc.odu.edu
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#runSPADEShimem_R1R2_noisolate.sbatch <your user ID> <3-letter species ID> <contam | decontam> <genome size in bp> <species dir>
#do not use trailing / in paths

#1st library
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "Allison" "Cha" "1" "decontam" "342000000" "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/" "fq_fp1_clmp_fp2_fqscrn_repaired"

#2nd library
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "Allison" "Cha" "2" "decontam" "342000000" "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/" "fq_fp1_clmp_fp2_fqscrn_repaired"

#3rd library
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "Allison" "Cha" "3" "decontam" "342000000" "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/" "fq_fp1_clmp_fp2_fqscrn_repaired"

#all libraries combined
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "Allison" "Cha" "all_3libs" "decontam" "342000000" "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/" "fq_fp1_clmp_fp2_fqscrn_repaired"
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
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/

#runBUSCO.sh <species dir> <SPAdes dir> <contigs | scaffolds>
#do not use trailing / in paths

#1st library - contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_Cha-CBas-A_decontam_R1R2_noIsolate" "contigs"

#2nd library -contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_Cha-CBas-B_decontam_R1R2_noIsolate" "contigs"

#3rd library - contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_Cha-CBas-C_decontam_R1R2_noIsolate" "contigs"

#all libraries - contigs
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_allLibs_decontam_R1R2_noIsolate" "contigs"

#1st library -scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_Chaa-CBas-A_decontam_R1R2_noIsolate" "scaffolds"

#2nd library - scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_Cha-CBas-B_decontam_R1R2_noIsolate" "scaffolds"

#3rd library - scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_Cha-CBas-C_decontam_R1R2_noIsolate" "scaffolds"

#all libraries - scaffolds
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runBUSCO.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "SPAdes_allLibs_decontam_R1R2_noIsolate" "scaffolds"
```

## Step 4. Fill in QUAST and BUSCO Values

### Summary of QUAST (using GenomeScope v.2 <enter genome length> estimate) and BUSCO Results (Tab Delimited)

Species    	Library    	DataType    	SCAFIG    	covcutoff    	genome scope v.    	No. of contigs    	Largest contig    	Total length 	% Genome size completeness    	N50    	L50    	Ns per 100 kbp    	BUSCO single copy	
------  	------  	------ 	------ 	------ 	------  	------ 	------ 	------ 	------ 	------  	------ 	------ 	------ 	
Cha	allLibs  	decontam     	contigs       	off       		74819	282571	364837995	41.16	4799	25780	0.00	798	
Cha	allLibs  	decontam     	scaffolds       	off       		76635	282571	378208088	41.15	4860	26123	51.41	811	
Cha	CPnd-A	decontam     	contgs       	off       		8516	116066	45376391	46.86	4852	2278	0.00	406	
Cha	CPnd-A	decontam     	scaffolds       	off       		9451	198527	198527	46.76	4773	2534	104.89	421	
Cha	CPnd-B	decontam     	contgs       	off       		12295	176474	56786073	45.54	4260	4145	0.00	479	
Cha	CPnd-B	decontam     	scaffolds       	off       		14138	269079	65369174	45.28	4268	4762	150.71	491	
Cha	CPnd-C	decontam     	contgs       	off       		6572	153476	36962939	46.19	5041	1498	0.00	369	
Cha	CPnd-C	decontam     	scaffolds       	off       		7408	182426	40835802	45.98	4851	1756	84.64	389	
														

 
## Step 5. Identify Best Assembly

What is the best assembely: Alllibs contam scaffolds

## Step 6. Assemble Contaminated Data From the Best Library

```sh
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus

#runSPADEShimem_R1R2_noisolate.sbatch <your user ID> <3-letter species ID> <library: all_2libs | all_3libs | 1 | 2 | 3> <contam | decontam> <genome size in bp> <species dir>
#do not use trailing / in paths
sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "Allison" "Cha" "2" "contam" "342000000" "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus" "fq_fp1_clmp_fp2_fqscrn_repaired"
```

--- 

## **C. Probe Design - Regions for Probe Development**

Probe design was not conducted for this species.
