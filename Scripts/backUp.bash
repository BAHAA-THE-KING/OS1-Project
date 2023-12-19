#!/bin/bash

ask(){
    echo "1- ZIP"
    echo "2- TAR"
    echo "3- GZIP"
    read -p "Which type of compression do you want: " com_choice
    return $com_choice
    }

createFileAndMoveIt(){
	local dbname=$1
	local type=$2
	cd /OS1-Project/Databases
     	cp -r $dbname "$dbname$dbname$dbname"
     	if [ -n "$type" ]; then
     		com_choice=$type
     	else
     		ask
     		com_choice=$?
     	fi
     	timestamp=$(date +"%Y%m%d_%H%M%S")
     	case $com_choice in
     	    1)
        	# Perform zip compression
        	zip -r $timestamp.zip "$dbname$dbname$dbname"
        	;;
    	    2)
        	# Perform tar compression
        	tar -cvf $timestamp.tar "$dbname$dbname$dbname"
        	;;
    	    3)
        	# Perform gzip compression
        	tar -czvf $timestamp.tar.gz "$dbname$dbname$dbname"    
        	;;
    	    *) 
        	echo "Invalid option"
        	;;
        esac
     	echo "copression success"
     	sudo rm -rd "$dbname$dbname$dbname" 
     	sudo mkdir -p /opt/backups/$dbname/
     	sudo mv $timestamp.* /opt/backups/$dbname/
	}

echo "Choose an option : "
echo "1- Create a backup"
echo "2- Restore database"

read -p "Enter ther number of your choice: " choice

case $choice in 
 1)
   echo "1- Backup now"
   echo "2- Time Backup"
   read -p "Which type of compression do you want: " com_type_choice
   case $com_type_choice in
   	1)
		bash /OS1-Project/Scripts/helpers/chooseDB.bash 10
		if [ $? -ne 0 ];then
		  echo Error, Error Code $?
		  exit 1;
		fi
		dbname=$(< /OS1-Project/tmp/selected_db.txt)
		createFileAndMoveIt $dbname
		;;
	2)
		echo "1- Schedule Backup"
		echo "2- Backup from date"
		read -p "Choose Method: " time_BU_com_choice
		ask
		com_choice=$?
		case $time_BU_com_choice in
			1)
				bash /OS1-Project/Scripts/helpers/chooseDB.bash 10
				if [ $? -ne 0 ];then
				  echo Error, Error Code $?
				  exit 1;
				fi
				dbname=$(< /OS1-Project/tmp/selected_db.txt)
				
				echo "1- Daily"
				echo "2- Weekly"
				echo "3- Monthly"
				read  -p "Choose Time: " timing_function
				if [ $timing_function -eq 1 ]; then
					time='0 0 * * *'
				elif [ $timing_function -eq 2 ]; then
					time='0 0 * * 0'
				elif [ $timing_function -eq 3 ]; then
					time='0 0 0 * *'
				else
					echo "Invalid Option"
					exit 1
				fi
				
				jobFile="/OS1-Project/Jobs/$(date +"%Y%m%d_%H%M%S").bash"
				mkdir -p /OS1-Project/Jobs
				touch $jobFile
				echo "#!/bin/bash" > $jobFile
				if [ $com_choice -eq 1 ]; then
					echo "./zipCreation.bash $dbname" >> $jobFile
				elif [ $com_choice -eq 2 ]; then
					echo "./tarCreation.bash $dbname" >> $jobFile
				elif [ $com_choice -eq 3 ]; then
					echo "./gzipCreation.bash $dbname" >> $jobFile
				fi
				tmp_file=$(mktemp /tmp/crontab.XXXXXX)
				sudo crontab -l > "$tmp_file"
				echo "$time $jobFile" >> "$tmp_file"
				sudo dcrontab "$tmp_file"
				sudo rm "$tmp_file"
				;;
			2)
				read -p "Enter the date (YYYY-MM-DD): " filter_date

				bash /OS1-Project/Scripts/helpers/getDBs.bash 10
				dbs=$(cat /OS1-Project/tmp/all_dbs.txt)
				
				cd /OS1-Project/Databases
				for folder in *; do
				    if echo $dbs | grep -q -w $(basename $folder); then
				    	if [ -d "$folder" ]; then
						last_modified_date=$(date -r "$folder" '+%Y-%m-%d')
						if [ "$last_modified_date" == "$filter_date" ]; then
						createFileAndMoveIt $(basename $folder) $com_choice
						fi
				    	fi
				    fi
				done
				;;
			*)
				echo "Invalid Option"
				exit 1
				;;
		esac
     		;;
	*)
		echo "Invalid option"
   esac
   echo "done"
   ;;
 2)
   #view all DBs that the user can restore
   bash /OS1-Project/Scripts/helpers/getDBs.bash 10
   dbs=$(cat /OS1-Project/tmp/all_dbs.txt)
   
   cd /opt/backups/
   
   list=()
   for folder in *; do
    if echo $dbs | grep -q -w $(basename $folder); then
    	if [ -d "$folder" ]; then
		list+=($folder)
    	fi
    fi
  done
  
  #let user choose db
  i=0
  j=0
  for elm in ${list[@]}
  do
	((j=j+1))
	echo "$j - ${list[i]}"
  	((i=i+1))
  done
  
  read -p "Choose DB To Restore: " dbnum
  
  i=0
  j=0
  for elm in ${list[@]}
  do
   	((j=j+1))
  	if [ $j -eq $dbnum ]; then
	 	dbname=${list[i]}
  	fi
	((i=i+1))
  done
  
  #let the user choose the backup
  cd /opt/backups/$dbname
  
  j=0
  for file in *
  do
	((j=j+1))
	echo "$j - $file"
  done
  
  read -p "Choose Backup To Restore: " bkpNum
  
  j=0
  for file in *
  do
   	((j=j+1))
  	if [ $j -eq $bkpNum ]; then
	 	bkpName=$file
  	fi
  done
  if echo $bkpName | grep -q ".zip"; then
  	sudo unzip $bkpName
  elif echo $bkpName | grep -q ".tar"; then
  unzip $bkpName
  elif echo $bkpName | grep -q ".tar.gz"; then
  unzip $bkpName
  fi
  ;;
 *)
   echo "Invalid choice"
   ;;   
 esac
