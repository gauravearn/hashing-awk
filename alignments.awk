#!usr/bin/awk -f
# Author Gaurav Sablok
# Universitat Potsdam
# Date 2024-3-27
alignment () BEGIN {
  directory="FILEPATH"
  declare -a filearray=()
  for i in "${directory}"/*.fasta;
     do 
       filearray+=("${i%%.*}"}
     done
 for i in "${filearray[*]}";
    do 
      miniprot -gff "${i}" protein.fasta > "${i}".gff
    done
declare -a ids=()
declare -a startcoordinate=()
declare -a stopcoordinate=()
for i in "${i}".gff;
  do 
    cat "${i}" | grep "mRNA" | awk ' { print $4 }'>> startcoordinate.txt
    cat "${i}" | grep "mRNA" | awk ' { print $4 }'>> stopcoordinate.txt
    cat "${i}" | grep "mRNA" | awk ' { print $1 }'>> ids.txt
 done
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
cat final.fasta | awk '!/^>/ { print $1 } ' > sequences.fasta
cat final.fasta | awk '!/^>/ { print $1 } ' > ids.fasta
paste sequences.fasta startcoordinate.txt stopcoordinate.txt | awk substr( $1, $2, $3) > allsequences.fasta
} END 
