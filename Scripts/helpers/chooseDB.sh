#!/bin/bash
#get dbs
cd ../../Databases
#filter dbs
user=$(whoami)
list=( )
for folder in *
do
    if [ -d $folder ]; then
        if groups $user | grep -q $folder; then
        	echo $folder
        fi
    fi
done
#view db with numbers

#let user choose
echo 'Choose A DB:'
read dbName
#return the choosed table name
ls | nl | grep $tableName | cut -f2-
