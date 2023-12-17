#!/bin/bash
#get db name
dbName=$1
#get tables
cd ../../Databases/$dbName
#view tables with numbers
ls | nl
#let user choose
echo 'Choose A Table:'
read tableName
#return the choosed table name
ls | nl | grep $tableName | cut -f2-
