#!/bin/sh
echo "Please select the file from the list"
files=$(ls *.rb)
i=1
for j in $files
do
  echo "$i.$j"
  file[i]=$j
  i=$(( i + 1 ))
done
echo "Enter number"
read input
echo "You select the file ${file[$input]}"
chmod -x ${file[$input]};