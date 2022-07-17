#!/bin/bash -l

#SBATCH --job-name=denovoSSL_20k_mpileup
#SBATCH -o denovoSSL_20k_mpileup-%j.out 
#SBATCH --mem 2000 #most runs should be under 1 GB but we'll add a buffer
#SBATCH -p main 
#SBATCH -n 1 #each chromosome will be processed on a single core (-n 1)  
#SBATCH -N 1 #on one machine (-N 1)  
#SBATCH --cpus-per-task=40 
#SBATCH --mail-user=br450@rutgers.edu 
#SBATCH --mail-type=begin 
#SBATCH --mail-type=END 

enable_lmod 

module load container_env ddocent

export SINGULARITY_BIND=/home/e1garcia

CHR=`expr ${SLURM_ARRAY_TASK_ID} + ${6}`
DATAPATH="/home/e1garcia/shotgun_PIRE/2022_REU/${1}/${2}_PSMC/data/mkBAM/${3}_denovoSSL_20k_PSMC"
mkdir -p $DATAPATH/denovoSSL_20k_PSMC/
mkdir -p $DATAPATH/denovoSSL_20k_PSMC/joblog

cd ${DATAPATH}

crun samtools mpileup -C50 -r $CHR -uf $DATAPATH/reference.denovoSSL.${3}20k.fasta $DATAPATH/${3}_denovoSSL_20k.bam | crun bcftools call -c - | crun vcfutils.pl vcf2fq -d ${4} -D ${5} $DATAPATH/denovoSSL_20k_PSMC/${3}_denovoSSL_20k.$CHR.fq

mv *mpileup*out $DATAPATH/denovoSSL_20k_PSMC/joblog
