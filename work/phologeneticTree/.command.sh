#!/bin/bash -ue
raxmlHPC-PTHREADS -T 4 -s aligned_sequences.fasta -n bestTree -m GTRGAMMA -p 12345
