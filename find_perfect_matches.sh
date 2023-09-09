#! /bin/bash
queryFile="$1"
subjectFile="$2"
outputFile="$3"
blastn -query "$queryFile" -subject "$subjectFile" -task blastn-short -outfmt "6 std sseq" -perc_identity 100 -out "$outputFile"
queryLength=$(awk '/^>/ {next} {seq = seq $0} END {print length(seq)}' "$queryFile")
awk -F"\t" '{if ($4 == '"$queryLength"') print}' "$outputFile" > "${outputFile}_sameLength"
perfectMatchCount=$(wc -l < "${outputFile}_sameLength")
echo "Perfect Matches: $perfectMatchCount"
