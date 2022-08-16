# <i>Lethrinus Variegatus</i> "Lva" PSMC Readme

07/25/2022  

    Step 0.

      scaffolds.fasta not added to directory

07/27/2022

    Step 0.
  
      Alllibs scaffolds.fasta added by Brendan
      reneamed scaffolds.fasta
  
    Step 1.
  
      Ran removesmalls: 14506 scaffolds, assembly length: 566550182
      Renamed smalls to have numerals
  
    Step 2.
  
      Cloned dDocent, created Lva_denovoSSL_20k_PSMC, Copied over fq.gz files, copied scripts & fasta file

07/28/2022

    Step 2.

      mkBAM failed
      rm *.bam *.bai (to start fresh)
      re-running mkBAM 819767... should take about 16:20:00

07/29/2022

    Step 2.
    
      mkBAM ran successfully
      fltrBAM ran successfully 
      mergebam 866742 ran successfully
      
    Step 3. 
    
      Depth: 81.2831, range 27.0943666667 - 162.5662

07/30/2022

    Step 4.
    
        sbatch --array=1-1000 mpileup.sbatch Allison lethrinus_variegatus_PSMC Lva 27 163 0
        ^ Failed: improper naming
        mpileup re-ran successfully for 14506 scaffolds
        all fq files created
    
    Step 5.
    
        psmcfa ran successfully
        
    Steps 6-7.
    
        psmc ran successfully
        running psmcboot  918081

08/01/2022

    Steps 7-8.
    
        Psmc Boot ran successfully
        psmcbootplot.sbatch ran successfully
        need to use lower y-lim
        ***Lva done in Terminal***


