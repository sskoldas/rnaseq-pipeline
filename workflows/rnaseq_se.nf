#!/usr/bin/env nextflow

// Module include statements
include { FASTQC } from '../modules/fastqc.nf'
include { TRIM_GALORE } from '../modules/trim_galore.nf'
include { HISAT2_BUILD } from '../modules/hisat2_build.nf'
include { HISAT2_ALIGN } from '../modules/hisat2_align.nf'
include { MULTIQC } from '../modules/multiqc.nf'


/*
 * Pipeline parameters
 */

// Primary input
params.input_csv = "data/single-end.csv"
params.genome = "data/genome.fa"
params.report_id = "all_single-end"


workflow {
    // Create input channel from a file path
    read_ch = Channel.fromPath(params.input_csv)
        .splitCsv(header:true)
        .map { row -> file(row.fastq_path)}

    genome_ch = Channel.fromPath(params.genome)

    // Inital quality control
    FASTQC(read_ch)
    // Adapter trimming and post-trimming QC
    TRIM_GALORE(read_ch)
    // Build index from reference genome
    HISAT2_BUILD(genome_ch)
    // Pair every trimmed read with the single index artifact
    reads_with_index = TRIM_GALORE.out.trimmed_reads.combine(HISAT2_BUILD.out.index_zip)
    // Align reads to the reference genome
    HISAT2_ALIGN(reads_with_index)
    // Comprehensive QC report generation
    MULTIQC(
        FASTQC.out.zip.mix(
        FASTQC.out.html,
        TRIM_GALORE.out.trimming_report,
        TRIM_GALORE.out.fastqc_reports,
        HISAT2_ALIGN.out.log).collect(), params.report_id
    )

}
