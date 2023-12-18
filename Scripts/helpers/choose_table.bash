#!/bin/bash
source ~/OS1-Project/project_init.sh
#get db name
dbName=$1

#get tables
cd $DATABASES_PATH/$dbName
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
