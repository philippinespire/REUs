#!/bin/bash -l

#SBATCH --job-name=merge_denovoSSL_20k
#SBATCH -o merge_denovoSSL_20k-%j.out
#SBATCH -p main
#SBATCH -c 4					# either < -c 4 > or < --ntasks=1 together withw --cpus-per-task=40 > We have been using -c 4 
##SBATCH --ntasks=1
##SBATCH --cpus-per-task=40			# 40 for Wahab or 32 for Turing
#SBATCH --mail-user=br450@rutgers.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=END

enable_lmod
module load container_env ddocent
export SINGULARITY_BIND=/home/e1garcia

#merging .bam files with samtools merge. syntax = <outfile> <infile1> <infile2> ... <infileN>
crun samtools merge ${1}_denovoSSL_20k_merged.bam ${1}*-RG.bam
crun samtools index ${1}_denovoSSL_20k_merged.bam
