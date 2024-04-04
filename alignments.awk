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
                                                       END {printf("\n");}' "${i}" > "${i%.*}.new.fasta;
done
for i in $(cat sample.gff | awk 'NR > 2 { print $1"\t"$3"\t"$4"\t"$5 }' | 
        awk '{ print $3 }'); for j in $(cat sample.gff | awk 'NR > 2 
                          { print $1"\t"$3"\t"$4"\t"$5 }' | awk '{ print $4 }'); 
                                 do echo "cat gen.fa | awk '{ print substr(echo$($1),$i,$j) }'"; 
done | sed "s/echo/"\$1"/g"
} END >> writeawkclassifier.sh
