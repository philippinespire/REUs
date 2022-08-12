# <i>Ambassis urotaenia</i> "Aur" PSMC

07/26/2022
   
    Step 0:
      
      Scripts copied, directories created. 
    
    Step 1:
      
      Shotgun genome renamed.
      Removesmalls ran successfully: 7427 scaffolds, Filtered assembly length: 231221148
      Scffolds converted to numerals.
    
    Step 2:  
    
      cloned dDocent
      edited config5.ssl

07/27/2022

    Step 2:
    
      Incorrectly edited config5.ssl
      Removed files that were not present at beginning of step 1.
     
    Step 1:
    
      ran removesmalls
      5823 scaffolds
      total length 378223569
      
    Step 2:
    
      running mkBAM  818090, failed
      restored # in fromt of sbatch lines -> now job 819228, failed
      need to move reference genome to working directory-> already exists
      naming error in ccsl file - fixed - Job 819229
      failed, issue with accessing fq.gz files
      fixed, running 819335
      Running fltr Bam job 819506

07/28/2022    
      
    Step 2: 
    
      fltrBAM ran successfully
      copied over mergebams
      ran mergebams 819771
      mergebam ran successfully
    
    Step 3:
    
      Samtools depth not runnin correctly.
    
    Step 2:
    
      Re-ran merebams successfully.

07/29/2022      
    
    Step 3:
      
      Samtools depth ran successfully: average depth= 149.641, 49.8803333333 - 299.282
      
    Step 4:
    
      Mpileup worked for all 5823 scaffolds
      Psmcfa failed
    
    Step 2:
      
      Re-ran fltrBAM job 883903
