#!/usr/bin/env nextflow

process MULTIQC {
    conda "multiqc=1.31"
    container "community.wave.seqera.io/library/multiqc:1.31--1efbafd542a23882"
    publishDir "results/multiqc", mode: 'copy'

    input:
    path '*'
    val output_name

    output:
    path "${output_name}.html", emit: report
    path "${output_name}_data", emit: data

    script:
    """
    multiqc . -n ${output_name}.html
    """
}