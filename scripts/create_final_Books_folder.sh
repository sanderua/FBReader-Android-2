#!/bin/bash
### Generic preps:
MERGED_FINAL_BOOKS_DIR=_PRELUCRARE_EPUBss/_Books_FINAL
rm -rf ${MERGED_FINAL_BOOKS_DIR}.old.old/ || true
mv ${MERGED_FINAL_BOOKS_DIR}.old ${MERGED_FINAL_BOOKS_DIR}.old.old || true
mv ${MERGED_FINAL_BOOKS_DIR} ${MERGED_FINAL_BOOKS_DIR}.old || true
mkdir -p ${MERGED_FINAL_BOOKS_DIR}

############################################
### Acatiste (cea mai complicata parte)
############################################
# Se iau:
#- ~toate Acatistele noi bune, cu rug incep. si poze
#- din Acatistele vechi dar care nu sunt deja in cele noi ( Acastiste_DE_PASTRAT_DIN_ALEA_VECHI.txt )

BOOK_TYPE=Acatiste
echo "Processing $BOOK_TYPE"
mkdir -p $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/
SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/Books_dox_with_rug_incep/acatiste
OLD_SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/Acatiste/old_acatiste
cd _PRELUCRARE_EPUBss/${BOOK_TYPE}/

## Pune pe cele vechi si cele noi nu le au
O=0
while read take; do
  cp  "$OLD_SRC_GOOD_EPUBS/${take}" $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/
  #echo "takeing OLD: $OLD_SRC_GOOD_EPUBS/$take"
  (( O++ ))
done < ./${BOOK_TYPE}_DE_PASTRAT_DIN_ALEA_VECHI.txt

## Decide care din cele is bune (aproape toate: .old_epub si old_epub.x)
## 1. Le luam pe cele pentru care noi nu avem un echivalent
X=0
for x in old_epub/*.old_epub.x ; do
  take=$(basename -s ".old_epub.x" $x)
  #echo "takeing new old_epub.x : $SRC_GOOD_EPUBS/$take"
  cp $SRC_GOOD_EPUBS/$take $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/
  (( X++ ))
done
echo "Took: $X pentru care nu aveam echivalent"

# 2. Le luam si pe cele la care avem un echivalent, speram ca acestea sunt mai bune
N=0
for x in old_epub/*.old_epub ; do
  take=$(basename -s ".old_epub" $x)
  #echo "takeing new .old_epub: $SRC_GOOD_EPUBS/$take"
  cp $SRC_GOOD_EPUBS/$take $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/
  (( N++ ))
done

echo "Took: $X pentru care nu aveam echivalent"
echo "Took $N chiar daca noi avem un echivalent, (speram ca acestea sunt mai bune)"
echo "Took $O din OLD, pentru care ei nu aveau echivalent"

############################################
BOOK_TYPE=Rugaciuni
echo "Processing $BOOK_TYPE"
mkdir -p $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/
SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/Books_dox_with_rug_incep/rugaciuni
#cd _PRELUCRARE_EPUBss/${BOOK_TYPE}/
cp ${SRC_GOOD_EPUBS}/*.epub $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/

OLD_SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/old_rugaciuni
cp ${OLD_SRC_GOOD_EPUBS}/*.epub $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/

############################################
BOOK_TYPE=Canoane
echo "Processing $BOOK_TYPE"
mkdir -p $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/
SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/Books_dox_with_rug_incep/canoane
#cd _PRELUCRARE_EPUBss/${BOOK_TYPE}/
cp ${SRC_GOOD_EPUBS}/*.epub $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/

OLD_SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/old_canoane
cp ${OLD_SRC_GOOD_EPUBS}/*.epub $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/

############################################
BOOK_TYPE=Paraclise
echo "Processing $BOOK_TYPE"
mkdir -p $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/
SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/Books_dox_with_rug_incep/paraclise
#cd _PRELUCRARE_EPUBss/${BOOK_TYPE}/
cp ${SRC_GOOD_EPUBS}/*.epub $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/

OLD_SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/old_paraclise
cp ${OLD_SRC_GOOD_EPUBS}/*.epub $MERGED_FINAL_BOOKS_DIR/${BOOK_TYPE}/


############################################
echo "Processing Others (full folders)"

OLD_SRC_GOOD_EPUBS=_PRELUCRARE_EPUBss/old_others/
cp -r ${OLD_SRC_GOOD_EPUBS}/* $MERGED_FINAL_BOOKS_DIR/

