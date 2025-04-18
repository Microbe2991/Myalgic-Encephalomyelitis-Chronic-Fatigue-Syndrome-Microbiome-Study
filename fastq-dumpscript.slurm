#!/bin/bash


#SBATCH --job-name=qiime2
#SBATCH -o qiime2-filtering.out
#SBATCH --nodes=1
#SBATCH -t 4:00:00
#SBATCH --cpus-per-task=10
#SBATCH --mem=40G




cd $SLURM_SUBMIT_DIR


set -uex


# Record the start time
start_time=$(date)


# Activate QIIME2 environments
module load mamba
module load mamba/latest
cat samplenames.txt | while read samples ; do fastq-dump --gzip --skip-technical --split-3 $samples ; done

echo "job complete" 
