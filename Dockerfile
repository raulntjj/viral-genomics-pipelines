FROM ubuntu:22.04

# Configuração do ambiente
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

# Instalação das ferramentas necessárias
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    mafft \
    ncbi-entrez-direct \
    raxml \
    figtree \
    openjdk-11-jre-headless \
    git \
    && curl -fsSL https://get.nextflow.io | bash && \
    mv nextflow /usr/local/bin/ && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /var/www/

# Configuração do comando padrão
CMD ["bash"]
