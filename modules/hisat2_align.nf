#!/usr/bin/env nextflow

process HISAT2_ALIGN {

    conda "hisat2=2.2.1 samtools=1.20"
    container 'community.wave.seqera.io/library/hisat2_samtools:6be64e12472a7b75'
    publishDir "results/align", mode: 'copy'

    input:
    tuple path(reads), path(index_zip)

    output:
    path "${reads.simpleName}.bam"       , emit: bam
    path "${reads.simpleName}.hisat2.log", emit: log

    script:
    """
    tar -xzvf $index_zip
    hisat2 -x ${index_zip.simpleName} -U $reads --new-summary --summary-file ${reads.simpleName}.hisat2.log | \
        samtools view -bS -o ${reads.simpleName}.bam 
    """
}