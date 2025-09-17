#!/usr/bin/env nextflow

params.sample_name = "Sample"
params.outdir = "Results"

log.info """
Pipeline_12 - Analysis pipeline for detecting unfixed variants in Mycobacterium tuberculosis
RC3ID
Universitas Padjadjaran
================================
sample     : $params.sample_name
reads      : $params.raw_read1 & $params.raw_read2
outdir     : $params.outdir
databse    : $params.database
================================
"""

include { Trimming } from './modules/Trimming.nf'
include { Decontamination } from './modules/Decontamination.nf'

workflow {

    sampleName_ch = Channel.of(params.sample_name)
    rawRead1_ch = Channel.fromPath(params.raw_read1)
    rawRead2_ch = Channel.fromPath(params.raw_read2)
    database_ch = Channel.fromPath(params.database)

    Trimming(sampleName_ch, rawRead1_ch, rawRead2_ch)
    Decontamination(sampleName_ch, Trimming.out.fastp_R1, Trimming.out.fastp_R2, database_ch)
    Mapping(sampleName_ch, Trimming.out.fastp_R1, Trimming.out.fastp_R2, ref_file, ref_index_file, ref_dict_file)

}
