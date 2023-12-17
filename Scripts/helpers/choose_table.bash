#!/bin/bash

#param $1 DB name
dbName=$1

#get tables
cd /OS1-Project/Databases/$dbName/

#view tables with numbers
j=0
for table in *
do
  if [ $table == "$dbName.config" ]; then
  	continue
  fi
  ((j=j+1))
  echo "$j - $table"
done

#let user choose
echo 'Choose A Table:'
read tableName

#return the choosed table name
j=0
for table in *
do
  if [ $table == "$dbName.config" ]; then
  	continue
  fi
  ((j=j+1))
  if [ $j -eq $tableName ];then
	echo $table
	exit 0
  fi
done
