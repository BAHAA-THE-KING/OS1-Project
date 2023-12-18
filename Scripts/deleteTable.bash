#!/bin/bash

# Call the UserCanEditDB.sh script with $dbName argument
sh helpers/UserCanEditDB.sh "$dbName"

# Check the exit status of the previous command
if [ $? -eq 0 ]; then
    # Add your commands here if the condition is true
    :
else
    echo "Unallowed user!"
    exit 1
fi

# Run chooseDB.bash with argument 5
bash helpers/chooseDB.bash 5

# Specify the file paths
db="/OS1-Project/tmp/selected_db.txt"
table="/OS1-Project/tmp/selected_table.txt"

# Check if the file exists
if [ -e "$db" ]; then
    # Read the content of the file into a variable
    db_name=$(<"$db")
else
    echo "File '$db' not found."
    exit 1
fi


# Run choose_table.bash with $db_name argument
bash helpers/choose_table.bash "$db_name"

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


# Construct the full path to the table
table_path="/OS1-Project/Databases/${db_name}/${table_name}"

# Check if the file exists
if [ -e "$table_path" ]; then
       rm "$table_path"
        echo "File '$table_path' removed successfully."
    
else
    echo "Error: File '$table_path' not found."
fi
