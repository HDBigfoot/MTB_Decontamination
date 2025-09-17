#!/usr/bin/env nextflow

params.sample_name = "Sample"
params.outdir = "Results"

log.info """
Filter out non-MTB reads
RC3ID
Universitas Padjadjaran
================================
sample     : $params.sample_name
reads      : $params.raw_read1 & $params.raw_read2
outdir     : $params.outdir
databse    : $params.database
================================
"""

include { Decontamination } from './modules/Decontamination.nf'

workflow {

    sampleName_ch = Channel.of(params.sample_name)
    rawRead1_ch = Channel.fromPath(params.raw_read1)
    rawRead2_ch = Channel.fromPath(params.raw_read2)
    database_ch = Channel.fromPath(params.database)

    Decontamination(sampleName_ch, raw_read1_ch, raw_read2_ch, database_ch)

}
