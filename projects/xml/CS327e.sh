#!/bin/bash

files="makefile XML.html XML.log XML.py \
RunXML.in RunXML.out RunXML.py SphereXML.py \
TestXML.py TestXML.out"

tempdir=verifytemp

if [ ! -e "XML.zip" ]
then
  echo "Error: Couldn't find XML.zip"
else
  echo "Found XML.zip."
  [ -d $tempdir ] || mkdir $tempdir
  cd $tempdir
  echo "Extracting the archive..."
  unzip -n ../XML.zip
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
