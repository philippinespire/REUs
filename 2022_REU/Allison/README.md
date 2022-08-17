# <b>Allison's Readme</b>

Notes:

	/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison
	rsync afink007@wahab.hpc.odu.edu:/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq/fastqc_report.html .


07/08/2022

	First introduction draft completed

07/11/2022

	Readme created
	
	Notes working on Cha SSL:

		<i>Corythoichthys haematopterus</i> raw fq.qz files
		renamed prior to running species through pipeline.
		renameFQGZ.bash run, renamed to Cha-CPnd, outputs:
	
		Cha-CPnd_001_Ex1-1A_L4_1.fq.gz  Cha-CPnd_001_Ex1-2G_L4_1.fq.gz
		Cha-CPnd_001_Ex1-1A_L4_2.fq.gz  Cha-CPnd_001_Ex1-2G_L4_2.fq.gz
		Cha-CPnd_001_Ex1-1H_L4_1.fq.gz  stdin_fastqc.html
		Cha-CPnd_001_Ex1-1H_L4_2.fq.gz  stdin_fastqc.zip

		Git push permission error
		attempted to run Multi_FastQC.sh, permission error

07/12/2022

	Notes working on Cha SSL:

		Still have permission error for pushing
		Got MultiQC to run
		Ran Fastqp
		Multi_FastQC.sh successfuly run, html file copied to personal computer
        	/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq/fastqc_report.html   

07/18/2022

	Getting over jetlag. Checked on jobs set before leaving the Philippines. No jobs were still running on wahab or turing.
	Notes working on Cha SSL:
		Recorded data from quast output for all libs
		Running BUSCO failed. Sent message to slack about it.

07/19/2022
	
	Notes working on Cha SSL:
		Re-ran SPAdes for 1, 2 and 3
		Recorded quast report for all libs
		Got BUSCO to run for all individual libraries
		
	Worked on paper- found sources that contradict hypothesis, took notes on them
	
07/20/2022

	Notes working on Cha SSL:
		SPAdes for 2 and 3 ran successfuly- marked as B/C
		Scaffolds and contigs results from BUSCO for all libs exist, Brendan ran contigs as test. Recorded info in readme
		Updating readme files (took down notes on computer while permission issues were not letting me save in readme)
		Organized Cha directory
		Rsync'd all quast reports onto personal desktop
		Added quast results to step 4 table in Cha readme
		Submitted contigs for B (batch job 775394) and scaffolds for B (batch job 775404)
		Submitted contigs for C (batch job 775407) and scaffolds for C (batch job 775408)
		Need to re-run SPAdes for 1st library (A)

07/25/2022

	Notes working on Cha SSL:
		Something went wrong with running SPADES for A, re-running

07/26/2022
	
	Notes working on Cha SSL:
		Busco is done for all now, filling out table
		Updated table with QUAST info
		Used excel custom sort to find best library: AllLibs
		Running contam for All Libs


07/27/2022
	
	Notes working on Cha SSL:
	
		Checked in on Cha, job from yesterday is still running
		Job finished (AllLibs contam)
		Running Busco for allLibs contam

07/28/2022

	Notes working on Cha SSL:
		Busco ran for contam contigs
		filling out table for species
		confirmed that contam beats decontam
		best assembly to use contaminated data is still allLibs
		the BUSCO is the best we are going to get, even though it is low (23%)
		copied scaffolds.fasta into main directory
		
	

07/29/2022

	

07/30/2022

	

08/12/2022

	Gathered results for presentation
	Finialized presentation powerpoint
	Gave presentation at 17:00 meeting
	
08/15/2022

	Forwarded current draft of manuscript to Dr. Pinsky, Dr. Reid, and Kyra Fitz
	Worked on readmes
	



