# Decontamination Script

A script that uses Kraken2 to identify contaminants in a fastq file and filter out all reads not identified as Mycobacterium tuberculosis (Written for troubleshooting and quality control). 

### Requirements

- **Conda**
- **Nextflow**
- **Kraken2/Bracken Refseq Indexes <https://benlangmead.github.io/aws-indexes/k2>**

## Installation

Clone this repository:

```bash
git clone https://github.com/HDBigfoot/MTB_Decontamination.git
```

## Usage

Running main pipeline:

```bash
nextflow run /PATH/TO/PROJECT/MTB_Decontamination/Decontamination-main.nf --raw_read1 /PATH/TO/RAW/READS/<sample_name>_1.fastq.gz --raw_read2 /PATH/TO/RAW/READS/<sample_name>_1.fastq.gz --sample_name <sample_name> --outdir <outdir> --database  /PATH/TP/KRAKEN2/REFSEQ/INDEX/
```
## References

Kraken2:
> Wood, D.E., Lu, J. & Langmead, B. Improved metagenomic analysis with Kraken 2. Genome Biol 20, 257 (2019). <https://doi.org/10.1186/s13059-019-1891-0>

KrakenTools:
> Lu, J., Rincon, N., Wood, D.E. et al. Metagenome analysis using the Kraken software suite. Nat Protoc 17, 2815–2839 (2022). <https://doi.org/10.1038/s41596-022-00738-y>
