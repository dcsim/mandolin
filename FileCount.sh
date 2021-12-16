#!/bin/bash

# Depends
# -------
# bash

declare OUTPUT="Metrics $(date +%s).txt"
weCount=(".3gp" ".aa" ".aac" ".aax" ".act" ".aiff" ".alac" ".amr" ".ape" ".au" ".awb" ".dss" ".dvf" ".flac" ".gsm" ".iklax" ".ivs" ".m4a" ".m4b" ".m4p" ".mmf" ".mp3" ".mpc" ".msv" ".nmf" ".ogg" ".oga" ".mogg" ".opus" ".ra" ".rm" ".raw" ".rf64" ".sln" ".tta" ".voc" ".vox" ".wav" ".wv" ".webm" ".8svx" ".cda")
echo ""
for str in ${weCount[@]}; do
  echo "$str: $(find ./ -type f -name "*$(echo "$str")" | wc -l)" | tee -a "$OUTPUT"
done




