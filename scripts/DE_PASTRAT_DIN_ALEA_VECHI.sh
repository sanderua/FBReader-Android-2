#!/bin/bash
# list_which_does_not_exist_in_new_list
# Aceste carti le aveam si in vers. anterioara, si trebuiesc tinute 
# pentru ca nu au un echivalent. 
# Ele vor trebui si corectate (textul) in caz ca au probleme.
BOOK_TYPE=Acatiste
cd _PRELUCRARE_EPUBss/${BOOK_TYPE}/
OUT_FILE=${BOOK_TYPE}_DE_PASTRAT_DIN_ALEA_VECHI.txt

mv $OUT_FILE ${OUT_FILE}.old 2>/dev/null || true 
#for x in `cat old`; do
while read x; do
  echo "processing: $x" 1>&2
  grep "$x" old_epub/*.old_epub >/dev/null
  FOUND=$(find old_epub -type f -name "*.old_epub" -exec grep -l "$x" {} \;)
  if [[ -z $FOUND ]]; then
    echo "DE PASTRAT:" 1>&2
    echo "$x" | tee -a $OUT_FILE
  # else
  #   echo "$x - ei il au"
  fi
  # sleep 1
done < old_dup_removed


