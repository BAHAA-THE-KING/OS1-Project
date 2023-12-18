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
echo "2- Restore data base"

read -p "Enter ther number of your choice: " choice

case $choice in 
 1)
   bash /OS1-Project/Scripts/helpers/chooseDB.bash 10
   if [ $? -ne 0 ];then
     echo Error, Error Code $?
     exit 1;
   fi
   dbname=$(< /OS1-Project/tmp/selected_db.txt)
   
   echo "1- Backup now"
   echo "2- Time Backup"
   read -p "Which type of compression do you want: " com_type_choice
   case $com_type_choice in
   	1)
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
				echo "1- Daily"
				echo "2- Weekly"
				echo "3- Monthly"
				read  -p "Choose Time: " timing_function
				if [ $timing_function -eq 1 ]; then
					time='0 0 * * *'
				elif [ $timing_function -eq 2 ]; then
					itme='0 0 * * 1'
				elif [ $timing_function -eq 3 ]; then
					time='0 0 1 * *'
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
				sudo crontab "$tmp_file"
				sudo rm "$tmp_file"
				;;
			2)
				
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
   echo "resstore"
   ;;
 *)
   echo "Invalid choice"
   ;;   
 esac
