#!usr/bin/awk -f
# Author Gaurav Sablok
# Universitat Potsdam
# Date 2024-3-27
alignment () BEGIN {
# reading the directory path fasta files and storing as a variable 
directory="FILEPATH"
for i in "${directory}"/*.fasta;
do 
  awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  \
                                                   END {printf("\n");}' "${i%.*}.new.fasta;
done
declare -a filearray=()
  for i in "${directory}"/*.new.fasta;
     do 
       filearray+=("${i%%.}"}
     done
 for i in "${filearray[*]}";
    do 
      miniprot -gff "${i}.fasta" protein.fasta > "${i}".gff
    done
# getting the ids and the start and the stop coordinates from the alignments
declare -a ids=()
declare -a startcoordinate=()
declare -a stopcoordinate=()
for i in "${i}".gff;
  do 
    cat "${i}" | grep "mRNA" | awk ' { print $4 }'>> startcoordinate.txt
    cat "${i}" | grep "mRNA" | awk ' { print $5 }'>> stopcoordinate.txt
    cat "${i}" | grep "mRNA" | awk ' { print $1 }'>> ids.txt
 done
# making an indexed array, this step i can reduce further 
cat startcoordinate.txt | while read line; 
  do 
    startcoordinate+=("${line}")
  done
cat stopcoordinate.txt | while read line;
  do 
    stopcoordinate+=("${line}")
  done
cat stopcoordinate.txt | while read line;
  do 
    stopcoordinate+=("${line}")
  done
cat ids.txt | while read line; 
  do 
      grep "${line}" *.fasta | cut -f 2 -d ":" | cut -f 2 -d "-" >> final.fasta
  done
# spliting the single line fasta into two stetches one with the ids and one with the sequences, 
# so that the sequences at single line can be taken as a string
cat final.fasta | awk '!/^>/ { print $1 } ' > sequences.fasta
cat final.fasta | awk '/^>/ { print $1 } ' > ids.fasta
paste sequences.fasta startcoordinate.txt stopcoordinate.txt | awk substr( $1, $2, $3) > allsequences.fasta
} END 
