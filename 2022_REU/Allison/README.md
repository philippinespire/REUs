<b>Allison's Readme</b>
---

Notes:

/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison

rsync afink007@wahab.hpc.odu.edu:/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq/fastqc_report.html .
---

07/08/2022

	First introduction draft completed

07/11/2022

	Readme created

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

	Still have permission error for pushing

	Got MultiQC to run

	/home/e1garcia/shotgun_PIRE/pire_fq_gz_processing/Multi_FASTQC.sh "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq" "fq.gz"
	
	Ran Fastqp

        Multi_FastQC.sh successfuly run, html file copied to personal computer
        
		/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/shotgun_raw_fq/fastqc_report.html   

07/18/2022

	Getting over jetlag. Checked on jobs set before leaving the Philippines. No jobs were still running on wahab or turing.

	Recorded data from quast output for all libs

	Running BUSCO failed. Sent message to slack about it.

07/19/2022

	Re-ran SPAdes for 1, 2 and 3

	Recorded quast report for all libs
	
	Worked on paper- found sources that contradict hypothesis, took notes on them
	
	Got BUSCO to run for all individual libraries

07/20/2022
	
	SPAdes for 2 and 3 ran successfuly- marked as B/C
	
	Scaffolds and contigs results from BUSCO for all libs exist, Brendan ran contigs as test. Recorded info in readme
	
	Updating readme files (took down notes on computer while permission issues were not letting me save in readme)
	
	Organized Cha directory
	
	Rsync'd all quast reports onto personal desktop

	Added quast results to step 4 table in Cha readme

	Submitted contigs for B (batch job 775394) and scaffolds for B (batch job 775404)
	
	Submitted contigs for C (batch job 775407) and scaffolds for C (batch job 775408)

	Need to re-run SPAdes for 1st library (A), code:

							sbatch /home/e1garcia/shotgun_PIRE/pire_ssl_data_processing/scripts/runSPADEShimem_R1R2_noisolate.sbatch "afink007" "Cha" "1" "decontam" "342000000" "/home/e1garcia/shotgun_PIRE/REUs/2022_REU/Allison/corythoichthys_haematopterus/" "fq_fp1_clmp_fp2_fqscrn_repaired" 
	
	



