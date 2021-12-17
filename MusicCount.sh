#!/bin/bash

# Depends
# -------
# bash
#
#
############################################################################
## Defines the output file as:
##    Counts + Seconds Since Epoch (https://en.wikipedia.org/wiki/Unix_time)
##
## Defines an array of possible audio file extensions: $EXTENSIONS
##
## Defines a variable to increment the total number of audio files: $TOTES
## 
############################################
declare -r OUTPUT="Counts $(date +%s).txt"
declare -ar EXTENSIONS=(".3gp" ".aa" ".aac" ".aax" ".act" ".aiff" ".alac" ".amr" ".ape" ".au" ".awb" ".dss" ".dvf" ".flac" \
".gsm" ".iklax" ".ivs" ".m4a" ".m4b" ".m4p" ".mmf" ".mp3" ".mpc" ".msv" ".nmf" ".ogg" ".oga" ".mogg" ".opus" \
".ra" ".rm" ".raw" ".rf64" ".sln" ".tta" ".voc" ".vox" ".wav" ".wv" ".webm" ".8svx" ".cda")
declare TOTES=0
#
# formats column headings for final output
printf "%32s\n" | tr " " - >> "$OUTPUT"
printf "|  Type  |        Count        |\n" >> "$OUTPUT"
printf "%32s\n" | tr " " - >> "$OUTPUT"

# beings display of progress indicator on stdout
printf "%s\r" "Filetypes Counted 0 / ${#EXTENSIONS[@]}"

# for loop iterates through each file extension declared above.
for i in "${!EXTENSIONS[@]}"; do
# creates a variable to store the count of the current filetype, e.g. .aac
  typeCount=$(find ./ -type f -iname "*$(echo "${EXTENSIONS[$i]}")" | wc -l)

# updates progress indicator on stdout
  printf "%s\r" "Filetypes Counted: ${i} / ${#EXTENSIONS[@]}"

# logic to ignore filetypes that return 0 results 
  if [[ "$typeCount" == '0' ]];
   then
    continue
  fi

# increments the total count; this seems less burdensome than using find with 42 "-name '*.xxx'" to get a full count
  let "TOTES+=typeCount"

# records the filetype and the count to the output file, e.g. "".aac: 230"
  printf "|%-7s | %20s|\n" "${EXTENSIONS[$i]}" "${typeCount}" >> "$OUTPUT"
  printf "%32s\n" | tr " " - >> "$OUTPUT"
done

# prints the final tally to the output file
printf "|%-7s | %20s|\n" "Total" "${TOTES}" >> "$OUTPUT"
printf "%32s\n" | tr " " - >> "$OUTPUT"

# Clears stdout
printf "%60.s %s\t\r" ""

# Displays counts of file extensions with non-zero results and total count
cat "./${OUTPUT}"
