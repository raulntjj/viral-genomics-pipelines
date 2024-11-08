run:
	- nextflow run main.nf

get-genomes:
	- esearch -db nucleotide -query "SARS-CoV-2 complete genome" | efetch -format fasta > reference.fasta

view:
	- figtree results/RAxML_bestTree.bestTree