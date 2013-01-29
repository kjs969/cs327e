#!/bin/bash

files="README.txt makefile Collatz.html Collatz.log Collatz.py \
RunCollatz.in RunCollatz.out RunCollatz.py SphereCollatz.py \
TestCollatz.py TestCollatz.out"

tempdir=verifytemp

if [ ! -e "Collatz.zip" ]
then
  echo "Error: Couldn't find Collatz.zip"
else
  echo "Found Collatz.zip."
  [ -d $tempdir ] || mkdir $tempdir
  cd $tempdir
  echo "Extracting the archive..."
  unzip -n ../Collatz.zip
  echo "Done."
  for f in $files
  do
    echo -n "Checking for $f... "
    if [ ! -e "$f" ]
    then
      echo "ERROR: file missing from the current folder."
    else
      echo "Present."
    fi
  done
  cd ..
fi
