# hashing-awk
- awk function using the sbstr for the genome extraction
- can be used for the genome annotations and subsequence extractions.
- stores the sequences as indexed arrays using pattern matching.
  
run the protein alignments as
```
# if your fasta is multiline formatted then run this before running the alignments.
# it is included in the hashing_awk by default.
for i in "${directory}"/*.fasta;
do 
     awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  \
                                                     END {printf("\n");}' ${i} > "${i%.*}.new.fasta;
done
miniprot --gff genome.fasta protein.fasta > alignment.gff

# actually i wrote a fast fasta conversion, you have a folder of the minprot alignment 
#	and you have to generate the correponding fasta ids then see below 
# this will generate all the fasta headers for the aligned regions for the mRNA.

for i in *.gff; \
     do
	   cat "${i}" | grep "mRNA" | sed "s/\t/|/g" \
		       | cut -f 1,2,3 -d "|" | cut -f 2 -d "|" \
				                 | awk '{ print ">"$1 }' \
     done

# reading the directory path fasta files and storing as a variable
# shortened version. invoking a loop directly over the awk rather than storing and genrating the
# awk classifier
# after this simply run the 
directory="FILEPATH"
for i in "${directory}"/*.fasta;
do 
       awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  \
                                                       END {printf("\n");}' "${i}" > "${i%.*}.new.fasta;
done
for i in $(cat sample.gff | awk 'NR > 2 { print $1"\t"$3"\t"$4"\t"$5 }' | \
          awk '{ print $3 }'); do for j in $(cat sample.gff | awk 'NR > 2 { print $1"\t"$3"\t"$4"\t"$5 }' \
                      | awk '{ print $4 }'); do; echo "making awk"; done; \
                                    echo "cat gen.fa | awk '{ print substr(echo$($1),$i,$j) }'"; \
                                                                 done | sed "s/echo/"\$1"/g"  | grep "^cat"
} END >> writeawkclassifier.sh

```
Gaurav Sablok \
Academic Staff Member \
Bioinformatics \
Institute for Biochemistry and Biology \
University of Potsdam \
Potsdam,Germany  
