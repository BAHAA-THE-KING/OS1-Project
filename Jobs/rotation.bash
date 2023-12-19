#!/bin/bash
dbname=$1

limit=$((1024)) #1GB
cd "/opt/backups/$dbname"
file_count=$(ls -l | grep -v '^d' | wc -l)
if [ $file_count -gt 6 ]; then
	oldest_file=$(ls -t | tail -n 1)
	rm -rd $oldest_file
elif [ $(du -s -b | awk '{print $1}') -gt $limit ]; then
	oldest_file=$(ls -t | tail -n 1)
	rm -rd $oldest_file
fi
