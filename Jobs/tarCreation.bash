#!/bin/bash
dbName=$1
timestamp=$(date +"%Y%m%d_%H%M%S")
cd /OS1-Project/Databases
cp -r $dbName $dbName$dbName$dbName
tar -cvf $timestamp.tar "$dbname$dbname$dbname"
rm -rd $dbName$dbName$dbName
sudo mkdir -p /opt/backups/$dbName/
sudo mv $timestamp.* /opt/backups/$dbName/
