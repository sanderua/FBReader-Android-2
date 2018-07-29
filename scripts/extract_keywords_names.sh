cd /mnt/c/_me/android/FBReader-Android-2/fbreader/app/src/main/assets/data/SDCard/Books/Acatiste/new_acatiste

#echo "generating list of all *.epub (old and new)"
#ls *.epub > all
echo "generating list of new acatiste:"
ls *.epub | grep -v " " >new

## Remove from keywords list the ones that don't differentiate strongly
NON_DIFERENTIATING_WORDS='0 epub acatist acatistul sf sfant sfantului sfintei sfintelor sfintilor sfintii imn inchinat'
echo "Removing the NON_DIFERENTIATING_WORDS like: $NON_DIFERENTIATING_WORDS :"
## cel mare mari de
## Extracting the keywords
for x in `cat new`; do 
  echo "processinf ndk for file: $x"
  echo $x | tr '.' '-' | tr '-' '\n' >$x.keywords
  for ndk in $NON_DIFERENTIATING_WORDS ; do
    # delete the non-diff-word:
    sed -i "/^$ndk\$/d" $x.keywords 
  done
done

## now let's sort keywords: put common words (less differentiating) to the end of list
LESS_DIFERENTIATING_WORDS='evanghelist apostol apostoli intai arhidiacon cuvios cuvioase ierarh ier mucenic mucenici mucenice mucenite mc preoti marturisitori parinti doctori martir martiri stareti staretilor mironosite imparatati intocmai cu apostolii imparatese imparateasa'
echo "Repossitioning the LESS_DIFERENTIATING_WORDS=$LESS_DIFERENTIATING_WORDS at the end of the list"
for x in `cat new`; do 
  echo "processing ldk for file: $x"
  for ldk in $LESS_DIFERENTIATING_WORDS ; do
    #set -vx
    LDK=`cat $x.keywords | grep -x $ldk`
    if [[ -n $LDK ]]; then
      # remove the word from its current possition
      sed -i "/^$LDK\$/d" $x.keywords 
      # put it last in file
      echo $LDK >> $x.keywords
    fi
    #set +vx
  done
done
