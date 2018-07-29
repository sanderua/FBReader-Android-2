## This script tries to match old acastists names with the newly downloaded list
## and idenfity the duplicates.
## It creates an old_epub file for every new acatist, writing inside the possible matches
## from the old list.
## After running it, there is a lot of manual work to double check.
## Don't run it again, as it will overwrite the already fixed run from date 7/7/2018

echo "Are you sure you want to rerun??? It will delete all the previous manual fixes!!!"
read
read
echo "nothing has been chanced, bye" && exit

set -vx
rm new all old old.tmp
set +vx
cd /mnt/c/_me/android/FBReader-Android-2/fbreader/app/src/main/assets/data/SDCard/Books/Acatiste/
echo "generating list of all *.epub"
ls *.epub > all
ls *.epub | grep -v " " >new
cp all old # init old with everything
echo "generating list of old acatists"
for x in `cat new`; do cat old | grep -v $x >old.tmp; mv old.tmp old; done
echo "now old has really the old files"
for new_epub in `cat new`;do
  echo '#Trying field 1'
  for word in `echo $new_epub | cut -d"." -f1 | rev | cut -d"-" -f1 | rev `; do 
    echo "---------------------------------------------------------------------------- processing keyword: $word, and we got these old epubs:"
    grep -i -w $word old | tee $new_epub.old_epub.f1
  done

  file_size_field1=`cat $new_epub.old_epub.f1 | wc -l`
  [[ ! -s $new_epub.old_epub.f1 ]] && rm -f $new_epub.old_epub.f1
  
#  if [[ $file_size_field1 -lt 1 || $file_size_field1 -gt 300  ]]; then
    echo '#Trying field 2'
    for word in `echo $new_epub | cut -d"." -f1 | rev | cut -d"-" -f2 | rev `; do 
      echo "---------------------------------------------------------------------------- processing keyword: $word, and we got these old epubs:"
      grep -i -w $word old | tee $new_epub.old_epub.f2
    done
#  fi

  file_size_field2=`cat $new_epub.old_epub.f2 | wc -l`
  [[ ! -s $new_epub.old_epub.f2 ]] && rm -f $new_epub.old_epub.f2

#  if [[ $file_size_field2 -lt 1 || $file_size_field2 -gt 300  ]]; then
    echo '#Trying field 3'
    for word in `echo $new_epub | cut -d"." -f1 | rev | cut -d"-" -f3 | rev `; do 
      echo "---------------------------------------------------------------------------- processing keyword: $word, and we got these old epubs:"
      grep -i -w $word old | tee $new_epub.old_epub.f3
    done
#  fi

  file_size_field3=`cat $new_epub.old_epub.f3 | wc -l`
  [[ ! -s $new_epub.old_epub.f3 ]] && rm -f $new_epub.old_epub.f3

  smallest_non_zero=`ls -S $new_epub.old_epub.f* | tail -1`
  mv $smallest_non_zero x$smallest_non_zero
  #rm $new_epub.old_epub.f*
  mv x$smallest_non_zero $new_epub.old_epub
  touch $new_epub.old_epub # generate even of smallest_non_zero

  #declare -A file_sizes=( ["f1"]=$file_size_field1 ["f2"]=$file_size_field2 ["f3"]=$file_size_field3 )

done
