# PSMC analysis pipeline

## Step 0. Setup

In your folder within `/home/e1garcia/shotgun_PIRE/REUs/2022_REU`, you have a folder for each species labeled `<speciesname>_PSMC`.

Your shotgun data are already copied in this folder - they are in a folder called something like "fq_fp1_clmp_fp2_fqscrn_repaired" (it will vary a bit between folders). I am going to call this folder `<shotgundata>` later on.

The reference genome `scaffolds.fasta` may have been copied to the species folder already. If it is not you will have to find the best reference genome - you can find this in most cases by consulting the README.md for the species in the [ssl repo](https://github.com/philippinespire/pire_ssl_data_processing/).

Scripts that you will be using are located in `/home/e1garcia/shotgun_PIRE/REUs/2022_REU/PSMC/scripts`.
Copy this whole directory to your folder.

```
cp -r /home/e1garcia/shotgun_PIRE/REUs/2022_REU/PSMC/scripts /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC
```

Move to your folder and create a folder called `data`.

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC
mkdir data
```

Start a README.md file in this directory too.

Now we're ready to start!

## Step 1. Preparing reference genomes.

The reference genomes we will be using are located in the species folder. The file `scaffolds.fasta` is the best shotgun assembly we created.

We will use a species code (called `<speciescode>` in this README - you will have to replace this with your code when running scripts) for keeping track of files - it's the first letter of genus name plus first two letters of species name. For example, the code for Salarias fasciatus was "Sfa". 

Rename the shotgun genome `<speciescode>_shotgun_assembly.fa`.

```
mv scaffolds.fasta <speciescode>_shotgun_assembly.fa
```

PSMC needs to have long chunks of contiguous sequence to make inferences, so want to use the larger scaffolds and filter out the small ones. We have a handy PERL-language script called `removesmalls` in the `scripts` folder that can do this. Run this on our two alternate reference genomes, keeping only scaffolds longer than 100kb (kilobases) or 20kb in length. We are going to name the output files in a specific way so they will be easy to work with later.

```
perl ../scripts/removesmalls.pl 20000 <speciescode>_shotgun_assembly.fa > reference.denovoSSL.<speciescode>20k.fa
```

Now let's check the length of the filtered assembly. This is a one-line script that will tell you the number of scaffolds left after filtering.

```
cat reference.denovoSSL.<speciescode>20k.fasta | grep "^>" | wc -l
```

How many scaffolds did we keep for the assembly? Note this in your README.

And here is the script to calculate the total length of the filtered assemblies.

```
cat reference.denovoSSL.<speciescode>20k.fasta | grep -v "^>" | tr "\n" "\t" | sed 's/\t//g' | wc -c
```

How long is the assembly?


Before we move forward, we need to change the names of the scaffolds to numerals (1,2,3...x). We can do that with another simple line of code.

```
awk -i inplace '/^>/{print ">" ++i; next}{print}' reference.denovoSSL.<speciescode>20k.fasta
```

Now we're ready to map to the reference!

## Step 2. Mapping reads to a reference genome and working with mapping (.bam) files.

We next need to map our shotgun reads to our reference genomes. This is a key step in many genomic workflows. We use a modified version of a pipeline called dDocent to do this mapping. We will use two steps in the dDocent pipeline, mkBAM (which creates .bam files that store mapping information) and fltrBAM (which filters out reads that mapped to the genome with low quality).

We first need to navigate back to our PSMC directory and clone the dDocent repo.

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC
git clone https://github.com/cbirdlab/dDocentHPC.git
```

Make a folder called data, a folder called `data/mkBAM`, and a folder called `data/mkBAM/<speciescode>_denovoSSL_20k_PSMC` in your `<speciesname>_PSMC` folder. Copy the shotgun library files to this folder.

```
cp /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/<shotgundata>/*.fq.gz /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC
```

Now we need to copy some scripts and configuration files to our folders. Note that we need to use a modified version of the sbatch file that works with the ODU HPCC.

```
cp /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/dDocentHPC/dDocentHPC.bash /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC
cp /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/dDocentHPC/configs/config.5.cssl /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC
cp /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/scripts/dDocentHPC_ODU.sbatch /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC
```

Let's try mapping to the filtered version of our shotgun genome with scaffolds >20kb. Copy this reference genome files (`denovoSSL.<speciescode>20k`) to the appropriate folder.

```
cp /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/reference.denovoSSL.<speciescode>20k.fasta /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC
```

In your `<speciescode>_denovoSSL_20k_PSMC` folder you should now have all of the files required to perform mapping: * reads to map (.R1.fq.gz/.R2.fq.gz) * reference genome (renamed scaffolds, with dDocent prefix reference.cutoff1.cutoff2.fasta) * dDocentHPC.bash * config file (currently config.5.cssl) * dDocentHPC_ODU.sbatch

Examine the `config.5.cssl` file - this file contains all of the setting that will be used to run dDocent. Most of these you can keep as they are. Recall that we used a specific convention to name our reference genome files - specifically the format is `reference.<cutoff1>.<cutoff2>.fasta`, where cutoff1 and cutoff2 refer to descriptive variables used by dDocent. We need to edit the config file `config.5.cssl` in each directory to so that dDocent can find the reference.  

The default alignment score in config.5.cssl is 80, which is a bit high - let's also change this to 30.

Here is an example:

```
----------mkREF: Settings for de novo assembly of the reference genome--------------------------------------------
PE              Type of reads for assembly (PE, SE, OL, RPE)                                    PE=ddRAD & ezRAD pairedend, non-overlapping reads; SE=singleend reads; OL=ddRAD & ezRAD overlapping reads, miseq; RPE=oregonRAD, restriction site + random shear
0.9             cdhit Clustering_Similarity_Pct (0-1)                                                   Use cdhit to cluster and collapse uniq reads by similarity threshold
denovoSSL               Cutoff1 (integer)     ### <--- change this value to either denovoSSL or genbank to match the reference ###
               Cutoff2 (integer)    ### <--- change to <speciescode>20k to match your reference
0.05    rainbow merge -r <percentile> (decimal 0-1)                                             Percentile-based minimum number of seqs to assemble in a precluster
0.95    rainbow merge -R <percentile> (decimal 0-1)                                             Percentile-based maximum number of seqs to assemble in a precluster
------------------------------------------------------------------------------------------------------------------

----------mkBAM: Settings for mapping the reads to the reference genome-------------------------------------------
Make sure the cutoffs above match the reference*fasta!
1               bwa mem -A Mapping_Match_Value (integer)
4               bwa mem -B Mapping_MisMatch_Value (integer)
6               bwa mem -O Mapping_GapOpen_Penalty (integer)
80              bwa mem -T Mapping_Minimum_Alignment_Score (integer)     ### <--- change to 30
5       bwa mem -L Mapping_Clipping_Penalty (integer,integer)
------------------------------------------------------------------------------------------------------------------

```

Go through the config file and make these changes using a text editor.

Now you may need to edit each sbatch file in each directory. Notice that this file has a lot of lines commented out with hashtags - these will run different steps in the process when un-commented. Find the line starting with `crun bash dDocentHPC.bash mkBAM config`... and un-comment this line by removing the hashtag. The config file is the last argument in this line - make sure it is the correct file (config.5.ssl). Make sure all of the other lines starting with `crun` are still commented. You can also change the job-name and output SBATCH settings in the header to identify this job (something appropriate to each reference genome, like mkBAM_denovoSSL_Sf20k), and change the email address so it emails you when finished. 

Your header, and the lines you are running, should read something like this:

```
#!/bin/bash -l

#SBATCH --job-name=mkBAM_denovoSSL_<speciescode>20k
#SBATCH -o mkBAM_denovoSLL_<speciescode>20k-%j.out
#SBATCH -p main
#SBATCH -c 4                                    # either < -c 4 > or < --ntasks=1 together withw --cpus-per-task=40 > We have been using -c 4 
##SBATCH --ntasks=1
##SBATCH --cpus-per-task=40                     # 40 for Wahab or 32 for Turing
#SBATCH --mail-user=br450@rutgers.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=END

enable_lmod
module load container_env ddocent
export SINGULARITY_BIND=/home/e1garcia

[...]

crun bash dDocentHPC.bash mkBAM config.5.cssl
```

If all of that is set you should be able to run dDocentHPC and map your reads by executing the sbatch file in each directory. Navigate to the `<speciescode>_denovoSSL_20k_PSMC` directory and run the following.

```
sbatch dDocentHPC_ODU.sbatch
```

This mapping step can take a while (overnight or a day or two!) depending on shotgun library sizes. 

After we have generated the .bam files we need to filter them. This can be done just by editing the sbatch file to un-comment the appopriate line in your sbatch file and rerunning. 

Add a hashtag at the beginning on the mkBAM line (so you don't run that step again!), then find the next line with `crun bash dDocentHPC.bash fltrBAM`... and remove the hashtag from that one. Make sure it is pointing to the proper config file again. Change "mkBAM" to "fltrBAM" in the header. THe relevant lines should look like this.

```
#!/bin/bash -l

#SBATCH --job-name=fltrBAM_denovoSSL_<speciescode>20k
#SBATCH -o fltrBAM_denovoSSL_<speciescode>20k-%j.out
#SBATCH -p main
#SBATCH -c 4					# either < -c 4 > or < --ntasks=1 together withw --cpus-per-task=40 > We have been using -c 4 
##SBATCH --ntasks=1
##SBATCH --cpus-per-task=40			# 40 for Wahab or 32 for Turing
#SBATCH --mail-user=breid@rutgers.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=END

enable_lmod
module load container_env ddocent
export SINGULARITY_BIND=/home/e1garcia

[...]

crun bash dDocentHPC.bash fltrBAM config.5.cssl
```

Once you have edited your sbatch file you can run the filtering step using the same `sbatch dDocentHPC_ODU.sbatch` command that you used before.

If we have multiple sorted .bam files from the same individual, we can merge those .bam files into a single .bam file using thecommand  `samtools merge`. To call genotypes we also need to index this merged file first. The sbatch script `mergebams.sbatch` can be used to do both of these things. This version is different from the workshop version - you should not need to edit it, but you do need to supply the appropriate `<speciescode>`. Copy it to your folder and execute.

```
cp /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/scripts/mergebams.sbatch /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC
sbatch mergebams.sbatch <speciescode>
```

## Step 3. Assessing depth of coverage.

For shotgun sequencing, we should theoretically have roughly the same depth of coverage across the whole genome. For real data this won't always be the case - some parts of the genome might have been difficult to sequence, and some repetitive regions could cause mapping issues that inflate our depth of coverage. We don't want to use these regions for calling genotypes that we will be using in the PSMC analysis later. For calling consensus sequences, PSMC documentation recommends using sites with minimum depth 1/3 of mean depth and maximum depth 2x mean depth.

We can calculate the mean depth using samtools. Let's use an interactive node to do this.

```
salloc
module load samtools
samtools depth <speciescode>_reduced_denovoSSL_20k.bam | awk '{sum+=$3} END { print "Average (covered sites) = ",sum/NR}'
```

What was the average depth of coverage? What range of coverage would we use?

Update the README.md file with this statistic.

## Step 4. Calling genotypes and consensus sequences.

This step uses scripts modified from [Harvard FAS Informatics tutorial](https://informatics.fas.harvard.edu/psmc-journal-club-walkthrough.html), [Applying PSMC to Neandertal data](http://willyrv.github.io/tutorials/bioinformatics/AltaiNea-psmc.html), & the [PSMC documentation](https://github.com/lh3/psmc) to call a "consensus sequence" from our .bam file. We use SLURM's array mode to parallelize the consensus calling, meaning that for each of the scaffolds in our reference genome we create a new processthat calls the sequence for that scaffold.

Make a folder called `joblog` inside `<speciescode>_denovoSSL_20k_PSMC`. This will hold your output logs.

The script `mpileup.sbatch` uses a pipeline from samtools to bcftools to vcfutils.pl to create a consensus sequence. Copy this script from the scripts directory to the `<speciescode>_denovoSSL_20k_PSMC` folder.

Examine the script. This has been modified from the workshop version - you do not need to edit it, but you will need to give it some arguments to tell it how to run correctly.

The arguments are:
1) Your personal directory name in /home/e1garcia/shotgun_PIRE/REUs/2022_REU/ (`<yourname>`)
2) Full species name, lowercase with underscores (`<speciesname>`)
3) Species code (`<speciescode>`)
4) The lower coverage cutoff determined from running samtools in the previous step (`<lowercutoff>`).
5) The upper coverage cutoff determined from running samtools in the previous step (`<uppercutoff>`).
6) A starting value to be added to the array task ID (`<arraystart>`). You will run these array jobs in batches of 1000, so start with 0 for the first batch, 1000 for the next batch, etc.
7) The number of scaffolds in each batch (`<arrayend>`).

`--array=1-<arrayend>` runs the job in array mode, which can do up to 1000 sequential jobs. Since for a given species we may have >1000 scaffolds, you may have to run this script multiple times. Say you have 5,236 scaffolds - you would run the script 6 times, first with `<arraystart>` set to 0, then 1000, then 2000, then 3000, then 4000, then 5000. For the first five jobs you would set `<arrayend>` to 1000, but for the last  the last job you would set it to 236. You run the script multiple times to put the jobs on the queue and then just wait for them to finish.

Execute the script from your `/home/e1garcia/shotgun_PIRE/REUs/2022_REU/<yourname>/<speciesname>_PSMC/data/mkBAM/<speciescode>_denovoSSL_20k_PSMC`  using sbatch. 

```
sbatch --array=1-<arrayend> <yourname> <speciesname> <speciescode> <lowercutoff> <uppercutoff> <arraystart> <arrayend>
```

## Step 5. Converting files to PSMC format.

Now that we have consensus sequences we need to convert these to a format PSMC understands. PSMC is really only interested in whether we have any heterozygotes within chunks of 100 base pairs, not the complete sequence data, so its input files are simplifications of the consensus FASTA file. Again we can use an array script, `psmcfa.sbatch`, to do this over all of our sequence files.

Check again to make sure that all of the file paths are correct, then run the script. This script needs to be run from the directory containing all of your consensus sequences

```
sbatch Sfa_denovoSSL_100k_psmcfa.sbatch
```

If you need to convert >1000 files we again have a modified version of the script (see `/home/e1garcia/shotgun_PIRE/2022_PIRE_omics_workshop/salarias_fasciatus/PSMC/data/mkBAM/shotgun_20k` again for an example).

## Step 6. Running PSMC.

We are finally ready to run PSMC!

The psmc.sbatch script will run PSMC and generate a basic plot. Make sure all of the paths and the input/output file names are correct. To plot the demographic history on the scale of years we need to know generation time and mutation rate. We are assuming a default mutation rate (2.25x10^-8). Generation time is species-specific; for Sfa we can use 4 years, which is average for related species.

```
sbatch Sfa_denovoSSL_100k_psmc.sbatch
```  

After running PSMC you can download the plot (.eps file) to your local computer and see the estimated demographic history of your species.

## Step 7. Creating confidence intervals via bootstrapping.

We now have an idea of how our Sfa population may have changed over time. We don't know, however, how confident we should be in the estimate of population size at any given time. One source of error is our sampling of the genome - if we sampled a different selection of regions, would we get the same result?

PSMC has a built in bootstrapping feature that can create confidence intervals for our demographic history based on resampling chunks of the data.

Run this script (make sure to modify to match your paths/etc) to perform 100 rounds of bootstrapping.

```
sbatch Sfa_denovoSSL_100k_psmcboot.sbatch
```

## Step 8. Examining the outputs and making plots.

Let's take a look at our PSMC outputs.

To plot the bootstrap result, use the `pmscbootplot.sbatch` script. Since this will include confidence intervals you will have to increase the maximum Y-axis value - 'pY100' will change it to 100x10^4. You can change the X-axis scale too. Try pY100 - does that capture the maximum bootstrapped value? Change and rerun the script if not.

How does the confidence in our estimated demographic history change from the distant past (100,000 to 1,000,000 years ago) to the recent past (10,000 years ago)?

Take a look at the PSMC output files (.psmc and .par). These are the "raw" outputs from PSMC. What do all of these numbers mean?

PSMC runs for multiple rounds (25 in this case). Each round the program generates output, and the iterations should get progressively closer to the "true" answer as they go. We can look at the results from the final iteration.

The line starting with "TR" has the estimates for theta_0 (the "scaled mutation rate") and rho_0 (the "scaled recombination rate").

The following lines have estimates for other parameters, including scaled time and the scaling factor for population size at a given time.

Notably, the numbers are scaled to mutation rate and population size. How do we translate these to unscaled estimates of effective population size?

We have a handy R script, `plot_psmc.R`, that can translate these values for us. Use this script to plot the outputs.

Compare the PSMC outputs from the shotgun_100k dataset to other datasets. Are the general trajectories the same? How do they differ? Which datasets provide higher certainty/smaller confidence intervals?
