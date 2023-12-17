#!/bin/bash

#params $1 operation number according to order
operation=$1

#get dbs
cd /OS1-Project/Databases/

#filter dbs
user=$(whoami)
list=( )
for folder in *
do
    if [ -d $folder ]; then
        list+=($folder)
    fi
done

#view db with numbers
i=0
j=0
for elm in list
do
  ((j=j+1))
  echo "$j - ${list[i]}"
  ((i=i+1))
done

#let user choose
echo 'Choose A DB:'
read dbNum

#return the choosed table name
i=0
j=0
for elm in list
do
  ((j=j+1))
  if [ $j -eq $dbNum ]; then
  	echo ${list[i]}
  fi
  ((i=i+1))
done
