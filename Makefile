build:
	- docker compose up -d

kill:
	- docker stop bioinformatics_pipeline
	- docker rm bioinformatics_pipeline
	- docker system prune -af --volumes

run:
	- docker exec -it bioinformatics_pipeline nextflow run main.nf

bash:
	- docker exec -it bioinformatics_pipeline bash

get-genomes:
	- docker exec -it bioinformatics_pipeline bash -c "mkdir -p data && cd data && esearch -db nucleotide -query 'SARS-CoV-2 complete genome' | efetch -format fasta > sequences.fasta"

view:
	- docker exec -it bioinformatics_pipeline figtree results/RAxML_bestTree.bestTree
