#!/usr/bin/env nextflow

process Decontamination {

    conda 'kraken2 krakentools'


    publishDir params.outdir + "/Decontamination", mode: 'copy', saveAs: { filename -> if (filename.endsWith("1_fastp.fastq.gz")) {"${sampleName}_1_fastp.fastq.gz"}
                                                                   else if (filename.endsWith("2_fastp.fastq.gz")) {"${sampleName}_2_fastp.fastq.gz"}
                                                                   else if (filename.endsWith("html")) {"${sampleName}.fastp.html"}}


    input:
        val sampleName
        path rawRead1
        path rawRead2

    output:
        path "${rawRead1}.decon.fastq.gz", emit: decon_R1
        path "${rawRead2}.decon.fastq.gz", emit: decon_R2
        path "${sampleName}.report.txt"

    script:
    """
    kraken2 --db ${database} --report ${sampleName}.kraken2.report.txt --output ${sampleName}.kraken2.output.txt --paired ${rawRead1} ${rawRead2}
    python ${projectDir}/KrakenTools/extract_kraken_reads.py -k ${sampleName}.kraken2.output.txt -s ${rawRead1} -o ${rawRead1}.decon.fastq -t 77643 --fastq-output
    python ${projectDir}/KrakenTools/extract_kraken_reads.py -k ${sampleName}.kraken2.output.txt -s ${rawRead2} -o ${rawRead2}.decon.fastq -t 77643 --fastq-output
    gzip ${rawRead1}.decon.fastq
    gzip ${rawRead2}.decon.fastq
    """

}
