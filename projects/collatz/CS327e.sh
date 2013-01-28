#!/bin/bash

project=Collatz
zipfile=$project.zip

files="README.txt $project.html $project.log $project.py makefile Run$project.in Run$project.out Run$project.py Sphere$project.py Test$project.py Test$project.out"

tempdir=verifytemp

if [ ! -e "$zipfile" ]
then
  echo "Error: Couldn't find $zipfile"
else
  echo "Found $zipfile."
  [ -d $tempdir ] || mkdir $tempdir
  cd $tempdir
  echo "Extracting the archive..."
  unzip -n ../$zipfile
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
