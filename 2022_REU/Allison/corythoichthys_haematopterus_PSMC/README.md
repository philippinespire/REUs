# <i>Corythoichthys haematopterus</i> "Cha" PSMC Readme

07/28/2022

  Step 0. 
  
    Copied scaffolds.fasta into main directory
    copied scripts, made data/mkBAM, renamed fasta file
    
  Step 1.
  
    removesmalls ran successfully
    658 scaffolds, length of filtered assembly: 35226418
    Changed names to numerals
   
  Step 2.

    dDocent cloned
    Cha_denovoSSL_20k_PSMC created
    moved over dDocent, scripts and .fa file
    copied fqgz to corect folder, copied in fasta, copied in scripts
    mkBAM job 824952 Failed - missing bash file
    re-ran mkBAM job 830273

07/29/2022

  Step 2.
    
    mkBAM ran successfully
    fltrBAM ran successfully
    mergebam ran successfully
    
  Step 3.
  
    Ran samtools depth: depth 70.2281 range: 23.4093666667 - 140.4562
  
  Step 4.
    
    gentime 2.60822892
    mpileup.sbatch ran successfully
    
  Step 5.
  
    psmcfa ran successfully
    
  Step 6.
  
    Psmc job 883848 ran successfully
