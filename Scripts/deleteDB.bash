#!/bin/bash

bash /OS1-Project/Scripts/helpers/chooseDB.bash 2
if [ $? -ne 0 ];then
	echo Error, Error Code $?
	exit 1;
fi

selected_db=$(< /OS1-Project/tmp/selected_db.txt)

cd /OS1-Project/Databases/$selected_db

file_count=$(ls -l | grep -v '^d' | wc -l)
if [ "$file_count" -gt 2 ]; then 
    echo "This DB has tables , DELETE them then try again"
else 
    
    cd ../
   bash /OS1-Project/Scripts/log.bash "delete" $selected_db
    rm -rd $selected_db
    
    echo "THE DB = $selected_db DELETED SUCCESSFULLY" 
  
fi

