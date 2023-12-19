#!/bin/bash

#get DB Name from /OS1-Project/tmp/selected_db.txt
bash /OS1-Project/Scripts/helpers/chooseDB.bash 5
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
dbnamePath=/OS1-Project/tmp/selected_db.txt

# Check if the file exists
if [ -e "$dbnamePath" ]; then
    # Read the content of the file into a variable
    table_name=$(< /OS1-Project/tmp/selected_table.txt)
 
    config_file="/OS1-Project/Databases/${db_name}/${db_name}.config"
    # Specify the string to search for
    # Use sed to delete lines starting with the specified string

    sudo sed -i "/^${table_name}/d" "$config_file"
else
    echo "File '$dbnamePath' not found."
    exit 1
fi

# Construct the full path to the table
table_path="/OS1-Project/Databases/$db_name/$table_name.txt"

# Check if the file exists
if [ -e "$table_path" ]; then
    rm "$table_path"
    echo "Table '$table_name' removed successfully."
    
else
    echo "Error: File '$table_name' not found."
fi
bash log.bash "delete" $db_name
