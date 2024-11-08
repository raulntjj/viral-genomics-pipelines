#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process align_sequences {
    tag "Alignment"

    input:
    path fasta

    output:
    path "aligned_sequences.fasta"

    publishDir "${params.output}/alignment", mode: 'copy'

    script:
    """
    mafft --auto ${fasta} > aligned_sequences.fasta
    """
}

process build_phylo_tree {
    tag "Phylogenetic Tree"

    input:
    path aligned

    output:
    path "RAxML_bestTree.*"

    publishDir "${params.output}/phylogenetics", mode: 'copy'

    script:
    """
    raxmlHPC -s ${aligned} -n bestTree -m GTRGAMMA -p 12345
    """
}

workflow {
    // Cria o canal para o arquivo FASTA de entrada
    fasta_ch = Channel.fromPath("${params.input}/sequences.fasta")

    // Executa os processos em sequência
    aligned_ch = align_sequences(fasta_ch)
    build_phylo_tree(aligned_ch)
}
