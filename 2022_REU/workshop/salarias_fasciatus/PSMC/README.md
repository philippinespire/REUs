# PSMC analysis pipeline
## Background and motivation
Genomic data contains a wealth of information regarding the demographic history of populations. One of the most interesting insights to emerge from the genomic revolution is that genomic data from just a few individuals or even a single individual can be used to estimate demographic trends for entire species or populations. A number of methods, summarized in [Mather et al.](https://doi.org/10.1002/ece3.5888), have been developed to take advantage of this information. We are going to use the method developed in 2011 by [Li and Durbin](https://doi.org/10.1038/nature10231) for this workshop.

Using the curated read data and the shotgun reference genome we have developed for *Salarias fasciatus*, as well as a published reference genome for the species, we will align reads to the genome, call genotypes and consensus sequences, and run the PSMC program to estimate a demographic trajectory for this species.
## Step 1. Prepare reference genomes.
The reference genomes we will be using are located in the `data` folder. The file `scaffolds.fasta` is the best shotgun assembly we created, while `GCF_902148845.1_fSalaFa1.1_genomic.fna.gz` is a more complete reference genome that was downloaded from [Genbank](https://www.ncbi.nlm.nih.gov/genome/7248?genome_assembly_id=609472).

Let's just rename these first to make it easier to work with them. Move to the `data` folder and rename our shotgun genome `Sfa_shotgun_assembly.fa`.

--> may need to rename dir to reflect student directory

```
cd /home/e1garcia/shotgun_PIRE/REUs/2022_REU/workshop/salarias_fasciatus/PSMC/data
mv scaffolds.fasta Sfa_shotgun_assembly.fa
```

Then, unzip the file downloaded from Genbank and rename it `Sfa_genbank_assembly.fa`.

```
gunzip -c GCF_902148845.1_fSalaFa1.1_genomic.fna.gz > Sfa_genbank_assembly.fa 
```

PSMC needs to have long chunks of contiguous sequence to make inferences, so want to use the larger scaffolds and filter out the small ones. We have a handy PERL-language script called `removesmalls` in the `scripts` folder that can do this. Run this on our two alternate reference genomes, keeping only scaffolds longer than 100kb (kilobases) or 20kb in length.

```
perl ../scripts/removesmalls.pl 100000 Sfa_shotgun_assembly.fa > Sfa_shotgun_assembly_100k.fa
perl ../scripts/removesmalls.pl 100000 Sfa_genbank_assembly.fa > Sfa_genbank_assembly_100k.fa
perl ../scripts/removesmalls.pl 20000 Sfa_shotgun_assembly.fa > Sfa_shotgun_assembly_20k.fa
perl ../scripts/removesmalls.pl 20000 Sfa_genbank_assembly.fa > Sfa_genbank_assembly_20k.fa
```

Now let's check the length of the filtered assemblies. This is a one-line script that will tell you the number of scaffolds left after filtering.

```
cat Sfa_shotgun_assembly_100k.fa | grep "^>" | wc -l
cat Sfa_genbank_assembly_100k.fa | grep "^>" | wc -l
cat Sfa_shotgun_assembly_20k.fa | grep "^>" | wc -l
cat Sfa_genbank_assembly_20k.fa | grep "^>" | wc -l
```

How many scaffolds did we keep for each genome?
Sfa_shotgun_assembly_100k.fa = 130
Sfa_genbank_assembly_100k.fa = 103
Sfa_shotgun_assembly_20k.fa = 7488
Sfa_genbank_assembly_20k.fa = 196

And here are scripts to calculate the total length of the filtered assemblies.

```
cat Sfa_shotgun_assembly_100k.fa | grep -v "^>" | tr "\n" "\t" | sed 's/\t//g' | wc -c
cat Sfa_genbank_assembly_100k.fa | grep -v "^>" | tr "\n" "\t" | sed 's/\t//g' | wc -c
cat Sfa_shotgun_assembly_20k.fa | grep -v "^>" | tr "\n" "\t" | sed 's/\t//g' | wc -c
cat Sfa_genbank_assembly_20k.fa | grep -v "^>" | tr "\n" "\t" | sed 's/\t//g' | wc -c
```

How long is each assembly?
Sfa_shotgun_assembly_100k.fa = 16815789
Sfa_genbank_assembly_100k.fa = 792843668
Sfa_shotgun_assembly_20k.fa = 282010249
Sfa_genbank_assembly_20k.fa = 797427707

Our shotgun assembly has shorter scaffolds in general than the Genbank assembly. If we use only scaffolds >100k we are using a fraction of the genome, however this may still be enough to make robust inferences about demographic history. We will assess this in the next steps.

## Step 2. Align reads to a reference genome.
## Step 3. Assess depth of coverage.
## Step 4. Call genotypes and consensus sequences.
## Step 5. Convert files to PSMC format.
## Step 6. Run PSMC.
## Step 7. Create confidence intervals via bootstrapping.
## Step 8. Make plots.
