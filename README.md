# hashing-awk
i previously wrote this in C++ (which i dont write anymore) and also in python and R but if you want to see a awk version, so you can try this. You input directory file should be a single line formatted for the same. I will check this tonight for the final version release along with the test samples. specifically wrote for a project but can be implemented on anything. extracts using the ```substr``` and dont even have to cache load the file and it read io directly. adding the sample files for the analysis. some fasta files, some alignments so that this function can be invoked. 

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

# actually i wrote a fast fasta conversion, you have a folder of the minprot alignment \
#	and you have to generate the correponding fasta ids then see below \
# this will generate all the fasta headers for the aligned regions for the mRNA.

for i in *.gff; \
     do
	   cat "${i}" | grep "mRNA" | sed "s/\t/|/g" \
		       | cut -f 1,2,3 -d "|" | cut -f 2 -d "|" \
				                 | awk '{ print ">"$1 }' \
     done
```
Gaurav Sablok \
Academic Staff Member \
Bioinformatics \
Institute for Biochemistry and Biology \
University of Potsdam \
Potsdam,Germany  
