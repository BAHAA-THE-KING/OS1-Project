#!/bin/bash

#param $1 operation number according to order
operation=$1

#define some helpers
getUserType(){
	local user=$1
	local owner=$2
	local dbname=$3
	
	#if user is admin
	if grep -q $user "/OS1-Project/admins.txt"; then
		return 1
	#if user is owner
	elif [ $user == $owner ]; then
		return 2
	#if user in group
	elif groups $user | grep -q $dbname; then
		return 3
	#if user not in group
	else
		return 4
	fi
	}

#get dbs
cd /OS1-Project/Databases/

#filter dbs
user=$(whoami)
list=()
for folder in *
do
    if [ -d $folder ]; then
	type=$(awk '{print $2}' <<< $(grep type ./$folder/$folder.config))
	owner=$(awk '{print $2}' <<< $(grep owner ./$folder/$folder.config))
	getUserType $user $owner $folder
	userType=$?
	
	case $operation in
	1)
	   echo "You Are Creating DataBases, Why See The Old Ones ???"
	   exit 1;
	   ;;
	2 | 3 | 4 | 5 | 6 | 9 | 10 | 11)
	  #Just Admins And Owner
	  if [ $userType -eq 1 ]; then
	  	list+=($folder)
	  elif [ $userType -eq 2 ]; then
	  	list+=($folder) 
	  fi
	  ;;
	7 | 8)
	  if [ $type == 'public' ];then 
	  	#All Members
	  	list+=($folder)
	  elif [ $type == 'private' ];then 
	  	#Just Admins And Owner And Group
	  	if [ $userType -eq 1 ]; then
	  		list+=($folder)
	  	elif [ $userType -eq 2 ]; then
	  		list+=($folder) 
	  	elif [ $userType -eq 3 ]; then
	  		list+=($folder) 
	  	fi
	  fi
	  ;;
	*)
	  echo "Invalid Option"
	  exit 1
    	esac
    fi
done

# Specify the directory path
tmp_dir="/OS1-Project/tmp"

# Check if the directory exists
mkdir -p "$tmp_dir"
touch "/OS1-Project/tmp/all_dbs.txt";

#return the choosed table name
echo ${list[i]} > "/OS1-Project/tmp/all_dbs.txt"
exit 0
