#!/bin/bash -l 

#SBATCH --job-name=Sfa_denovoSSL_100k_psmcboot
#SBATCH -o Sfa_denovoSSL_100k_psmcboot-%j.out 
#SBATCH --mem 6000
#SBATCH --array=1-100
#SBATCH -p main 
#SBATCH -n 1 
#SBATCH -N 1  
#SBATCH --cpus-per-task=40 
#SBATCH --mail-user=aethr001@odu.edu 
#SBATCH --mail-type=begin 
#SBATCH --mail-type=END

enable_lmod 
module load container_env pire_genome_assembly/2021.07.01
export SINGULARITY_BIND=/home/e1garcia
DATAPATH="/home/e1garcia/shotgun_PIRE/REUs/2022_REU/${1}/${2}_PSMC/data/mkBAM/${3}_denovoSSL_20k_PSMC"
cd ${DATAPATH}/denovoSSL_20k_PSMC

RD="${SLURM_ARRAY_TASK_ID}"

crun psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" -o ${3}denovoSSL20kround-$RD.psmc ${3}denovoSSL20kall.psmcfa

mv ../*psmcboot*out joblog
