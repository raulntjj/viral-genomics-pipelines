#!/bin/bash -ue
mafft --thread 4 --auto sequences.fasta > aligned_sequences.fasta
