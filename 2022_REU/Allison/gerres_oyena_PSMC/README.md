PSMC for Gerres oyena
---

07/21/2022

data-->mkBam --> 20k PSMC folder
sbatch dDocentHPC_ODU.sbatch worked successfully
Running fltrbam- edited dDocent_hpc_ODU_edu, job 775941
bams outputted at 13:30-ish, ran merge bams, job 777937 - failed, output file says missing bam files with "100k" in name but we are working with 20 k
replaced mergebams.sbatch, it is running now
success: _denovoSSL_20k_merged.bam
renamed: Goy_20K_merged.bam	Goy_20K_merged.bam.bai
salloc
module load samtools
samtools depth  Goy_20K_merged.bam | awk '{sum+=$3} END { print "Average (covered sites) = ",sum/NR}'
average depth of coverage (covered sites): 55.5198
range:  18.5066 - 111.0396
sbatch --array=1-8340 mpileup.sbatch --array=1-8340 afink007 gerres_oyena Goy 18.5066 111.0396 0 
Slurm is temporarily down, something about sleeping-- using script from workshop
sbatch --array=1-1000 mpileup.sbatch Allison gerres_oyena Goy 19 111 0

07/22/2022

1-1000 successfully run!
Found article for demersal eggs, added into intro
Ran up to 5000
All successful, have fq files in joblogs folder
Ran mpileup for the remaining scaffolds (5001-9000)

07/24/2022

Ran psmc

07/25/2022

opened .eps file for Goy, looks like it processed correctly.
Ran bootstraping


07/29/2022

Checking to see if bootstrapping worked
***GOY DONE W/TERMINAL.***


