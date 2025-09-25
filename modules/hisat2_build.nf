#!/usr/bin/env nextflow

process HISAT2_BUILD {
    conda "hisat2=2.2.1"
    container 'community.wave.seqera.io/library/hisat2_samtools:6be64e12472a7b75'
    publishDir "data", mode: 'copy'
    
    input: 
    path genome

    output:
    path "genome_index.tar.gz", emit: index_zip

    script:
    """
    hisat2-build $genome genome_index
    tar -czvf genome_index.tar.gz genome_index.*.ht2
    """
}