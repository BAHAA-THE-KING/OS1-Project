#!/bin/bash

#get DB Name
bash /OS1-Project/Scripts/helpers/chooseDB.bash 9
if [ $? -ne 0 ];then
	echo Error, Error Code $?
	exit 1;
fi
db_name=$(< /OS1-Project/tmp/selected_db.txt)

# Run choose_table.bash with $db_name argument
bash /OS1-Project/Scripts/helpers/choose_table.bash $db_name
if [ $? -ne 0 ];then
	echo Error, Error Code $?
	exit 1;
fi
selected_table=$(< /OS1-Project/tmp/selected_table.txt)

cd /OS1-Project/Databases/$db_name

echo "1- delete all data from $selected_table"
echo "2- delete specific data from $selected_table"
read -p "Wich DB do you want to select: " select_number_option
  
case $select_number_option in 
  1) 
    truncate -s 0 $selected_table.txt
    echo "THE DATA FROM TABLE $selected_table DELETED SUCCESSFULLY"
    ;;
  2)
    read -p "Enter a value you want to delete based on: " user_value
    sed -i "/$user_value/d" $selected_table.txt
    echo "THE ROWS DELETED SUCCESSFULLY"
    ;;
  *) 
    echo "Invalid choice"
    ;;
esac
