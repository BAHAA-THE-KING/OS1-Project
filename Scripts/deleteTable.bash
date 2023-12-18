#!/bin/bash

#get DB Name
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
table=/OS1-Project/tmp/selected_db.txt

# Check if the file exists
if [ -e "$table" ]; then
    # Read the content of the file into a variable
    table_name=$(<"$table")
    # Specify the file path
    config_file="/OS1-Project/Databases/${db_name}/${db_name}.config"
    # Specify the string to search for
    # Use sed to delete lines starting with the specified string
    sudo sed -i "/^$table_name/d" "$config_file"
else
    echo "File '$table' not found."
    exit 1
fi
table_name=$(< /OS1-Project/tmp/selected_table.txt)

# Construct the full path to the table
table_path="/OS1-Project/Databases/$db_name/$table_name.txt"

# Check if the file exists
if [ -e "$table_path" ]; then
    rm "$table_path"
    echo "File '$table_path' removed successfully."
    
else
    echo "Error: File '$table_path' not found."
fi
