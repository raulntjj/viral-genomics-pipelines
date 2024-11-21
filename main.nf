#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.input = "data/"  // Diretório onde os arquivos FASTA estão localizados
params.output = "results"  // Diretório de saída para os resultados

process align_sequences {
    tag "Alignment"

    memory '3.5 GB'  // Limite de 4 GB de RAM
    cpus 4         // Uso de 4 threads/CPUs

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

    memory '3.5 GB'  // Limite de 4 GB de RAM
    cpus 4         // Uso de 4 threads/CPUs

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
