#!/usr/bin/env nextflow

process Decontamination {

    conda 'fastp'


    publishDir params.outdir + "/Decontamination", mode: 'copy', saveAs: { filename -> if (filename.endsWith("1_fastp.fastq.gz")) {"${sampleName}_1_fastp.fastq.gz"}
                                                                   else if (filename.endsWith("2_fastp.fastq.gz")) {"${sampleName}_2_fastp.fastq.gz"}
                                                                   else if (filename.endsWith("html")) {"${sampleName}.fastp.html"}}


    input:
        val sampleName
        path fastp_R1
        path fastp_R2

    output:
        path "${rawRead1}_fastp.fastq.gz", emit: fastp_R1
        path "${rawRead2}_fastp.fastq.gz", emit: fastp_R2
        path "${rawRead1}.fastp.html"

    script:
    """
    kraken2 --db ${database} --report ${sampleName}.kraken2.report.txt --output ${sampleName}.kraken2.output.txt --paired ${fastp_R1} ${fastp_R2}
    python
    """

}
