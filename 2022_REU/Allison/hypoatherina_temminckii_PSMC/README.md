# <i>Hypoatherina temminckii</i> "Hte" PSMC Readme

07/25/2022

    Step 0.
      
      Copied scripts over, created necessary directories.
      scaffolds.fasta is not present- need to find reference genome

07/26/2022 

scaffolds.fa has been put in and has been renamed
ran removesmalls
7427 scaffolds
Filtered assembly length: 231221148
scaffolds changed to numerals
cloned dDocent
edited config5.ssl

07/27/2022

double-checking that config5.ssl was edited correctly
Hte_denovoSSL_20k_PSMC is empty: cpoied in config.5.cssl  dDocentHPC.bash  dDocentHPC_ODU.sbatch
cpying over fq gz failed, need to re-run renaming 
still failed -> running gzip *.fq in folder
.fq.fz files exist now
copied over .fq.gz files
cpoied over scripts
copied over fasta file
edited config5.ssl
dDocentHPC_ODU edited
Submitted batch job 819230- failed
renaming fqgz's
submitted 819336

07/28/022

mkBAM finished, need to re-run with 30 instead of 80
rm *.bam *.bai
re-running mkBAM 819758... should take about 03:15:00
mkBAM is done
running fltrBAM job 823499
copied config and dDocent files
fltrBAM ended 
running mergebam
merge successful
depth: 14.144, range 4.81333333333-28.88
copied mpileup.sbatch
7427 scaffolds

sbatch --array=1-1000 mpileup.sbatch Allison hypoatherina_temminckii Hte 05 29 0

All mpileups are running

07/29/2022


Counting scaffolds with ls -1 *fq | wc -l 
7427 files, correct number
copied psmcfa.sbatch

sbatch --array=1-1000 psmcfa.sbatch Allison hypoatherina_temminckii Hte 0 
^Worked, running for rest

psmcfa conversion successful
running psmc, gentime: 4.23454215
sbatch psmc.sbatch Allison hypoatherina_temminckii Hte 4.23454215

psmc cuccessful
bootstraping failed: "hypoatherina_temminckii_PSMC_PSMC"

07/30/2022

Re-do of bootstraping: sbatch psmcboot.sbatch Allison hypoatherina_temminckii Hte
Job 885382

08/01/22

Psmcboot worked
running psmcbootplot.sbatch
sbatch psmcbootplot.sbatch Allison lethrinus_variegatus Lva 4.8756936 1000
^Job 962894
***Hte done in terminal***
