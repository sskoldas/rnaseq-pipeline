#!/usr/bin/env nextflow

process TRIM_GALORE {
    conda "trim-galore=0.6.10"
    container "community.wave.seqera.io/library/trim-galore:0.6.10--1bf8ca4e1967cd18"
    publishDir "results/trim_galore", mode: 'copy'

    input:
    path reads

    output:
    path "${reads.simpleName}_trimmed.fq.gz"            , emit: trimmed_reads
    path "${reads}_trimming_report.txt"                 , emit: trimming_report
    path "${reads.simpleName}_trimmed_fastqc.{zip,html}", emit: fastqc_reports

    script:
    """
    trim_galore --fastqc $reads
    """
}