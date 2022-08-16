# <i>Hypoatherina temminckii</i> "Hte" PSMC Readme

07/25/2022

    Step 0.
      
      Copied scripts over, created necessary directories.
      scaffolds.fasta is not present- need to find reference genome

07/26/2022 

    Step 1.
    
        scaffolds.fa now exsists has been renamed
        ran removesmalls: 7427 scaffolds, Filtered assembly length: 231221148
        scaffolds changed to numerals
    
    Step 2.
    
        cloned dDocent
        edited config5.ssl

07/27/2022

    Step 2.

        confirmed config5.ssl was edited correctly
        copied config.5.cssl  dDocentHPC.bash  dDocentHPC_ODU.sbatch to correct directory
        cpying over fq gz failed, need to re-run renaming 
        still failed -> running gzip *.fq in folder -> .fq.fz files exist now
        copied over .fq.gz files, scripts, and fasta file
        edited config5.ssl and dDocentHPC_ODU edited
        mkBAM failed -> renaming fqgz's -> submitted mkBAM 819336

07/28/022

    Step 2.

        mkBAM ran successfully, need to re-run with 30 instead of 80
        re-running mkBAM 819758... should take about 03:15:00
        mkBAM ran successfully
        fltrBAM job 823499 ran successfully
        mergeBAM ran successfully
    
    Step 3.   
       
        depth: 14.144, range 4.81333333333-28.88
        copied mpileup.sbatch
        
    Step 4.
    
        submitted all mpileup.sbatch jobs for 7427 scaffolds

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
