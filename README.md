
# Viral Genomics Pipelines

Este repositório contém um pipeline de bioinformática projetado para o processamento de dados genômicos de SARS-CoV-2. Ele permite a coleta de genomas, alinhamento de sequências, construção de árvores filogenéticas, e visualização de resultados utilizando **Nextflow**, Docker, e ferramentas de bioinformática como **MAFFT**, **RAxML**, e **FigTree**.

---

## **Requisitos**
Certifique-se de ter as seguintes ferramentas instaladas:
- **Docker** (versão 20.10 ou superior)
- **Docker Compose** (versão 2.0 ou superior)
- **Make** (para automação de comandos)

---

## **Configuração**
1. Clone este repositório em sua máquina local:
   ```bash
   git clone https://github.com/seu-usuario/bioinformatics-pipeline.git
   cd bioinformatics-pipeline
   ```

2. Inicie os containers Docker para configurar o ambiente:
   ```bash
   make build
   ```

3. Acesse o container (opcional, para verificar ferramentas instaladas):
   ```bash
   docker exec -it bioinformatics_pipeline bash
   ```

---

## **Como Usar**

### 1. Coleta de Genomas
Utilize os comandos abaixo para coletar dados genômicos. Eles usarão o NCBI Entrez Direct para baixar sequências em formato FASTA:

- **Coletar genomas completos do SARS-CoV-2:**
  ```bash
  make get-genomes
  ```

- **Coletar genomas da variante Delta:**
  ```bash
  make get-delta-genomes
  ```

- **Coletar genomas da variante Omicron:**
  ```bash
  make get-omicron-genomes
  ```

- **Coletar genomas dos EUA:**
  ```bash
  make get-usa-genomes
  ```

- **Coletar genomas do Brasil:**
  ```bash
  make get-brazil-genomes
  ```

- **Mesclar genomas de diferentes origens:**
  ```bash
  make merge-country-genomes
  ```

---

### 2. Executar o Pipeline
Para alinhar as sequências e construir a árvore filogenética:
```bash
make run
```
O tempo de execução será exibido no terminal ao término do pipeline.

---

### 3. Visualizar Resultados
Para visualizar a árvore filogenética gerada:
```bash
make view
```
Isso abrirá a árvore em **FigTree** dentro do container.

---

## **Estrutura do Projeto**

```plaintext
.
├── data/                       # Diretório para arquivos de entrada (genomas)
├── results/                    # Diretório para arquivos de saída
├── main.nf                     # Arquivo principal do pipeline Nextflow
├── Dockerfile                  # Configuração para o container Docker
├── docker-compose.yml          # Configuração do Docker Compose
├── Makefile                    # Automação de comandos
└── README.md                   # Documentação do projeto
```

---

## **Explicação Técnica**

- **Nextflow Workflow (`main.nf`):**
  - **align_sequences:** Realiza o alinhamento de múltiplas sequências usando o **MAFFT**.
  - **build_phylo_tree:** Constrói a árvore filogenética usando o **RAxML**.

- **Docker Setup:**
  - O ambiente Docker contém todas as ferramentas necessárias para o pipeline, evitando conflitos de dependências.

- **Makefile:**
  - Fornece comandos simples para tarefas comuns, como coleta de genomas, execução do pipeline, e visualização de resultados.

---

## **Limpeza do Ambiente**
Para parar e limpar os containers e volumes criados:
```bash
make kill
```
