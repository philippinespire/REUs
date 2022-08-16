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

mkBAM finished, double-checking config file (should have been 30, changed)
rm *.bam *.bai
re-running mkBAM 819767... should take about 16:20:00

07/29/2022

mkBAM successful
running fltrBAM 
filterbam finished
running mergebam 866742
merge successful
Depth: 81.2831, range 27.0943666667 - 162.5662

07/30/2022

Lva has 14506 scaffolds
sbatch --array=1-1000 mpileup.sbatch Allison lethrinus_variegatus_PSMC Lva 27 163 0
Failed: improper naming
re-ran, worked
slurm can only handle 10k at a time
all fq files created
sbatch --array=1-1000 psmcfa.sbatch Allison lethrinus_variegatus Lva 0
psmc was successful
running psmcboot  918081

08/01/2022

Psmc Boot ran successfully
sbatch psmcbootplot.sbatch Allison lethrinus_variegatus Lva 4.8756936 1000
Running psmcbootplot 943421
^successful, need to use lower y-lim
**LVA done in Terminal**


