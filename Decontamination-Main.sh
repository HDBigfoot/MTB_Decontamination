#!/bin/bash

DATABASE_PATH="/home/tbwg/Documents/BioInfoTools/Kraken2/"
KRAKENTOOLS_PATH="/home/tbwg/Documents/BioInfoTools/KrakenTools"
STANDARD_PATH="/Storage/Data_DNA/Global_Dataset/Amsterdam/Run01"
File="/Storage/Data_DNA/Global_Dataset/Amsterdam/Amsterdam_list.txt"
Lines=$(cat $File)
for i in $Lines
    do
    fastp -i /Storage/Data_DNA/Global_Dataset/Amsterdam/Amsterdam/${i}_1.fastq.gz -I /Storage/Data_DNA/Global_Dataset/Amsterdam/Amsterdam/${i}_2.fastq.gz -o ${STANDARD_PATH}/Trimmed/${i}_R1_fastp.fastq.gz -O ${STANDARD_PATH}/Trimmed/${i}_R2_fastp.fastq.gz --length_required 50 --html ${STANDARD_PATH}/Trimmed/${i}.fastp.html
    kraken2 --db ${DATABASE_PATH} --report ${STANDARD_PATH}/Kraken2/${i}.kraken2.report.txt --output ${STANDARD_PATH}/Kraken2/${i}.kraken2.output.txt --paired ${STANDARD_PATH}/Trimmed/${i}_R1_fastp.fastq.gz ${STANDARD_PATH}/Trimmed/${i}_R2_fastp.fastq.gz
    python ${KRAKENTOOLS_PATH}/extract_kraken_reads.py -k ${STANDARD_PATH}/Kraken2/${i}.kraken2.output.txt -s ${STANDARD_PATH}/Trimmed/${i}_R1_fastp.fastq.gz -o ${STANDARD_PATH}/Decontamination/${i}_R1.decon.fastq -t 77643 --fastq-output
    python ${KRAKENTOOLS_PATH}/extract_kraken_reads.py -k ${STANDARD_PATH}/Kraken2/${i}.kraken2.output.txt -s ${STANDARD_PATH}/Trimmed/${i}_R2_fastp.fastq.gz -o ${STANDARD_PATH}/Decontamination/${i}_R2.decon.fastq -t 77643 --fastq-output
    gzip ${STANDARD_PATH}/Decontamination/${i}_R1.decon.fastq
    gzip ${STANDARD_PATH}/Decontamination/${i}_R2.decon.fastq
    done
