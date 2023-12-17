#!/bin/bash

#param $1 operation number according to order
operation=$1

#define some helpers
getUserType(){
	local user=$1
	local owner=$2
	local dbname=$3
	
	#if user is admin
	if grep -q $user "../admins.txt"; then
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

#view db with numbers
if [ ${#list[@]} -eq 0 ];then
   echo "No DBs Available"
   exit 1
fi

i=0
j=0
for elm in ${list[@]}
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
for elm in ${list[@]}
do
  ((j=j+1))
  if [ $j -eq $dbNum ]; then
  	echo ${list[i]}
  	exit 0
  fi
  ((i=i+1))
done

echo "Invalid Option"
exit 1
