#!/bin/bash
source ~/OS1-Project/project_init.sh
#get db name
dbName=$1
#get tables
cd $DATABASES_PATH/$dbName
#view tables with numbers
ls | nl
#let user choose
echo 'Choose A Table:'
read tableName
#return the choosed table name
ls | nl | grep $tableName | cut -f2-
