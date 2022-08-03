# README for Abigail Ethridge

---

## Checklist

### SSL: 
* Stethojulis interrupta

### PSMC:
* Herklotsichthys quadrimaculatus - need R
* Spratelloides gracili - need R
* Stethojulis interrupta - need R
* Ambassis kopsii - need R
* Periophthalmus argentilineatus - need R
* Sphaeramia nematoptera - not started

---

## Journal

### July 12, 2022

#### Pre-Processing Section: Stethojulis interrupta

Step 0. Rename the raw fq.gz files

Step 1. Check quality of data with fastqc

Step 2. First trim with fastp

Step 3. Clumpify

Step 4. Run fastp2

Started Step 5. Run fastq_screen

### July 13, 2022

#### Pre-Processing Section: Stethojulis interrupta

Finished Step 5. Run fastq_screen

Step 6. Repair fastq_screen paired end files

Step 7. Calculate the percent of reads lost in each step

#### Genome Assembly Section: Stethojulis interrupta

Started Step 1. Genome Properties

### July 14, 2022

#### Genome Assembly Section: Stethojulis interrupta

Finished Step 1. Genome Properties

Started Step 2. Assemble the Genome Using SPAdes

### July 15, 2022

#### PSMC: Herklotsichthys quadrimaculatus

Step 0. Setup

Step 1. Preparing reference genomes

Started Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

### July 19, 2022

#### Genome Assembly Section: Stethojulis interrupta

Finished Step 2. Assemble the Genome Using SPAdes

Library  |  # of contigs |  size of largest contig  |  total length  |  N50  |  L50
---  | ---  |  ---  |  ---  |  ---  |  ---
A  |  69126  |  150657  |  583970986  |  10319  |  15699
B  |  69634  |  150819  |  579984097  |  10094  |  15982
C  |  67590  |  130976  |  344743603  |  5055  |  22374
alllibs  |  63103  |  135104  |  307932117  |  4743  |  21357

Step 3. Running BUSCO

#### PSMC: Herklotsichthys quadrimaculatus

Finsihed Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

Step 3. Assessing depth of coverage

Started Step 4. Calling genotypes and consensus sequences

### July 20, 2022

#### Genome Assembly Section: Stethojulis interrupta

Finished Step 4. Fill in QUAST and BUSCO Values

Step 5. Identify Best Assembly

Step 6. Assemble Contaminated Data From the Best Library

#### PSMC: Herklotsichthys quadrimaculatus

Step 5. Converting files to PSMC format.

### July 21, 2022

#### PSMC: Herklotsichthys quadrimaculatus

Step 6. Running PSMC

Step 7. Creating confidence intervals via bootstrapping

### July 22, 2022

#### PSMC: Herklotsichthys quadrimaculatus

Step 8. Examining the outputs and making plots

### July 25, 2022

#### Genome Assembly Section: Stethojulis interrupta

Run BUSCO on contaminated scaffolds data

#### PSMC: Spratelloides gracili

Step 0. Setup

Step 1. Preparing reference genomes

Started Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

### July 26, 2022

#### Genome Assembly Section: Stethojulis interrupta

Run BUSCO on contaminated contigs data
* Scaffolds Library A Deconimated is the best!

### July 27, 2022

#### PSMC: Spratelloides gracili

Finished Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

Step 3. Assessing depth of coverage

Step 4. Calling genotypes and consensus sequences

Step 5. Converting files to PSMC format

Step 6. Running PSMC

Step 7. Creating confidence intervals via bootstrapping

Step 8. Examining the outputs and making plots

#### PSMC: Stethojulis interrupta

Step 1. Preparing reference genomes

Started Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

### PSMC: Ambassis kopsii

Step 0. Setup

Step 1. Preparing reference genomes

Started Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

### July 28, 2022

#### PSMC: Stethojulis interrupta

Finished Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

Step 3. Assessing depth of coverage

Step 4. Calling genotypes and consensus sequences

Step 5. Converting files to PSMC format

Step 6. Running PSMC

Step 7. Creating confidence intervals via bootstrapping

Step 8. Examining the outputs and making plots

#### PSMC: Ambassis kopsii

Continuing Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

### July 29, 2022

#### PSMC: Ambassis kopsii

Finished Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

Step 3. Assessing depth of coverage

Step 4. Calling genotypes and consensus sequences

Step 5. Converting files to PSMC format.

Step 6. Running PSMC

Step 7. Creating confidence intervals via bootstrapping

Step 8. Examining the outputs and making plots

### August 1, 2022

#### PSMC: Periophthalmus argentilineatus

Step 0. Setup

Step 1. Preparing reference genomes.

Statrted Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

### August 3, 2022

#### PSMC: Periophthalmus argentilineatus

Finished Step 2. Mapping reads to a reference genome and working with mapping (.bam) files

Step 3. Assessing depth of coverage

Step 4. Calling genotypes and consensus sequences

Step 5. Converting files to PSMC format

Step 6. Running PSMC

Step 7. Creating confidence intervals via bootstrapping

Step 8. Examining the outputs and making plots
