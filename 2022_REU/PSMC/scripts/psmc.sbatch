#!/bin/bash -l 

#SBATCH --job-name=denovoSSL_20k_psmc
#SBATCH -o denovoSSL_20k_psmc-%j.out 
#SBATCH --mem 6000
#SBATCH -p main 
#SBATCH -n 1 
#SBATCH -N 1  
#SBATCH --cpus-per-task=40 
#SBATCH --mail-user=br450@rutgers.edu 
#SBATCH --mail-type=begin 
#SBATCH --mail-type=END

enable_lmod 
module load container_env pire_genome_assembly/2021.07.01
export SINGULARITY_BIND=/home/e1garcia
DATAPATH="/home/e1garcia/shotgun_PIRE/REUs/2022_REU/${1}/${2}_PSMC/data/mkBAM/${3}_denovoSSL_20k_PSMC"
cd ${DATAPATH}/denovoSSL_20k_PSMC
cat ${3}_denovoSSL_20k*.psmcfa > ${3}denovoSSL20kall.psmcfa
crun psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o ${3}denovoSSL20kall.psmc ${3}denovoSSL20kall.psmcfa
crun psmc2history.pl ${3}denovoSSL20kall.psmc | crun history2ms.pl > ms-cmd.sh
crun psmc_plot.pl -g ${4} ${3}denovoSSL20k ${3}denovoSSL20kall.psmc
