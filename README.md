# RNA-seq Mini Pipeline (Nextflow DSL2)

A lightweight, modular RNA-seq pipeline built in **Nextflow DSL2** for demonstration purposes. It implements a standard short-read RNA-seq workflow with both **single-end** and **paired-end** support:

- **Quality control** with [FASTQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- **Adapter trimming** with [Trim Galore](https://www.bioinformatics.babraham.ac.uk/projects/trim_galore/)
- **Genome index building** with [HISAT2](https://daehwankimlab.github.io/hisat2/)
- **Read alignment** with HISAT2 + [Samtools](http://www.htslib.org/)
- **Comprehensive QC reports** with [MultiQC](https://multiqc.info/)

The pipeline demonstrates best practices in workflow development: **modular design, docker/conda reproducibility, profiles, and automated reporting**.

---

## 📂 Repository structure

```
rnaseq-pipeline/
├── data/ # Example CSVs and small demo inputs
├── modules/ # Nextflow DSL2 processes (FastQC, Trim Galore, HISAT2, MultiQC)
├── workflows/ # Entry scripts (rnaseq_se.nf, rnaseq_pe.nf)
├── nextflow.config # Profiles and reproducibility settings
└── README.md
```

---

## 🔧 Installation

Requirements:

- [Nextflow ≥ 22](https://www.nextflow.io/docs/latest/getstarted.html)
- Either: Conda/Docker [Seqera Wave](https://seqera.io/wave/)

Clone the repo:

```bash
git clone https://github.com/sskoldas/rnaseq-pipeline.git
cd rnaseq-pipeline
```

---

## 🚀 Usage

Single-end data:

```bash
nextflow run workflows/rnaseq_se.nf -profile standard
nextflow run workflows/rnaseq_se.nf -profile docker
```

Paired-end data:

```bash
nextflow run workflows/rnaseq_pe.nf -profile standard
nextflow run workflows/rnaseq_pe.nf -profile docker
```
