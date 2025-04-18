#!/bin/bash

#SBATCH --job-name=kraken2-alignment
#SBATCH -o kraken2-alignment.out
#SBATCH --nodes=1
#SBATCH -t 4:00:00
#SBATCH --cpus-per-task=10
#SBATCH --mem=110G

cd $SLURM_SUBMIT_DIR
set -uex

# Record the start time
start_time=$(date)

# Activate Kraken2 environment
module load mamba
eval "$(conda shell.bash hook)"
conda activate /home/aghall3/miniconda3/envs/kraken2
cd /scratch/aghall3/Bio440_MEandCFS_Microbiome_Study

#Set the database to be used for alignment
DB_PATH="/scratch/aghall3/kraken_db/standard"

cat samplenames.txt | while read samples ; do kraken2 --db /scratch/aghall3/kraken_db/standard --paired ${samples}_1.fastq.gz ${samples}_2.fastq.gz --gzip-compressed --threads 10 --report "${samples}_kraken2.report" --output "${samples}_kraken2.output" ; done
