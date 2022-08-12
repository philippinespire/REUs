<title><i>Haliocheres miniatus</i> (Hmi) PSMC Log </title>

07/25/2022

    Step 0:
 
      Copied everything over, made necessary directories.
  
    Step 1:
  
      removesmalls result in reference.denovoSSL.Hmi20k.fasta
      3777 scaffolds kept
      Assembly length: 117925394
 
    Step 2:
    
      Copied over scripts
      Edited dDocentHPC_ODU.sbatch 
      Edited config.5.cssl
      Running mkBAM

07/26/2022

    Step 2:
    
        mkBAM ran successfully.
        mergebam failed:
                        [E::hts_open_format] Failed to open file "Hmi*-RG.bam" : No such file or directory
                        samtools merge: fail to open "Hmi*-RG.bam": No such file or directory
                        [E::hts_open_format] Failed to open file "Hmi_denovoSSL_20k_merged.bam" : No such file or directory
                        samtools index: failed to open "Hmi_denovoSSL_20k_merged.bam": No such file or directory
        ran mergebamns with Hm instead of Hmi.
        mergebams ran successfully.
    
    Step 3:
  
        ran samtools depth coverage:
            84.8435 mean depth, range 28.2811666667 - 169.687
    
    Step 4:        
            
        ran mpileup:    sbatch --array=1-1000 mpileup.sbatch Allison halichoeres_miniatus Hmi 85 170 0
                        sbatch --array=1001-2000 mpileup.sbatch Allison halichoeres_miniatus Hmi 85 170 0
                        sbatch --array=2001-3000 mpileup.sbatch Allison halichoeres_miniatus Hmi 85 170 0
                        sbatch --array=3001-3777 mpileup.sbatch Allison halichoeres_miniatus Hmi 85 170 0
        mpileup failed. Missplelled joblog directory. made new directory, re-running.
        mpileup failed. error in dDocent filtering step.

07/27/2022

    Step 0:
    
        Deleted files that were created from steps 0 -4
        Copied scripts, created directories
        No need to rename Hmi_shotgun_assembly.fa, already exists
    
    Step 1:
    
        Completed without issue, see 07/25/2022
    
    Step 2:
    
        Corrected editing error in config5ssl.sbatch [replaced 80 with 30]
        running mkBAM: Job 817761
        
07/28/2022

    Step 2: 
    
        mkBAM ran successfully.
        fltrBAM job 819762 ran successfully
        mergebam job 819758 failed.
        fltrBAM re-run successfully.
        mergebam re-run, failed.
        mergebam re-run using Hm instead of Hmi.
    
    
        

        
        
  
  
 
