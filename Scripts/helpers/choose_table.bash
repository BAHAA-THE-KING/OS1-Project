#!/bin/bash

#param $1 DB name
dbName=$1

#get tables
cd /OS1-Project/Databases/$dbName/

#view tables with numbers
fileCount=$(ls | grep -v '/$' | wc -l)
if [ $fileCount -eq 1 ]; then
	echo "No Tables"
	exit 1
fi

j=0
for table in *
do
  if [ $table == "$dbName.config" ]; then
  	continue
  fi
  ((j=j+1))
  echo "$j - ${table%.txt}"
done

#let user choose
read -p 'Choose A Table: ' tableName
# Specify the directory path
tmp_dir="/OS1-Project/tmp"

# Check if the directory exists
if [ ! -d "$tmp_dir" ]; then
    # If it doesn't exist, create it
    mkdir "$tmp_dir"
    echo "Directory '$tmp_dir' created successfully."
	touch /OS1-Project/tmp/selected_table.txt;
# else
#     echo "Directory '$tmp_dir' already exists."
fi

#return the choosed table name
j=0
for table in *
do
  if [ $table == "$dbName.config" ]; then
  	continue
  fi
  ((j=j+1))
  if [ $j -eq $tableName ];then
  	echo ${table%.txt} > /OS1-Project/tmp/selected_table.txt
	exit 0
  fi
done

echo "Invalid Option"
exit 1
