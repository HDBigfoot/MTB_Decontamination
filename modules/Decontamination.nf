#!/usr/bin/env nextflow

process Decontamination {

    conda 'kraken2 krakentools'


    publishDir params.outdir + "/Decontamination", mode: 'copy', saveAs: { filename -> if (filename.endsWith("R1.decon.fastq.gz")) {"${sampleName}_R1.decon.fastq.gz"}
                                                                   else if (filename.endsWith("R2.decon.fastq.gz")) {"${sampleName}_R2.decon.fastq.gz"}
                                                                   else if (filename.endsWith(".report.txt")) {"${sampleName}.report.txt"}}


    input:
        val sampleName
        path rawRead1
        path rawRead2
        path database

    output:
        path "${rawRead1}_R1.decon.fastq.gz", emit: decon_R1
        path "${rawRead2}_R2.decon.fastq.gz", emit: decon_R2
        path "${sampleName}.report.txt"

    script:
    """
    kraken2 --db ${database} --report ${sampleName}.kraken2.report.txt --output ${sampleName}.kraken2.output.txt --paired ${rawRead1} ${rawRead2}
    python ${projectDir}/KrakenTools/extract_kraken_reads.py -k ${sampleName}.kraken2.output.txt -s ${rawRead1} -o ${rawRead1}_R1.decon.fastq -t 77643 --fastq-output
    python ${projectDir}/KrakenTools/extract_kraken_reads.py -k ${sampleName}.kraken2.output.txt -s ${rawRead2} -o ${rawRead2}_R2.decon.fastq -t 77643 --fastq-output
    gzip ${rawRead1}_R1.decon.fastq
    gzip ${rawRead2}_R2.decon.fastq
    """

}
