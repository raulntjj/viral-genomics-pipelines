FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    mafft \
    ncbi-entrez-direct \
    raxml \
    figtree \
    && apt-get clean
