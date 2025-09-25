#!/usr/bin/env nextflow

process HISAT2_ALIGN {

    conda "hisat2=2.2.1 samtools=1.20"
    container 'community.wave.seqera.io/library/hisat2_samtools:6be64e12472a7b75'
    publishDir "results/align", mode: 'copy'

    input:
    tuple path(read1), path(read2)
    path index_zip

    output:
    path "${read1.simpleName}.bam", emit: bam
    path "${read1.simpleName}.hisat2.log", emit: log

    script:
    """
    tar -xzvf $index_zip
    hisat2 -x ${index_zip.simpleName} -1 ${read1} -2 ${read2} \
        --new-summary --summary-file ${read1.simpleName}.hisat2.log | \
        samtools view -bS -o ${read1.simpleName}.bam
    """
}