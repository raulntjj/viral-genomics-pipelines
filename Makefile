build:
	- docker compose up -d

kill:
	- docker stop bioinformatics_pipeline
	- docker rm bioinformatics_pipeline
	- docker system prune -af --volumes

run:
	@echo "Starting Nextflow pipeline..."
	@start_time=$$(date +%s); \
	nextflow run main.nf; \
	end_time=$$(date +%s); \
	elapsed_time=$$(($$end_time - $$start_time)); \
	echo "Pipeline completed in $$elapsed_time seconds."

get-genomes:
	- mkdir -p data && cd data && esearch -db nucleotide -query "SARS-CoV-2 complete genome" | efetch -format fasta > sequences.fasta

get-delta-genomes:
	- mkdir -p data && cd data && esearch -db nucleotide -query "SARS-CoV-2 complete genome AND Delta" | efetch -format fasta > delta_sequences.fasta

get-omicron-genomes:
	- mkdir -p data && cd data && esearch -db nucleotide -query "SARS-CoV-2 complete genome AND Omicron" | efetch -format fasta > omicron_sequences.fasta

merge-strain-genomes:
	- cd data && cat delta_sequences.fasta omicron_sequences.fasta  > sequences.fasta

get-usa-genomes:
	- mkdir -p data && cd data && esearch -db nucleotide -query "SARS-CoV-2 complete genome AND USA" | efetch -format fasta > usa_sequences.fasta

get-brazil-genomes:
	- mkdir -p data && cd data && esearch -db nucleotide -query "SARS-CoV-2 complete genome AND Brazil" | efetch -format fasta > brazil_sequences.fasta

merge-country-genomes:
	- cd data && cat usa_sequences.fasta brazil_sequences.fasta  > sequences.fasta

view:
	- docker exec -it bioinformatics_pipeline figtree results/RAxML_bestTree.bestTree
